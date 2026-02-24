Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F18F3C986
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutcl-0003tI-4C; Tue, 24 Feb 2026 09:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vutck-0003l3-1t
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:42:54 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1vutci-0001VD-96
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:42:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niHKz1RZfnq7kZ51XI2mZKC0cIxdXchvjALaztJ122+huajNUITFaxNcwlemc3n8RYd44HD30HYwBuR5hmrP2Gj/v2z7CyHogIPQydibYflhqK5oJUYjvnzLBxlZOpzs52qXSAqDSZb+h48ZjMMpKWw/jAAR2up8vI00cB+UbcSYFqRyIWfjT03vmCMdYHeMNPeiAbte7ulCor20oMLvAZFBgQaQinIJ3hQ/APQE/sHltStLaZOyi8iE4pjrR6WenzTnYwAQuXriFQMiXamqs/Wsmr7F1ZIujiQLMDrZqfGZJ7aVQ9T61oTPEkDJCnGdVMlqKkIZIThYlgYn/FuoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x42Jk4IeqdyGleU5eMIvav6YwYFv+GCvUHoTpG+eS/8=;
 b=IotKHr7JthlEBrxd1JwUwSs4nzosGqshi3JK2nxZwHjEx5NuuuDHdOeWwgxLFf6giBDenC/8/9rcrgj+ryo4oN+mXv6+U/2mfBEr5sGa9gZ4cpPDrOF5IvpjkIQck8YzPsgAZz+tDu0Q6ydevRdrexkNan1ZD9Aphh6JUrif2cXeLmnRW1Unv5XIrwI20lVHjI0WZTLMLl+Q4jXjzgeIEZ9lir1Bow9BGrZiwAIoUISv1Aa9Yp1oxrGBrY3gnKRT2Iu0263vVsg1FzEc7z7FzjGL9L7InSyIXpERKbiBbzHFgfcBXr+kujVGYICh1xSiu7Q2SZkH+hzRqRY4ZdW0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x42Jk4IeqdyGleU5eMIvav6YwYFv+GCvUHoTpG+eS/8=;
 b=R0g2+gdxR2cTplpnLjvCSNDq6StzpIwqvfOTmytdR5Ww9ncUKOq0W5W5LNMwf/txfCA0Sqcu+6Ps8JCgfaen/JOGILb+AZsbTXfUbHE0uksyrLpRgp00JcxTRv3mvqvcXTUjOLJ+iLwDkdiBjflyxO/zmNp+cZ9RDSDXj4Q7Hc0eVSj4AvyVw/4g/Y9rLwFxK93MyfVK8hLIiEOMxTLl2N7siMYv+2/1SE4pt4dVoSRFk8VEru5CLQ7dKWsoSSPuKKBD9N8I0LKebGNkesa1bi314WPM40NoEd0ObjNa1rLg1cRC6bzUt8bi2Qk6U7lnUrVYRB+xFDam+UtaM2roUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:42:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:42:44 +0000
Date: Tue, 24 Feb 2026 10:42:43 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <aZ2449e8ucB8e3AJ@nvidia.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo>
 <20260223111302.00000081@huawei.com> <aZ2sylCydE9Js1ec@nvidia.com>
 <20260224085955-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224085955-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e63b227-14ca-4a94-b662-08de73b2f8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yJU8tHyKCK9UFdtiAaOE6mPk3ZnLLqg4psdogr8QRtV+peMS8zVOa+cvPWS/?=
 =?us-ascii?Q?zwe+1XQOkRId3DjJDHxirtQfaWYCSDJXe0m7IGdQtI0kAscy0vR1XzFyZaYQ?=
 =?us-ascii?Q?BPJxh/pwmy61iN2AnYtJl4VOCzHgfj3yfLwtuGrWD5Np9OGQiye5/9OfjmxJ?=
 =?us-ascii?Q?7XLXcU1h06dkoSxTMcWqlTToFwj6wMshccaUmoInuthDRMZ+CHCZlB/iPjzI?=
 =?us-ascii?Q?MBzstIEG4jSUQaPLfupJckme3+b/IJNdLG6YiP10ySPTEnoQtOUhyg8K0N9a?=
 =?us-ascii?Q?VqNvMQZ00hMluJ0RgVhKxWznatyrAXPlP37JSMKVkWwgyZiRj8ZbYoCaladg?=
 =?us-ascii?Q?orJQbsY5ktLzW4Fs7Hk3LSXhtPaBHTqRM8AB3w3ww0zPlUWg1eFAotvBM4dw?=
 =?us-ascii?Q?sOI1j62ySnnCaJcwo6AsOhXTLfEDVaM4QjcRZbGJgpkp1nbZtqrMGHck2c36?=
 =?us-ascii?Q?gTIt0sdwQfoQic87NLwLWIFIDiJhBSmcz3Uc66QvEYkc1XRkF7V4xhJ+Sd+G?=
 =?us-ascii?Q?H/FWXMtIASK0U7KCAt8sa2vXyO6xPjQcQREABwvo3/L2TF/1Pr4qzfaqTCzt?=
 =?us-ascii?Q?2KfPNHgPUSZdOEucDzwWOSalr7JCPgJiaNFIxM/iShFAo+E7EaZx9GJC/2+B?=
 =?us-ascii?Q?wCMsDJ3fzbh3Rts7b29nRAPYVTuiaba7NfdvEPMQaqmA95EsESkFnDwjzZsc?=
 =?us-ascii?Q?MTr0Q4lriZ4bN1YiJEp+ntekdMesEpVDjYdsKx87DXy+xL97wo9mKhsVwoim?=
 =?us-ascii?Q?peXcOlMieCESnfeL4AlKg3DsVpW97yI26cgtxC65CQs2EAayxN0YksGYp0Or?=
 =?us-ascii?Q?gZQcn1tRNouFa3PDizpySf71+Kzhbp+15BTXXuaExxfa4qvFRwu+vQj7YAhU?=
 =?us-ascii?Q?m9vFHYSuniXMweAZBXaKI2A0I6K6zJT6cfxAv1FRVYsRchHY6Bcs52dASn0r?=
 =?us-ascii?Q?Sr8WyHILfvKEaVIoQ8eBlmkCr1gK+Enm9DGk8xd1306Ew5BUFnNNaus0mL3u?=
 =?us-ascii?Q?oofw1LL4YluuiPwW+8vtooQtrVJQzopkvNI12PkH98ewTqthNhrIayEeQLkZ?=
 =?us-ascii?Q?iA001VceFyQXRCGugGLv/G7s6lvq8GSQ8529m7Hkx8ApAyJ8k4yAKl7yeeJ3?=
 =?us-ascii?Q?ZF6S9nEt7dilHZ4hWQmV476+ElMrWvdh/rMvygTIYXALViZ7sehcgBYDe+OD?=
 =?us-ascii?Q?9Nhb1pycE8wF3jT9CgBUhAYIt/5+x2ah/Y0ZO6waJOv7uiYdFhA2q/83qkEp?=
 =?us-ascii?Q?nhOHEJaFy4q30BLrr2dZM3/1eXRsm9/N1qBfCaASsXBGJw5IFaVKxtipJbod?=
 =?us-ascii?Q?vZV2sEcJ7i+wAYqbLzlwIJCOzR8Nd+tqZPkrZKfOMS5kUsnusIQreRmTFUAm?=
 =?us-ascii?Q?/g4h9bq38lxsf7FaXHzN0H2ihAmc84fQAxvl974AmPBVvcajbObzvN2ji0eh?=
 =?us-ascii?Q?RXbpESMeWWyX+knSBK1lc0SY0DzjSB6X02ED8t0obfG62ohvTd37swE0S87S?=
 =?us-ascii?Q?TNL3TGzBfc9TO9yHvwHOSsXlBbdUZZhkAwhRMQ0WQAOUJFVU5GtUDDUU4F1x?=
 =?us-ascii?Q?yW5hLbrufJoTF/QuAWI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?es91cph585t92NWWw8ahYoJj/eoMYxKMszjyJePvBnyjAl8pl62ekDFzlVQf?=
 =?us-ascii?Q?9H+Pb+17C7g6K9NP8820cFqGrxWVOceIdD/raFcy0eM/RPPu+DUDNEKtUp4G?=
 =?us-ascii?Q?nROokqTO9hMXosDn9/swgrOcL1pdLh1V1pTDpPwIP0jjfqKwxF1Dzxe2EIQs?=
 =?us-ascii?Q?laXfGJhr+sj/Fj0tmRb9U8tAumULIINk00BIXTkSstGBcecadIzRbjez1KZa?=
 =?us-ascii?Q?r+8FkX0k+d1wxnQBWGNnXscgIH6UofgERQlcfakE99Y5fwNAPbhqBtNxzn8O?=
 =?us-ascii?Q?cUs/NaleJP7Jm3WMsqhVp/LxZKE7Q/u46AYBwki9OB3LEMalYkTLspK3HkZJ?=
 =?us-ascii?Q?r+MWINhP2Cw9R+gggdMygurCmeQpiw3gAnoV8JAF+HckTcmfRlYcTSUlqJwd?=
 =?us-ascii?Q?QZGsN6Q0i4+DWZAelSYmUGhmeIw58wQlI/bN5Y/ws7UgpkAxHP8sNoHGX52X?=
 =?us-ascii?Q?5lXKZH8e/JE7RZ9I7t8GiSUrrq72qjMJt7p37p+cPALr/6kRkIaHzgre+Lkg?=
 =?us-ascii?Q?c1PQEq/vIphEIq3nudOfIO6PgdKXgxRvj/Egpao0sHKjiMdQxi3lU5J6gdMw?=
 =?us-ascii?Q?PT9NS64oQ/Bs+Pf5NkzZzW+Y6h7CftMnODQgxBfw3F20UR9NYhjCD0k4r32W?=
 =?us-ascii?Q?emsoNtysoSzOzo8fzgAKmLTNoVJx0XeU8yg4L0h7LXSaKNfOglF5iEBROlpb?=
 =?us-ascii?Q?zUXz0Es2mDkGZPtfAOz5UIyZXz43pib+UiTd4faCgVxKRtCa/AMQhqijPNKD?=
 =?us-ascii?Q?LYes5iiBXt+GtmlkKb12YEmNTHIQSaEnok/A7jcONDBW/jD3gDZnPqSac6f9?=
 =?us-ascii?Q?fLQyYPZBHQRwjeSSgn8qOyG07WPlXBPxnY+/LdkzzmwEN0yvtoptmcgTCW7u?=
 =?us-ascii?Q?UNRu6ZBWcqeK7TeejJmERcR/N2CMMdyshGqOE+PHW1uDr9AFO7scsC3L4kBL?=
 =?us-ascii?Q?YuWDgd/u5UWPT2UFI3BEX8RRCH66etfTNI5BoEgmAUE7Ekosb3imu+6LB92B?=
 =?us-ascii?Q?+AsCSktX6km3F5/YeupF/ntF53nRTvvyzsjnxKFwpx+OMZpGllDwCfKS0lJ4?=
 =?us-ascii?Q?i/B52OxEteXPyl2n+6nJlalDTF8T4UhcxRYJcqs7BefUXt2PnSUM9qrYnDg9?=
 =?us-ascii?Q?IlJeC/EHtd4uS6C0q7Z7WThKpVWNHbQbfFbeTVrbGwR1upXe2skJXpkSBoHd?=
 =?us-ascii?Q?l4mydAm9bCZQ/RsVpqbx+QSStJhDnJnHryt5PHntHF2i3ywZ9Khbo5rfQxb8?=
 =?us-ascii?Q?iLqZ0wv0G6zUU8qSSmWiZQPJMZ2Y4qitbwfbpcJNaMjImRoh0cRKsNEd1saY?=
 =?us-ascii?Q?Jax7F6QVhb6dN0idRXi3VJCm6LabnF4OW0m84jKrpLONQSRfFpdod/3aT/Ef?=
 =?us-ascii?Q?Po0pDYsMkbj5IhZk+NNcINL85TnreiOkqSLstmwDWIIIXjOtm37D32OQ+vaQ?=
 =?us-ascii?Q?aXQ0YjcSjKTkxHprQZStmYolA0rQJXiXLH0W8qp4/dxB8GajlW7EwNjml4SA?=
 =?us-ascii?Q?tvjQmaIJ5rY6Wnzz5fx4kBLHDP1M9zP9OB5rrwL50Z18giCbCIXWyNBGjj5D?=
 =?us-ascii?Q?qt0G3EayR56tYZAA2eMKzNNMflkVMcA4H/0p8Fgzi+5vZAbV6U6bMlfpZkt1?=
 =?us-ascii?Q?PATLPTdsNoBjkWQbpFSi945XzEXlSJjES0Xwi2lL4+zxaLW5RqbnfUvqsjND?=
 =?us-ascii?Q?A9TB/TILs/5VW3kFvFZhojlJCWpLyqPBDOeoyG1W4CfmlvOttuZXzH0BlI+F?=
 =?us-ascii?Q?Tz2yY8CUtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e63b227-14ca-4a94-b662-08de73b2f8af
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:42:44.8738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi3ORkKPew+HGvjckVZQkj2XJGiptzlw8x8W828o7RhDMYplnWHWWH8k0WCxxqNV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=jgg@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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

On Tue, Feb 24, 2026 at 09:01:30AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 24, 2026 at 09:51:06AM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 23, 2026 at 11:13:02AM +0000, Jonathan Cameron wrote:
> > 
> > > Ankit, can you give an example complete with table dumps please.
> > > 
> > > I'm a little unsure on where things are getting scrambled.
> > > Everything should be keyed of PXM.  Sounds like we have a bug
> > > somewhere but ordering shouldn't be relevant.
> > 
> > I understood the issue is Linux assigns the uAPI visible NUMA node
> > numbers based on the ordering. The proximity/etc internal to the
> > kernel (I thought) was OK?
> > 
> > Then the problem is that uAPI has developed meaning based on what the
> > bare metal HW does and now there are SW stacks that are expecting
> > these platforms to have certain NUMA IDs in the Linux uAPI. Sure you
> > can argue this is bad/etc/etc but the point of QEMU is to allow
> > creating VMs that closely match real HW and in this instance real HW
> > produces an ACPI table with a certain ordering and the SW is sensitive
> > to this ordering.
> > 
> > Even if there is some Linux bug mis-parsing the ACPI, then that still
> > should be addressed from a qemu perspective by providing the ACPI
> > construction that doesn't trigger any bug so existing VM images will
> > work under qemu.
> > 
> > Thus qemu needs a way to reflect the ordering on the command line to
> > properly emulate this system and accomodate the existing VM software...
> > 
> > Jason
> 
> Not arguing against this, but if there's a linux bug it is important
> to fix it as a 1st step. qemu work arounds for broken guests
> notwithstanding. then we can check how long the uapi has been around,
> how practical bugfix backport in linux is, and decide on whether
> a host side work around is worth it.

Yeah, Ankit should provide more details to check for kernel bugs, but
I fear it is more userspace bugs in practice :\

However, I think even if it is minor and easier to backport it still
doesn't matter. The CSPs all built their VM types for this HW with the
exepcted ACPI and this stuff is now very widely deployed. It makes no
sense for qemu to be incompatible with everything pre-existing...

Jason

