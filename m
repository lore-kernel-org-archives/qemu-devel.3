Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CD1EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjXL-0006SW-VL; Tue, 10 Feb 2026 03:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjXK-0006Rw-Ax; Tue, 10 Feb 2026 03:55:58 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjXI-0003PJ-SQ; Tue, 10 Feb 2026 03:55:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfmJDM54UwTCn/k9+VwMtXhudUNLgBdMsY5BUf6Akki1GZGoibYovlxIpzlbbFnq7IAa1vutB9dlrB8BUPptOf1GgMm1MAdkun1SuCt8JXeR1DAKe2vsf36wB7BKDuvZuWVTBCVnq0TGDbASrI7AqL00r98WW5jjzn1sJWGv1sj7K6XrKkdbEUHCVpdanOfpZ3YsXlfEXxVbwbGwI9qNJj/JZlQquhOtJIzgcSAn1QEybTLcf9mwiaqJoqJu2NDDCD4+ZaJ8c4tRE7UjszwCIdmsiIeDikBnR1h2WPLWTVR3NBQ0VNiT9sexzUG1Bq2MAmcFZO9UaamRGfLHYR+3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OaNsllnjbld86uxd3gwnGKbD/qvEydOK1ogfxpMWUA=;
 b=f9DCFdsnMyIE2b7RKFGYCfklEn5ydbHBaFhUsMOqqQdPWKKbwzr/58mnaG/31Im+Zqiw70XWJecPNnNK9y+o+W9Jdk0PaNbduKMXvlXor9RYtaH+IExv4XIAGIOSJYjoFy6RUM+cBu+NykgL0b1C+Prv/CxWjlSka5dia2+Q7kObqzz1FyJDyjJ2xT4lyd5Co2G+KCs0kxaosiIPRaZlsJKWfY5WffTYd+4F166WyWEUnl2S+UBK7Np5b1qqEGxqzkqmqnv548dYxUQSB4MOUSwaLkl9d9QjwEqwiaTwCurnOvC2pP3ChKP4+M6AtB4DejVghWzokk4IzGlnrkusEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OaNsllnjbld86uxd3gwnGKbD/qvEydOK1ogfxpMWUA=;
 b=F6+npShG78kFZm1p0Tr8WJ7Mhos07Ao4+V9djbQKPyyS43lnhz0mrQ/ALq71rYU66wHIVT28sEMgzV620fyH1KEtIqbuZmMcTMgdgcKrVH9ePRcb7sFktvXlC6eVOtzPUnjMQmqnE05aDs3+X1NMpy2a1tpSHL456/p/xvsCm63Fku4NBO9QcPvIsZR2JUuGtlGK8mwqYh8jLFb3BygV1SUPn3nfS8VzRYUQYPWovbms1TZyjr/k8bR9yDsr2ZF8n7Pcs0WzlnQG6MxshpXI0TtOU26u7nitH+kdgHafSgERfXmkVou7ccthchn49L2JF9Y86ThXj9mY+nwNvdw7/g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 08:55:49 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 08:55:49 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 14/24] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Topic: [PATCH v2 14/24] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs on
 base register programming
Thread-Index: AQHcl3fs3/ZlM0gpn0SUSMVuCDbH2rV7DaqAgACZbJA=
Date: Tue, 10 Feb 2026 08:55:49 +0000
Message-ID: <CH3PR12MB754813DCAF0E35701BAF04AEAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-15-skolothumtho@nvidia.com>
 <aYpx0baxoZWExE5/@Asurada-Nvidia>
In-Reply-To: <aYpx0baxoZWExE5/@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV8PR12MB9644:EE_
x-ms-office365-filtering-correlation-id: f9871c14-24f7-45f7-80a3-08de68822fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?krozGr8P17PdVtqbnx9Jy2joWDR2Rpn4GOqjqzwAOybr/XLuWZQSql+or1FY?=
 =?us-ascii?Q?REQ9XlYiy3g4O79PlgpIoyp1y5QmFx/gVQymeyvrCYqizYulwwIvTVvR3kwH?=
 =?us-ascii?Q?bwMz9jk1qWTBbnkfi51G2kLxcBvwSYYuTv9mPqsicxPWRv8nBjIMBbTkvrGF?=
 =?us-ascii?Q?ojCAxQUODlymeCBVv3Gqj5q/XF5l0ratKRMf2D7Qi1tFOPA74SnzYrhyP/n/?=
 =?us-ascii?Q?Dzo9UstDbbCATP0hH6ud0DfmIkVTBlv9H4XM7P2kP7KtxApEwJTPpNVZsQxo?=
 =?us-ascii?Q?WvW2iX1iqro8uR6WUlylUU29fM5H4l5IRtT9FOs0KrVo+sSmU2nxkmMAIhLT?=
 =?us-ascii?Q?BPl/LMtFgfNki13zpi4ltUrTfzBXXtLcIJp7xUi+ij9OrAJbzQuraKKgxwMb?=
 =?us-ascii?Q?v3dmOj4GG1gqPI/OJZqJ9ShycArbNPEsX6ThZi24J9x34AfFlENuP2Mr2qdq?=
 =?us-ascii?Q?JC+KcS0288nZUx0P3pLCXLeHX87aM7Syx1FuD5gsCb6yEoaQqy06wyiD2BaV?=
 =?us-ascii?Q?DD+nXfcqv7PdqRydC3jePAyNyhsJXuHJzdWsfWd3LCfMGAN653r/wx4kEwbm?=
 =?us-ascii?Q?1DrO/BnMYTUC1iFzHdA7hvE+JS3SoYfrCQy6Z1DvhUevUAb+kQWPVdC4+xHT?=
 =?us-ascii?Q?FPg5SCda5IqviWwPZqgJ1iHwdobYvvBtN9jwlN6n5b0V+P0qKdx61+FhvzF8?=
 =?us-ascii?Q?BpHWNQtsj70swBgpDnho5D08d/dPM0/hS/GKDK3SbUX+IBMHpYiv/zPFTcCz?=
 =?us-ascii?Q?TeHWq+oBfDIlgIiDSwF3+E8odqqKqcYGvHMpOwZ8ubqQVLL/U3k/Tu0QIYM7?=
 =?us-ascii?Q?SuzZAJFJKwevFjyRHN7qxyeXV9XmJyXCsDZaFGRPB6TC2w/Pz1vuNnaOQ215?=
 =?us-ascii?Q?iwx8t7ZV4DjdrglteHJefkwQsMvgmnO1H8/25Z7x4LDEZt3vnL1SXQsHnkSK?=
 =?us-ascii?Q?ZlVMgJU6ZD3JZcv8OViZ6adTBnuUS7m81cxVOLK873Si7ZT/pgNmM3JmXadQ?=
 =?us-ascii?Q?0rjHhwok80Ra9xlXia4YXadPDOz0sAadonz65vCIazyGb66uK3kMWQh0GYuk?=
 =?us-ascii?Q?qq2mgjwF/NIYS+Ajlv+vFl/VQyUC1l70ge/1R5dis6w5BQq+91zf2gnXdoe2?=
 =?us-ascii?Q?72Sw6uCLVU6/XQejVQQ0nFhRM2Siknmh9A1UwboEGs+IQwFNqJaRO9LCBq1H?=
 =?us-ascii?Q?MmGuGd7atVcxryN5cIKH67oDglQx+sfIax14cEZc6Dl5FYP5pt1KEaFsHfZa?=
 =?us-ascii?Q?l13A59UB3tK71wv3MWUUx/pUGxH9rMLBMcGd4fn1FlZmeXyGRVAuMV07gJKC?=
 =?us-ascii?Q?Bmk/WTImFIm8D8ctJrzK7X8tix14uIhK5B/hS48IW4rbGuPWlnSXJYYhGCsJ?=
 =?us-ascii?Q?RBAEVRI4T9ZB8qNmIlmVdKYem2p0zrA6P+ikpiaV3nT6CCHRP7UrcCZYYoxN?=
 =?us-ascii?Q?3ALs8QjrhCwfGY0kDgJWlg12Kd0wYhRC6ALdTViVv0AAJUZWwobJBKDl1X8R?=
 =?us-ascii?Q?sqD8CnCd+1i/9UVnGf8DDCfXF8hF+1jfZHOd0j3yVYJjqCgQOF165HLEpd0D?=
 =?us-ascii?Q?cNMFmZAhcE/vUPD/9DGLrmvscbDKIuT9faDR0Q6OMeP3eyFONam2x4Io/61U?=
 =?us-ascii?Q?ylbK1xWMzIbNSiA4L1dLbTM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uXj9wvW7DtIukq+NWRrw4P3E4qRqc5Aijx+Js5etX0m3RtjvD54vP1CvvTPR?=
 =?us-ascii?Q?v4IDv5uJ3h8ccUyr87IOJoZUUti+Ec7adbwpz/x7jjC7j3fU6bOJqF7/n3B2?=
 =?us-ascii?Q?xT3cuX4ZtBE2SCaRjRHobwJBNhBFDBHrCa9E6jBNZbIg8ktWsl/5vUcK5Uz+?=
 =?us-ascii?Q?THwyxfAUxwujVn7ONeVsvhz9utn52MhPwasDdoU2f+YkVtESygRdKCtU4ITW?=
 =?us-ascii?Q?BQ+3S/ajj27ZehPPfYC/ydRVEdlQMXkRbQaQehXQLdhpG4w8lFq1sK/QOpOw?=
 =?us-ascii?Q?iCTCsJuH2JUWEIs7BJKwAIUW1tNtcMx3qx1E/YKGCXQ8tWs3h4R5ZrvjycRw?=
 =?us-ascii?Q?yue0ZeouIcLCmd7KTU6GesAFhwAL+ma+PEO4EYdsXeDdTgGB9HF3Tp6Sl/At?=
 =?us-ascii?Q?5X0Wn7lAQngh+DCG1XyWpq9Aw0mNBim/7pk8NO5uXKrxB6yqAWEdvwLF6FDz?=
 =?us-ascii?Q?uh8iyUQSGg5kjJ6WkdYPfysJJpnFARdPmga2FJfPIfawJee90IHweH52wUoi?=
 =?us-ascii?Q?LiVbx5UJ7dYF5nzbWkoia8AzI7aeJ4we7JroxnLbn1R6WceTqyiQHBKxnBM/?=
 =?us-ascii?Q?wmrmknPMHq2HIpwG9oblkiO+p9giThv58mm0Frz4prODDoSQZ5nO7lPB8trJ?=
 =?us-ascii?Q?CCJXxo17xbBrZNbPS83W7hVC2I9/WJGiCT5V4vNyF5NCwG49HJstEShN3tpZ?=
 =?us-ascii?Q?H5Fk2KD3enUKsb1FVeycldelZx5KDfvRJi1MPkJpMVi52xQvZBFutthrHvVk?=
 =?us-ascii?Q?1BkrUbAMkCKVf6CkY8gxiSsY+mXcnL9fJ99c8T+G510azpbeW30H73AehzFi?=
 =?us-ascii?Q?kpKu7tUiDWqg2eJKmsThv9GQ4ztRkguWkm/5b3SPvCp2wujHKuZ9woaOoC9m?=
 =?us-ascii?Q?lIheXDVaJjLBpw9579a1JyAfMs6wFwMsqQZ64hdIWN9lXBaiOPWDfgZMH1JM?=
 =?us-ascii?Q?695G1B93qNtqQDAgrycAc8HJEKvrqF7erFfF3uJjDwdDrtDF07E0aUUFBzwV?=
 =?us-ascii?Q?Yojjvxqz516BY0ni9edf8eHGrr9LbRzuyhZOZPHw4qaSr+wpuftLr/Uv52M1?=
 =?us-ascii?Q?/oxqmY1Z7aqyX0zEjEUL0SzRZge5bxgYRbgl49JFmw2J9FxrTud22OQj0fdT?=
 =?us-ascii?Q?Hg5iujXWRr5Nv2hdzxZJfh6OrLfqlR7WoGsndl3oNKOasDiSbIvDIsEPT7ZC?=
 =?us-ascii?Q?IuHEjrSO5z7dpzu7MTk78d/uDYP9UN2y26o3MQerHc9DPie5keYSwO3oDBtx?=
 =?us-ascii?Q?mIBgaGBM1P6rLQihw8+CzmLpddqieEou+Q52yyuZpDSdgSwh45+pOQvA4pWT?=
 =?us-ascii?Q?rKtwN1UyNNsaUY6+udc0Q4ZG3bt5fRtDNeDRCXg4KERmI5XtcS5FBy6iUh55?=
 =?us-ascii?Q?VdcKqe7kkeRx3huvFtoQKpQBX0v6lxNoN2Ra0OBvilaiSijCUkCdM05ukNXq?=
 =?us-ascii?Q?bLIXKK8bOwqn0XK6J6RcOjZ750X/rnNko7SkETSPmScES2DhRIHqGMVOXmkr?=
 =?us-ascii?Q?7MA7lbJTrtVFxPHMmXEyxiUxDwsmLJhyo6inwMf/oen1g9Qu0B3FOvh2BJcH?=
 =?us-ascii?Q?IWDZAaf+ZMWZNvoWzbSZgzQDJNXDmNIUnRD8ta8rYkIxLH8RGQ5PozJVvqMi?=
 =?us-ascii?Q?ADDCFCQ64OPCBle0SWIMDLl6P53WXzSRh9o+Oft1Asz478e7BTJ8RwkH9p58?=
 =?us-ascii?Q?Qu/4LQSY9vHxtR4aUX4uvwDBK+mz2NsHLc1WMoD6Sf/eH89+A7UYjMeXgCS7?=
 =?us-ascii?Q?XYPsjdJ0tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9871c14-24f7-45f7-80a3-08de68822fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 08:55:49.0423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PT4P4pGCEbcRg5WNl4ATK94V6JQjVjugrJ3aHK67S/Opvin7HQUB841HNljaRJSFRL5qIJ1qdDzImF5I0zDVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 09 February 2026 23:46
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 14/24] hw/arm/tegra241-cmdqv: Allocate HW
> VCMDQs on base register programming
>=20
> On Fri, Feb 06, 2026 at 02:48:13PM +0000, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > Add support for allocating IOMMUFD hardware queues when VCMDQ base
> > registers are programmed by the guest.
> >
> > When a VCMDQ BASE register is written with a valid RAM-backed address,
> > allocate a corresponding IOMMUFD hardware queue for the CMDQV device.
>=20
> Let's mention that this is because QEMU doesn't trap VCMDQ_EN bit,
> which is a part of VCMDQ_CONFIG register accessed via the mmap'd
> page0.
>=20
> > +static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int
> index,
> > +                                       Error **errp)
> > +{
> > +    SMMUv3AccelState *accel =3D cmdqv->s_accel;
> > +    uint64_t base_mask =3D (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
> > +                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
> > +    uint64_t addr =3D cmdqv->vcmdq_base[index] & base_mask;
> > +    uint64_t log2 =3D cmdqv->vcmdq_base[index] &
> R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
> > +    uint64_t size =3D 1ULL << (log2 + 4);
> > +    IOMMUFDHWqueue *vcmdq =3D cmdqv->vcmdq[index];
> > +    IOMMUFDViommu *viommu =3D accel->viommu;
> > +    IOMMUFDHWqueue *hw_queue;
> > +    uint32_t hw_queue_id;
> > +
> > +    /* Ignore any invalid address. This may come as part of reset etc =
*/
> > +    if (!address_space_is_ram(&address_space_memory, addr)) {
> > +        return true;
>=20
> We should probably check addr and size - 1 + addr?

Right. Will add.

Thanks,
Shameer

