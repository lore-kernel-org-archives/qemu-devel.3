Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DBDC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJQc-0007KZ-R1; Mon, 12 Jan 2026 10:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfJQ9-00074H-DG; Mon, 12 Jan 2026 10:01:38 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfJQ4-0002VE-KU; Mon, 12 Jan 2026 10:01:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLU/WstmNc8JENs7/5oyvR0SCHXS27LKLQ4zyAbaW+ltGigjf5oPzqcpwVMZw0Hp0t5a5Ir2GkXgLrsr6T3gDJm7HQdymYU3Pm1hDLrkxP73KgtNRwH93gPf0SyTLo2hADH1QSnCYw5dJHOBsD03lx1bv1w2bOnFj24ZaftRPQDiCpURdm0MdlUSyvjT8IJQI4MFwa/7G64aHzOhLi/nc9xqanjH6vOJKw67PB4s5qHkaaWSp3n88T/XJjUeE+2WrPTd+qweeCsZULpi7RUr8Z3pWgXOlVJem/YYu9eHm1QcGtm5zrtC9Q5dr4uKa0OMyO6JrMab84fhkuLGfZh0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs6nGgQ1leiCCqSkWO9StfNhJi/IJnr8WMo/4wpalVs=;
 b=adyP8GIpKXXAOvY5UltR1H4jdzrffB6Kec7ZhR0HoJL40tIknqxhbGf46Tukhc5MDt9tSTtMlr9bXyBnwtR/JYN8FX6GS5tQCcShn79QTWxz7qYaSms32y8mGins9dVR6OW5rxYPnB9q0PxPqBbGW3On9vT8mE1FDU8V8JvnIyqTZ4BTmzRcRXALVhvvR64buDBdNrULH5MTPH1niHTevoDNBGXMfLA+L0fVBoB/NEtV5o2RPDfOadaKOdZGCvitlJVtR9VXEtDIRPyVhuZbG49mTQFMQGuT1ICgqchkCzGztWE92qov33+r62Q6V9MrYvAGy2RVbsM8qTF52PMiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs6nGgQ1leiCCqSkWO9StfNhJi/IJnr8WMo/4wpalVs=;
 b=QXvqNJkt/xBFnqONa9xtFbOdoTbNLJ36/Q2E4VTM0+sE5bySwC9invxn5gcjVloeRaDR6p99h7swVn7vvMVx95oZB3A6WvwjmcWYgdBZuVoHECybwsEhibj8Lc9pHPpmL+jSmWyw+nKE0nVzhB/a0mpc7/TT1ynJXFRbs2EoxbQjShwTXU+Kc9v8TvMIts5V/YpyPjt8pTWyYSsxdKVJeO+Q5jFM6p4kaYy0idPG16V1FwBxEH7hOzZRABZhIbugCBeH78ms/IcDgPpFSSWsNnOqETlCR48IydKldReNRCkAIQjAvCDDScG3s15nxzyfBQ2Jy4Wh20blMsi8Bh2F0Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:01:14 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:01:13 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
Thread-Topic: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
Thread-Index: AQHcg0NmIofDyvvrj0mrc0xS48ivF7VOLyAwgAAjxgCAAEyl8A==
Date: Mon, 12 Jan 2026 15:01:13 +0000
Message-ID: <CH3PR12MB7548A36B20A7A4B96CE214EBAB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-18-skolothumtho@nvidia.com>
 <526B3AB7-B0D4-4104-AF8F-012ED34EC990@unpredictable.fr>
 <CH3PR12MB7548B4E80C4660147906DC6CAB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <8ACCC1BD-8696-4A02-A295-269713AB0614@unpredictable.fr>
In-Reply-To: <8ACCC1BD-8696-4A02-A295-269713AB0614@unpredictable.fr>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB7114:EE_
x-ms-office365-filtering-correlation-id: 244747d9-9c4d-44b2-95f7-08de51eb6deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?M/a/AvgLssVD0Ppkgo0c9bpY6iUla6k/8aktGm9nvYcpUhCSsFMy/TmY5SvE?=
 =?us-ascii?Q?VG+qN08kAsbjX3l7UScHZ3RK0g0gYXNK/oWiHMIKu1hHcI2Ro2vSg3Ix4PrT?=
 =?us-ascii?Q?AUIb3wd39j4ydPUR0bGjm46gdnW8gPLk/YgQLJBpW8Sp4DeVXTKZ0MqBO/Fo?=
 =?us-ascii?Q?rM0N42gG/0mAU6VcKHndsHk0sPZqMn/eaKWcJAUhdHqVe7Jfhe1IPDUehPYf?=
 =?us-ascii?Q?Dz9hU9dwpJ7QzhvVUXlEANKJJuWZjNyMF6ItPWn6pR4wzfL5TWPNcL5arKTS?=
 =?us-ascii?Q?nmB/1+RWbMMOmXmcuCaoN7POfpr0Qy3Tv1kR1/Wkx9lxlL4x7OenfB+sm+8P?=
 =?us-ascii?Q?X+NDobGhma2wjIVfYdMYD/LiZttx9VNc7Hkim/fcIe+dnH1LWFZ5PViZZ1Tk?=
 =?us-ascii?Q?11Xlll1cOjv5kE7m6+ewwG1iItjz7mHQEb6T1K4NYACg7sys30RWO16l8wUq?=
 =?us-ascii?Q?maMEgYdStcUd0syDAy1Do/F+qNH+oCRDpS3f31XwY0Wr5tlBynbvQTf4OVwJ?=
 =?us-ascii?Q?Yxp6ILV13b72EEHwmSDTe955++UcdCovFsGCDssnG2WrEleVEPohcLPPRHdp?=
 =?us-ascii?Q?6/68u/AVsLDiG94Oyctglrn4FMZ/z7teoxLs+e1WdGtqcne3otfMq34NCkZs?=
 =?us-ascii?Q?9TeSIQyjHSJYD1LqNTV6iwAWO6ro7Vjc/pruHpclJz5GyKIzytza3gdRhmlg?=
 =?us-ascii?Q?kyhyErtGgP+UOLLhxiaBOE0eUkS5GiKHZ8fTeReDxEF2DC6c64UQhLjSPAiD?=
 =?us-ascii?Q?g1o8YuK2FZtXO7confW3yTp/BqvwwW2HUTmsYcKC3iIXVbuolCvW2uQURTsK?=
 =?us-ascii?Q?z3R6vxjw3PSs2WT2b6q5kIIPaI46DsEEOFWmvaQ2zeVN9neU/LvvQ53huaFN?=
 =?us-ascii?Q?yBY6T+mhW73iBddOnjASbfpE8SOuJCkKrCFbXIYuwqV4ZldltqTmqaUwPG7u?=
 =?us-ascii?Q?6JTYpmOw+qTPw5GyoTbpt7e+xYFy5D9LhYw/GggdQdl0N3EDo/h/e12jnqc7?=
 =?us-ascii?Q?zgDBWN17VgUsHJX4u3yy5o/cfbDV8tRhutm//TNBbc3XvOGzzbtvP+/MXnUY?=
 =?us-ascii?Q?zYwOzs6A0EUvuHhEppilzR/f4/QOthTtmPYHX76vBYXtxD+Aj/9aMD/x+UKD?=
 =?us-ascii?Q?toiYptlW9HMjY8NcfXSDkPgcOj2VrxlGheP7UJqvXT4xz2PbsOn+Enf8eABv?=
 =?us-ascii?Q?sP7SJC2Kwt6/LnfXkOPz3srXCIuJujdKFPvTbQplmkXv+nUdBvUrFw0SzHtW?=
 =?us-ascii?Q?duJD4Uw9dw7Epronfg/zQM7BbCdWI+ZXRcColK5HBceQgijGc/nWt32aKrrV?=
 =?us-ascii?Q?PGt5CWT1rDImEo2q5RVrCsZCD5bBSsA4cYUA20chBBb4ua3nlFA0luJSYBHQ?=
 =?us-ascii?Q?AX3eA/xGFHaopNE0ngQDyOTXg9MnyB3SiI2IkPFztqQQTV5LMn4SjNrIAQLa?=
 =?us-ascii?Q?b3TvwgtUHHTdfGi3tOIp1EYtsCCFZaRWmKUw816+EA91wtAuOCXoZ7cF6lbl?=
 =?us-ascii?Q?VE2k+9LsQ23HHnKb6exwsXpadlfipE0FieEV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HTEOvnRhFxTJU06P/0BUYi6x/ZJAlJV8ulJ0A2fKq6f1+2aVQvWlpLgSBGFB?=
 =?us-ascii?Q?hNXKBHJ+B8IxhbTQmndRR4jVZdwpEN5plzuR4TEjlLsAPe+zUgQMkO0Kcvzu?=
 =?us-ascii?Q?kKPEj2zgmCmIuAeSGep4pufUiWj/H0fjeuyrQzjBy6CKuj1xYxXkzNiXj9Lz?=
 =?us-ascii?Q?FETrYfEr43uG0/VAXpKVvEltBWOfRl1lgeCZq1KmkKqunScWQEKLhXXg/3W5?=
 =?us-ascii?Q?/Pb3JxBuiVU5eu02gAUuw7hQLSYbX8iugsAMZmDyLo1xSfx2pqiNPQHEEgSu?=
 =?us-ascii?Q?ot06gI+3uQgRyc2OOQehlWcP0v65bovEtKLuCTuhpYiLnOlQX43UNt7SWvMR?=
 =?us-ascii?Q?oSawDiErNiRaD3wML5O0DHuOvFdtNgp//VPi/+K9oLBDNnYHXwMFIIYLh1yi?=
 =?us-ascii?Q?+BdWy7zuGcj4D74Kbb5optJEe7Bf57pjWwzyGXKT4vcmJV31IwT3qkCDAXFI?=
 =?us-ascii?Q?wid1UByRUbe1ZkYyvPwJsYt2jzU3Fy/7fzy1edST67/JkrjRrfz9LFqJ0y97?=
 =?us-ascii?Q?mfpVO2/Hd3GL8++QOizX9fnB7MkSSgmRPoc9EiTrBwapWudFizmEYYxUGN+p?=
 =?us-ascii?Q?1DZF6Ux0T4w8XFuSS9B+shTY+VyJfGc07iRzzVIkBjbHAUjBAjKosgXe/g8K?=
 =?us-ascii?Q?3mRV/Mf50zIuVjb2u9zQN68L12+IQkDPY2ymenhmhFwW4K4l9NtXrpsOBVyU?=
 =?us-ascii?Q?qjczn8pE9NwFbdyFbON4ky+z2njgFze4xIG6d22ft0op9ywn8WyoT1Kh1Yxr?=
 =?us-ascii?Q?KTzVMfTDrzTT4JzUeYDnfix0xPRYoxe6/KFnqcdWF3VG+RpvCYFAZyhaNvss?=
 =?us-ascii?Q?sm/fGsl6uwNpfuTM12rWXS4zzRBcL7OH+mxQ/werUYIuWmFEmst7wn6Py5vV?=
 =?us-ascii?Q?pIcrim9OCD8eI2jym2VpfQM0tIpLSZWJlsb7agFQOQKstYPKweQGAiFNBFFG?=
 =?us-ascii?Q?oEZRlj2XGQxBJgY+/vuuTGqNOFjqxyvJbhjMlhD+QZj7ivl0E/89OdOog3hv?=
 =?us-ascii?Q?DMnlTrznfmModmfFhto9YnraqlxY6NcjS0/hHAFc0Rb3d1HHouezz0H7w3JY?=
 =?us-ascii?Q?YxtvOCsUgwC/jQO4VYk3IcgkHntr3PFB1eqKeO5DppIKkkzOnPavnVhHFIgo?=
 =?us-ascii?Q?rKK9UKDOoaVMlAj+Qe1eOJpVA7N7CiYz2jlEcsj6osOH/nNA7h2X0d/sAWuq?=
 =?us-ascii?Q?J+6E9iXOxFD8mL7lK0RV66+5SQc+oUejvMaYSqAbP6aCSH1mGQoB5CjRLJO5?=
 =?us-ascii?Q?bGh4Jl7umgYwPBV+Zuc9sXw69JcK0oUtodtnvH5ePqCfcmdwDF4xMs9gyPRE?=
 =?us-ascii?Q?YXuBzLagAIoalaYMrGiVYj7ct0hY6A/zC4+wZgPD/HhTmEkvM4Inyzr8ebCM?=
 =?us-ascii?Q?gWwIwJ1PkHjeFLMVmj8W9aElyoO4RO4GkW4pGbMG4vbyK4hZqkU91/juks1G?=
 =?us-ascii?Q?2Zg3r7wzEDb86JWLdygEXzvoUOzURa9PV8zIq8lL0adot5WMKRjxOqgcVJTO?=
 =?us-ascii?Q?IKRT4tYx544608y0T8aaWR60GgsaJY33x/1M2tw/uQSYvwPV4JXRrcD0BvcO?=
 =?us-ascii?Q?wa+f7dygCrxCM5sBOKogMlQwM6/GjCmLzy3EyefjMkyLMEQcAcYczM7QQUG5?=
 =?us-ascii?Q?zVLOE4KYSVWaNd8fiJg0KjCXHpHSODxQpBVIPBtajlaBKOLRwl3sLusqRuAd?=
 =?us-ascii?Q?+hYuNR9SdsRnftFL2TNXf81TfzeamZbW9p93Mu527PVBIy8UNJaIQ1fsC8Rw?=
 =?us-ascii?Q?EaIbs4qDwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244747d9-9c4d-44b2-95f7-08de51eb6deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 15:01:13.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0De3tJ8YbRIVmpdydKYYF7unnnDM8BIrvT1cRLxPLn4TXxlXgMlsnuyh+u9SI8qIbwqmPI+3/VAPY01YLXBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> Sent: 12 January 2026 10:18
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> berrange@redhat.com; clg@redhat.com; alex@shazbot.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> > On 12. Jan 2026, at 10:45, Shameer Kolothum
> <skolothumtho@nvidia.com> wrote:
> >
> >
> >
> >> -----Original Message-----
> >> From: Mohamed Mediouni <mohamed@unpredictable.fr>
> >> Sent: 11 January 2026 21:44
> >> To: Shameer Kolothum <skolothumtho@nvidia.com>
> >> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> >> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> >> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> >> ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
> >> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> >> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> >> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> >> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> >> Krishnakant Jaju <kjaju@nvidia.com>
> >> Subject: Re: [PATCH v7 17/36] hw/arm/virt: Set msi-gpa property
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >>> On 11. Jan 2026, at 20:53, Shameer Kolothum
> <skolothumtho@nvidia.com>
> >> wrote:
> >>>
> >>> Set the MSI doorbell GPA property for accelerated SMMUv3 devices for
> use
> >>> by KVM MSI setup. Also, since any meaningful use of vfio-pci devices =
with
> >>> an accelerated SMMUv3 requires both KVM and a kernel irqchip, ensure
> >>> those are specified when accel=3Don is selected.
> >>>
> >>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> >>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> >>> ---
> >>> hw/arm/virt.c | 20 ++++++++++++++++++++
> >>> 1 file changed, 20 insertions(+)
> >>>
> >>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>> index 9d0568a7d5..08feadf0a8 100644
> >>> --- a/hw/arm/virt.c
> >>> +++ b/hw/arm/virt.c
> >>> @@ -3052,6 +3052,26 @@ static void
> >> virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >>>            /* The new SMMUv3 device is specific to the PCI bus */
> >>>            object_property_set_bool(OBJECT(dev), "smmu_per_bus", true=
,
> >> NULL);
> >>>        }
> >>> +        if (object_property_find(OBJECT(dev), "accel") &&
> >>> +            object_property_get_bool(OBJECT(dev), "accel", &error_ab=
ort)) {
> >>> +            hwaddr db_start;
> >>> +
> >>> +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
> >>> +                error_setg(errp, "SMMUv3 accel=3Don requires KVM wit=
h "
> >>> +                           "kernel-irqchip=3Don support");
> >>> +                    return;
> >>> +            }
> >>> +
> >>> +            if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS) {
> >>> +                /* GITS_TRANSLATER page + offset */
> >>> +                db_start =3D base_memmap[VIRT_GIC_ITS].base + 0x1000=
0 +
> 0x40;
> >>> +            } else {
> >>> +                /* MSI_SETSPI_NS page + offset */
> >>> +                db_start =3D base_memmap[VIRT_GIC_V2M].base + 0x40;
> >>> +            }
> >> Hello,
> >>
> >> Currently (but soon no longer the case for virt-11.0+), its=3Doff mean=
s no MSI
> >> controller at all instead of
> >> GICv3 + GICv2m.
> >>
> >> Would an else if with an error returned if no MSI controller is enable=
d be
> >> adequate?
> >
> > The MSI doorbell setup here is only required for MSI translation cases.
> > When ITS is off (and no MSI controller is present), passthrough devices
> > cannot use MSI/MSI-X, so no MSI translation is required. Is that right?
> >
> > If so,  skipping the doorbell setup is expected and correct, and return=
ing
> > an error would unnecessarily reject a valid configuration.
> Hello,
>=20
> Could it be better then to have an else if for the GICv2m case and a sepa=
rate
> else with setting db_start to 0 or something instead of an invalid (becau=
se not
> present device) address to make things clearer?

Sure, will do.

Thanks,
Shameer


