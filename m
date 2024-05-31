Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C2EC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3Om-00019i-IG; Fri, 31 May 2024 10:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1sD3Oj-00019T-HG
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:38:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1sD3Og-00080i-Hr
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:38:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44V9VWto030154; Fri, 31 May 2024 14:38:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DWZBt3YS3CaB0?=
 =?UTF-8?Q?V35uaXDzpqH4bvziTrRECF4vaX37Rvo=3D;_b=3DmusUkuIl2PzKtkN7rzdHMJN?=
 =?UTF-8?Q?xsnSkuWqqM9So+iEMKRMdmN9yrcmdDvE6odbEtJONglpa_7pxNYHVqOKzg7EFVE?=
 =?UTF-8?Q?NO1UQ3mK/bR6tcL0eMY2xny8w8vN2igN4mv4afwJsq1TbpQ6Wlq_WXRyMdeohWv?=
 =?UTF-8?Q?8btp3+cyO9A3fi/v3bwtaZhuCYnZrpW3XCLxZeKAgYa920QJzVlbgH6V1_SlftQ?=
 =?UTF-8?Q?OnbTLJ7xauseXZ6DBfrX2at48gKuh/+xQNIymCqw1nDZw6vrCck2RXqpJOSEpak?=
 =?UTF-8?Q?_Z7p8GLpMNC4fhrVwEuq4sCm61htM0XMRHWyyvpJbRK4NXLNxrLMQHTtm2Ouldk?=
 =?UTF-8?Q?D/QuXA_NQ=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hgbb4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 May 2024 14:38:12 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44VEMqwu024103; Fri, 31 May 2024 14:38:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc52f9ftq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 May 2024 14:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2gDtj2J8MGiPnEdRAM+TPp3f4QnqdMaT45NoBpvqS2tv1GdW1rawk2x7jsZ3r9CZ0TaPzWL2JDMti8IeAWXJVlGJHAmqmImPv4Gv4TnZnkrMznopRmbf9suaFBc/mj2FZegUwrmfMZwP+q/ChmeYRej1UO5aM6OcpY6gFI1hi+Ux0wOuUwOH1Oy+QU3bbxup/A8lxf/1KHxCZ8orDNjNItWGhRyZd8FxU8FI7Yr2TxNutoYZ1Ybzx/phMDZljyFk1HLu4T3O39+NQQwR0Plly2cFlmgNGlgk0kiahg05/kFHSWe/e+6BYNDeUe2TEamEtprGmc3BIc5/cdXLgs4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZBt3YS3CaB0V35uaXDzpqH4bvziTrRECF4vaX37Rvo=;
 b=BZefHdSV97FpxE64aLJln4gPmpb+k+yncQRVnt298J/IWDjGfnQVHVAUVl+tjuCjD6T1ntVN/nJp76s0oWM4llruLNyz8M8NKpHRbcLty+4EduFl0yUP6i3e4pRXh6mfTq0C1PSm/Gd8jA7DMiUOt/v2xgeQJxLzUkfS1rWvlmzaN00ukZqALJ4UM1cFFgP006qKOuWKZ+fIPSmnQ6lkBTrMIcCzNvOREMu9KYZ+SPSSiOf176zP4aFMtBM1QB/zL9OTdVTEoN0xNZH0jm0Y6dkZvENmETS8ce/vxE7uFl95cy33wTJa+lf/1SB1nQc8saZ0mvwixMGLctNPcHUrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZBt3YS3CaB0V35uaXDzpqH4bvziTrRECF4vaX37Rvo=;
 b=Ovl8Cehb9ygO7QRNs81Vpi1P75anOxuyp0JN7cWyPHjLHGQnvVpHQqjLCzWGcTlJVZnXXWOegJcXX77GGjRTSW5SL8Lqj33JVPRIysIB3GcuHFHdEQjy/16WkdG6oe1PWrYV/K/X8wJazSHuK7cW/yXYDPpnaNjSPPsXVLOvBIA=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by DS0PR10MB6077.namprd10.prod.outlook.com (2603:10b6:8:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 14:38:08 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 14:38:07 +0000
To: Pankaj Gupta <pankaj.gupta@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "brijesh.singh@amd.com" <brijesh.singh@amd.com>, "dovmurik@linux.ibm.com"
 <dovmurik@linux.ibm.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>, "xiaoyao.li@intel.com"
 <xiaoyao.li@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>, Liam Merwick
 <liam.merwick@oracle.com>
Subject: Re: [PATCH v4 02/31] linux-headers: Update to current kvm/next
Thread-Topic: [PATCH v4 02/31] linux-headers: Update to current kvm/next
Thread-Index: AQHasoLvuseSexLIrkyV/U6+fSTur7Gxe6oA
Date: Fri, 31 May 2024 14:38:07 +0000
Message-ID: <774b70fc-992b-47bc-84ef-c5a22b96c63a@oracle.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-3-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-3-pankaj.gupta@amd.com>
Accept-Language: en-IE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BN0PR10MB5030.namprd10.prod.outlook.com
 (15.20.7633.017)
user-agent: Mozilla Thunderbird
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5030:EE_|DS0PR10MB6077:EE_
x-ms-office365-filtering-correlation-id: 2344dcb6-69ef-45e1-6cf1-08dc817f49d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|7416005|376005|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uTxNd5UvTbCtj8UqGIxHJ/IwKhT8pRjYHvDT55jVI+8sghLOFUHHaVehEGgq?=
 =?us-ascii?Q?h52cGksEmDyo3Fq0qldg2Fztm8LweMM9CwHOtEFfdps9NQLbM3H1rUIDP099?=
 =?us-ascii?Q?SqxDKjFvasCjBtYg4zxkVkeYYqtRn5xoGe+5ult5maZSBHli7fUZqaakSEgz?=
 =?us-ascii?Q?Ii9bvnYowwuixnDlVraTr1wIwOKsSnSwN+75hBGpRk8m+7JhAttosSKpwnnE?=
 =?us-ascii?Q?+MmszuwR2xPlfkc/ROInjpgU/TY592yu+M55bvhb/WR6JbxtcoLo80ZIdrrB?=
 =?us-ascii?Q?Z0M/ua02rS7/VX/jY0pYhEwpjrJ6XmLfKzF1xqQ/M2F0eCJYevkQBpaWlNFu?=
 =?us-ascii?Q?g4b1E/Y4MuLAwLtlodL5DeOoEtcWv+RdPP06v5wQhqew1f2WX9qrvmxBpx2T?=
 =?us-ascii?Q?F7JmNOy+v/Kf2CQf8mNGUBU8q0G1rP/w1ukB2mioauj+1c1xuB1sE7AHXQwt?=
 =?us-ascii?Q?1jEKtCegTYAWm1C/WiJmHwbJMKEFHtkQ0JnI9I/Ion6AjMLCbowYXIs9DFir?=
 =?us-ascii?Q?bX8yWEKcuM9VlOh54f7NDKWhE12g6eotAo7uKWQq9Nz9BSqTtlFLKT0Jphk6?=
 =?us-ascii?Q?RCC4cdPYwZh78P0Y1eSwdCZM+ULXed4MMcJq3ofY1XllfPrszW2PYLlQvPGd?=
 =?us-ascii?Q?Oz1UuarW/GMmW4DbMGVwmG+9dm4ng436Hp4WW+c4AZiPHt3cIH9BZT0wDdBD?=
 =?us-ascii?Q?1lacmLKQzFWcQOAGcPAvcH289k6Liq3R7qExl58eilZZpta8dib24mktvs5O?=
 =?us-ascii?Q?R/ris2zjDmAp+ldA0DZ7oyj3kegcSWkOThxQwTXLw4jAEujFyyc2b6ytTnoG?=
 =?us-ascii?Q?3PxNEWk6dSx/3uK3GnL5avjNH6UAyDIW1UszSioQq+5RdkWahhDRIvETu8x3?=
 =?us-ascii?Q?2VUwmxw7oSH19+55ABUKaoDXcL7vwM2wi8JF4XVNHO+0l7AHRRBqn/kU7o5V?=
 =?us-ascii?Q?zXesG4eUBrZbg9eqwAvhLcrohMlxpyPyn+vm1usFyot4ycoT8fErOYRwkPmJ?=
 =?us-ascii?Q?ExuAGvT50iqndAItZwL6NmlGhiojSEp5XqnmTsAnYxi2HaPeYLAGrVZUNbLk?=
 =?us-ascii?Q?HahLqKD9PERBh5Hy/40Jctcc9vmDLOAK0DAMuUxXAAmNPMNbp/panlrWhOet?=
 =?us-ascii?Q?npcN11oHUdTketzQTd+EBf9DNHRplPSjFSvI0c2BXuaZ6VgYbgdHxXvbZFjm?=
 =?us-ascii?Q?3tz8EukxMpS6Ogz8l18+HLsIJwuNNJ9cjzvxrJZIN/vD1m+hcFBM2KjxYMl3?=
 =?us-ascii?Q?DSssNcZwU3Lslit9F/4AMRsMZh4BKJ7Yswjey+1+Ig4ef083tVRfnIjp+cg6?=
 =?us-ascii?Q?4sIpsMrdXsha+FtJ9xdD7NPMYfYbZBg890eKQL14Nx45bQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5030.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eua6ztHH5w/HLI448Udar9buqA5OFtU/5Pa0FmF+IvvyYg6siKyX+ENdmmx+?=
 =?us-ascii?Q?dF+8zqER7mRtrdSYSv/DpJcVpyZ75KbC0SqgOBtHI9DghHo4+FlINFqiUAK/?=
 =?us-ascii?Q?IJKayLL+Pilaod4d5JiOdt8Se+f6OUYswG05hamFEYSmW1oZhZ3yTtDm+4m0?=
 =?us-ascii?Q?JCJToGbwTBE5EtRnquwQOqyHYYeegKYydpfv6ODBP4KXvxiDBd8xFSpjzkH4?=
 =?us-ascii?Q?pCVU0wRyadp/PcyaKdHyRV/jNB1q8bz5WvZ/RTpABsijGSg6ZnepBxY/p6Wx?=
 =?us-ascii?Q?gHiz16j+5BHCaoZge2g8TI4CmCq/VrrajuwqlbivXWbDOaOBMckOEUDM8OlZ?=
 =?us-ascii?Q?Tb9yzizIwYaQF+7O8gi7ekzbs9hc/Xk9xhsztv9ISDarJMVEo2yRt0NVizGz?=
 =?us-ascii?Q?TgzJ0BKpLI1LlfjdTrVp+zBf3YWrvWv6CRuICJy9PGt0gGxE/tcQ242qmJZI?=
 =?us-ascii?Q?ltLWiWkMXj4Wi3/60GqlJ0Mtj5jiibFkLD0NcPzKP/WH+fdDSLN3mcDJch5Z?=
 =?us-ascii?Q?TJXHdmTCRg/5bChve6vVqJcVcj4hb78aX2Uof/K3DeHO1gOndgItyske5wAi?=
 =?us-ascii?Q?G7PCg9Bkkwbs1iR2zW6D/yEVM+Sl6y+JXKLfEWBWesz2qQ1IfNVYaFmKU2VB?=
 =?us-ascii?Q?o4Mg9dz8u/coZykwZhjdytkffoOZWWzF5OUEhoELw80hjjYTnvBMZS8MPNjV?=
 =?us-ascii?Q?U2C8vivSBIwyKjBP8JFkGRVvqDWD8cnCTVSGqmJ3AJjAqdgyMvsOnQySQnr2?=
 =?us-ascii?Q?41rB6MpKB/t5ncEAW3PorMP/GjY2S7sjbL0Er3/XlKRJGD9b1jwhNZ5EiTPL?=
 =?us-ascii?Q?RDwr3mmrqF0NPsZe7qKk6UfGhRzmziW6QxsVpvvYXm5eZdy/1XBa7gJS1xyP?=
 =?us-ascii?Q?0WEfzCWfelTO49prZmJDby4+lMFGFaBruIImt351lHwsYJceeY18DWpri9V5?=
 =?us-ascii?Q?hnA9se2ufjcRfRSkqETEdXSHgFhicRhaLjpHDH9ZZcF607bmsgQUw5JZgrvG?=
 =?us-ascii?Q?qoTU8T6gyIIL6C0NeNtMd0kraIWtLVk6Wg4TKNu6GrYflc8s9vSk5GARZmNT?=
 =?us-ascii?Q?X1mc2P41HAUnDYQAJqRI318pGVLY24mFcf3hE/i5X7qTgI323H3/oxYSyc3f?=
 =?us-ascii?Q?cARTIg3JrCTrRvZq9pKDtII2uwAsFzYQiDtyJni9XrwFud6Hl1hQGOhGgFPA?=
 =?us-ascii?Q?EG0sJS8L17ibOCF9zgK4+HZUd+FHc2ZVamV7MHkwmkzq0a8uvnGeUnsgGeS8?=
 =?us-ascii?Q?G4hUWPikydpEETjg9RMZ2umLustL0LiqX43CB0Ref1NF5w1N0kbKcoQz68OZ?=
 =?us-ascii?Q?ZRQZ6r2hFlp7IWRiaJZxcdGfjd9vAIu2/fsckuj93x51RRoIJA6pVJXqOgCJ?=
 =?us-ascii?Q?s6rw+rrANkA+v/E2jB/cdmnKbiwkKb6+nbHVGyjZv/FsrznnpMGOnYTY2MIV?=
 =?us-ascii?Q?YjsQh5ebvm7Va8Ii6qvEHuhzMG4AwbJ+yGJZnsoIJpe3ySeLl+8d1V4DlLBW?=
 =?us-ascii?Q?G7gWA75yIMwhpm8qKqiMInid5qQ3OelEsA3sOH5+KOYOrBpF3Jp7C21nq/Bu?=
 =?us-ascii?Q?3FmbYxZIOufLEYFjfP05drTuGHZ0ENdyewDlLlU0yv84miQXW+tsYR+CSb/v?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_774b70fc992b47bc84efc5a22b96c63aoraclecom_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hLEN3tsEdC/qtKtphrg9MPohYLElW5zCtNmRFBNxG/0LJegZlx2ousOcjOSYntQTtAdRGnbO0uX+AMFDGRhLM/FFxpqUpik6x0mMDM/iSiIB2cqN8UzAmK47vznPx5LIv2w7btnEOG5RAW8VLY5cp7fY3LFjg6F+byYpDa6ITz/AGWCx264KFMNXwE2UKtIYY38BbTjBlSKf1F3WJgNPL5RWxP1nAWpvXiOE1TTv7DTaGna8ynHn0UBitkKbt73+9e0CJmiTxgUdDBaaUpBmPjp/6N1Wl6MTr8IVH1Kn6DORKVWPqhs5V2PdYp8FRY+M4zA8suD/8Dn1WUSQAY/RTu7QKGav7kgKo8qtIv1IMmNXufnqPizfGJVEgwi/Q6wJ2jJ6/ItplR3xUrGrVxyUyclDFRzdH2pv/deA4cDxGhYs/6d2lvS9tVDiU13jlrdCQq4fmBNehh575NkPgg4LtqZRv/eWSUAwSDrngcoypPuRtU2+TTAwVzXHgMJke/o330JCePHhcuU/sHwXtkf5VnNtIwgigSt1o4WJEwOqFtLM1xUW7ct9k3O41XnO08yD3SO3Au74q9fypRIoCeyT6XLyi0a9dWnlHoW820Z5tYM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2344dcb6-69ef-45e1-6cf1-08dc817f49d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 14:38:07.9226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTEaB1R7YsA5jSROqpx9yhFCS3dp8dawxd8V/eZbkcWVH9DxZ1N0n/6BB4ZXDgvHFT8MHqTiBm9rtz4pM2yC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310109
X-Proofpoint-GUID: LYsnpvnM2mZAgg4mC8yDjIdM4_OxP1Yg
X-Proofpoint-ORIG-GUID: LYsnpvnM2mZAgg4mC8yDjIdM4_OxP1Yg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=liam.merwick@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Liam Merwick <liam.merwick@oracle.com>
From:  Liam Merwick via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_774b70fc992b47bc84efc5a22b96c63aoraclecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 30/05/2024 12:16, Pankaj Gupta wrote:
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>   linux-headers/asm-loongarch/bitsperlong.h | 23 ++++++++++
>   linux-headers/asm-loongarch/kvm.h         |  4 ++
>   linux-headers/asm-loongarch/mman.h        |  9 ++++
>   linux-headers/asm-riscv/kvm.h             |  1 +
>   linux-headers/asm-riscv/mman.h            | 36 +++++++++++++++-
>   linux-headers/asm-s390/mman.h             | 36 +++++++++++++++-
>   linux-headers/asm-x86/kvm.h               | 52 ++++++++++++++++++++++-
>   linux-headers/linux/vhost.h               | 15 ++++---
>   8 files changed, 166 insertions(+), 10 deletions(-)
>

> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h

> @@ -870,5 +919,6 @@ struct kvm_hyperv_eventfd {
>   #define KVM_X86_SW_PROTECTED_VM     1
>   #define KVM_X86_SEV_VM              2
>   #define KVM_X86_SEV_ES_VM   3
> +#define KVM_X86_SNP_VM               4

I'm not sure which is the best patch, but there needs to be an array entry
added for vm_type_name[KVM_X86_SNP_VM] in target/i386/kvm/kvm.c

Regards,
Liam



--_000_774b70fc992b47bc84efc5a22b96c63aoraclecom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <A54DC93B32C5BE438C5CB8921193A0A6@oracle.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr"><font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On 30/05/2024 12:16, Pankaj Gupta wrote:<br>
</div>
<div class=3D"PlainText">&gt; Co-developed-by: Michael Roth &lt;michael.rot=
h@amd.com&gt;<br>
&gt; Signed-off-by: Michael Roth &lt;michael.roth@amd.com&gt;<br>
&gt; Signed-off-by: Pankaj Gupta &lt;pankaj.gupta@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; linux-headers/asm-loongarch/bitsperlong.h | 23 ++++++++++<=
br>
&gt;&nbsp;&nbsp; linux-headers/asm-loongarch/kvm.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++<br>
&gt;&nbsp;&nbsp; linux-headers/asm-loongarch/mman.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++++<br>
&gt;&nbsp;&nbsp; linux-headers/asm-riscv/kvm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; linux-headers/asm-riscv/mman.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 36 +++++++++++++++-<br>
&gt;&nbsp;&nbsp; linux-headers/asm-s390/mman.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 36 +++++++++++++++-<br>
&gt;&nbsp;&nbsp; linux-headers/asm-x86/kvm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 52 ++++++++++++++++=
++++++-<br>
&gt;&nbsp;&nbsp; linux-headers/linux/vhost.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 15 ++++---<br>
&gt;&nbsp;&nbsp; 8 files changed, 166 insertions(+), 10 deletions(-)<br>
&gt; <br>
<br>
&gt; --- a/linux-headers/asm-x86/kvm.h<br>
&gt; +++ b/linux-headers/asm-x86/kvm.h<br>
<br>
&gt; @@ -870,5 +919,6 @@ struct kvm_hyperv_eventfd {<br>
&gt;&nbsp;&nbsp; #define KVM_X86_SW_PROTECTED_VM&nbsp;&nbsp;&nbsp;&nbsp; 1<=
br>
&gt;&nbsp;&nbsp; #define KVM_X86_SEV_VM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt;&nbsp;&nbsp; #define KVM_X86_SEV_ES_VM&nbsp;&nbsp; 3<br>
&gt; +#define KVM_X86_SNP_VM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
<br>
I'm not sure which is the best patch, but there needs to be an array entry =
<br>
added for vm_type_name[KVM_X86_SNP_VM] in target/i386/kvm/kvm.c<br>
<br>
Regards,<br>
Liam<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_774b70fc992b47bc84efc5a22b96c63aoraclecom_--

