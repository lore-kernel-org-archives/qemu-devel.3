Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93638F54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54vZ-0000si-NK; Tue, 24 Mar 2026 12:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w54vY-0000sQ-HL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:48:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w54vV-0006hA-Ut
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:48:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCBs8B4016998; Tue, 24 Mar 2026 16:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=DvzehosUsAK/TTvfTBHbjDGX306vI9po7KoBxW+ls0k=; b=
 dOBfPu3hUL2tPLpxbxRM4yVvryalMSb9mo1GslX0cMiF0FjuYREpSAEvtYr9qY1/
 6cd1CsOQuL14SmvoRoSEgu9ZQvN8oRmiS7FgyVSJ/xumPQ4fqFdo48ctm5q2LZur
 ZkAN0FDz8m1uE9/rVvk42l7vmcrhAtr2qWZOg1E9+IerWrVLlllVJ24ERodwQ9CL
 K18N/ShNJtrnQawUQsfLfaSycWZb7mB4h5RdaT4eLRBckdVka+Nm/F+TpGBqZLVA
 dvosSPZI+Fli+XmBP7Xvy9eS5aIeFBiCWsTkCOiixs1BdqWd23cJCHKvzXpOeXA3
 QBlvZU3VmXaRX9B6HDUbhA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2cm4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 16:48:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62OFks5c038274; Tue, 24 Mar 2026 16:48:02 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d26xptq6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 16:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xlw2pvz7xbAWi9RC7JhgTzhR9EqcNszaJCVqZNLfUIpQThgZwzfZqAIEtA1vStV143oIyzyOSQxHytFx8c6xCjCR8JVJgY9+t7MWP63s1F088jQJjKVt3fNXAzUpI7VebrabBIGIqefCqH+W53EONqsa9sujhjTjRtKiAN2x6S92pK2/bfq2vnMBM4G0BJFCEfx756h0Dck5NUGHChjrTeuimcWDuopcjGMcFPPeYb0SOGRYjIoX7bMptOiXTh3Xc6LxN0+ZNyLxl4ChVmuCWheCscaE6V7OQSld2R6K5mz4wSJYJ0zPwl3sqt6YvR2yKtyuJzxoPSptOhB9lgo+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvzehosUsAK/TTvfTBHbjDGX306vI9po7KoBxW+ls0k=;
 b=NmUQfYN64qV+Upm4BBQcVXRiAjW58lOEjmda0GIiMcxtaGCDbjx9mJAoWO3iYHNGUEnjigri9/YuylP9Je9iFC3dbKxDPu7fgwMNsmIlcHD4vARYRhdLV7RkZBd9JekVXnj6UdZM4JXD/5Z/5klnoJmt7BI2dywdBmJhg26MW13zuQMvj24rKRIqfkeUn+tV75t7LuPZretBMaspWALSzpzHfBU7NmhP3PR+mPpVix0caqs/lF8X6HjiD7zQ7ilu9we1K3EzTr0Pq3DCVxrTxHr++x0Tsy/nYWresG5B/WHTYpdgZPjiKvQsZBulAKtEqSc6hs4IESrjLAXsNlhLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvzehosUsAK/TTvfTBHbjDGX306vI9po7KoBxW+ls0k=;
 b=YD9fj1vr2n1EsiSrmz0644vvEmkzQ9+SzZ6C7WJdc9aeizjnbM9L0G6AqjGGD+AbtBPM2yHpHtVsn/Mo6ARM2287e0DSIcDUBUIy6J9mezbQ7/PACALIvRQ7Rsb+7O7Oq7Pzm9Rx8RoKOA7buz+KYFddxsLrNAOKY2qDZ2vn08E=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by LV0PR10MB997636.namprd10.prod.outlook.com (2603:10b6:408:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:47:59 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:47:59 +0000
Message-ID: <428614fa-3903-4d42-a0d7-cf8aa977679d@oracle.com>
Date: Tue, 24 Mar 2026 12:47:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 13/14] virtio-net: detect pending Tx work for VQs
 mid-migration changes
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-14-jonah.palmer@oracle.com>
 <CAJaqyWeSr42GwqG82hWcj5Etpde0Kz8no1TMwFbVeuCazQghJA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWeSr42GwqG82hWcj5Etpde0Kz8no1TMwFbVeuCazQghJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:930:a2::18) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|LV0PR10MB997636:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f8c3d8-72c0-495e-3487-08de89c51b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mdX9dnkx1T78k+mYnrylyJgxnkn/4PJpT4Rqabu0a86k4UsCaEg97Z+tiSERGrP6U/gWKsSpgeyDxA354uSREIrGPsc1cYZD821mwKVzTUpyVmQhSYPbDARY4JFg/KL+QxowVgWT5dgQfHFs7h2PeBMRYoh7QoB/MM++/cQifKRg2n/i9CbBQJamdHI1madttPynjSCzIBZE2l3L66JYdQxIzd4Ip9+XM759QbM1izWVlwvGgWPxXxPewUmzyw3pbbLOByMtzqaDM6gYzRMgDvEmxbIA3Wbv/ee4DRDm/fNVd105NCUxqJCl+8PqM7p/au3S5TE4EbNc2g57mU1lhahDKPF+AYZI+dZCEE6/vvcsb/7rrlxKSR+RZ6qv9WezghDQ81Lgi+O/yzsKciRSuU3jJlPExsF1Gin9jrG2z+rG/K24lPuHXDkUdWK8vrLL0NnOgl8klbm+rE9NFyOvvKjzb7TRAC18fkkL6w+TUr2W19aoJ8Bh9rcaT2j80A8gAgJMtQTLYE39FxYh6SYDy2qbTiEQ3iouO8gsdZwn8txLtwnjoAGlKC+Q59JBwkOT7cIVXxpC+sMspVFAHvmaOfxQ5WGUy5/zhkkAVBIx2pGpD8MDQSbdlKDVhKprGSPxADek+2F4MTvXD3eC+AInJ0nhU2oj7Afdj94nkboC/Earw/9h25qBF45mmp1nC53gZD+OOvAsZf3Vawa7qzMMPMuiP4MWm0goq1CYIPvhRj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZEb2JsODZFTzZ3UnUzd1h6aXFOWnJIRWRQSHowczhaT1MyWFlYa3BUdnc0?=
 =?utf-8?B?SlpKTDdFaWJubjV5anBhYzhJRjBrRzNOZ0NpM2VhUmEyL0pLYS9UNTh5WFMy?=
 =?utf-8?B?aHlQWXlseXNxcFVSVlNwNkFUb2tvTDhRY3FpSDNodmlyUkpRTnBZbUhmTDdk?=
 =?utf-8?B?Z3ltbzZVQ3d4elFuRWpyS2pqcFArZTdYYWJQUjViM1FoQ2pDOG44ckpOOGlz?=
 =?utf-8?B?RkpyZEZpVWhEMHAraVdtTVBKSzFBd3hPeUtEbUxPdVFKdjF6UFltSDYyUmRr?=
 =?utf-8?B?YjRuMWZ4M0pmRVRVdmEwRTUrZXVtQUxMbkp0eHUranhibXJqWlBTUzllVFJF?=
 =?utf-8?B?TG1yWGRQbG1KeEZvTC85K2dVQmtHSmVpT3g2bDIwR29OV08yNGQ2ZlhsN1N1?=
 =?utf-8?B?ejBlRmlESDJBaStCT0xoQWdQQVFsa2tySGFqRGE3Z1ZxdXlsd1ZRTWhiUkto?=
 =?utf-8?B?VVFIUW1PaGpWVy9pTlFIVWpOV0ZxdFVDWFR2NkFEOTZ2YWVsdHVwZnhrVUoz?=
 =?utf-8?B?cnBkYWs5bjlzU3VxSk9hUVpnNXBzTlBPTzRJalVFU2JJMTd6VVFtMFM1NHRP?=
 =?utf-8?B?ZERPQldrRmgwNkhsMUFQd2dnN29GSzJMSE0xbTA4bUJtaUtsWjNobjNqWWlC?=
 =?utf-8?B?TzQzL0MxTEFFbDNQVXBPeVIybHREaklycHFuOUljVVR2eElybllMeFhFc09l?=
 =?utf-8?B?dnBxbFFlalQySitjVllCWW5EMkdreDhkSTJWeUJ3T2V3TThzeUFzOWtXTk10?=
 =?utf-8?B?VDhzSVkxWTZKL0VOSkJlNkpKN1hRdzlMR2psQU5zb3NjZlZJUEpzNU1yZ3pI?=
 =?utf-8?B?WDRvTFRMMDhBYmcwMVRwTXl3czFVR1hvWi9UVFhOclpBSlpnekJ1U1RERFpi?=
 =?utf-8?B?VEUwbjlWcXNhN0I3MS9ycW15UXVBeFJtckVDTFVpTHFOczJ2YUNsTXMxQjhp?=
 =?utf-8?B?NDF2ZjFuOEhlbmFTVWVTV2drdVVZREF0ditRNVBLc0lwd21PalFQQmxySWQw?=
 =?utf-8?B?akxlUlVrMGlaeWhRTVlFZ0pqVXlReDErSnVaYkhuYzZ2ZktHdVZyT1ZYTzl1?=
 =?utf-8?B?MVBLbDFTM0Jja3FUUkg1TktzK1dGNGFaWExwWDhFNVVYM21ycFo2RlV5d1NX?=
 =?utf-8?B?VitXRmZqM1piZEhSN3J6YXVxQnVmOFAwRWVxc1ZvNnVpOFd3c0ZYSjFpRTJY?=
 =?utf-8?B?K2NNSVlwWFIwQ2p0VzlzUGZXUHB3bktiMGhHVEZnNXdZaDJVY1NBZ1pGU2lH?=
 =?utf-8?B?bG0wVExsVkZvQ1ZnVnBJUGhZaEdoWlJKQmhJb3hPT1pKTktLZ3BBSUdLVHBM?=
 =?utf-8?B?UXNiandGK201QUxPaVVUWTNTSGowdWNZemh3VlA3d0toenRPajR0MENqVWY3?=
 =?utf-8?B?SUZ0ZzRMWUpxckZwZjdIbVpOM1RWSUx2aVMrL3lzVW80SUpHOS9zN2g0eWFt?=
 =?utf-8?B?UWh4MFF3dkpUelhFVnVPYXR6MmRtUWExc2xpdm1nQzkxQ3BFV3RYOEFEMzJn?=
 =?utf-8?B?SnJ6R3QwdVdMTW5reEN5MnpqVVRPeFVxSTh1OEN6TUsrWDROd0dwbXN6ZVM4?=
 =?utf-8?B?U1B2cHp2SkV6bXdSZ0tDTmF3YitIbjJaa05yNWFvT0NqWkVCT2J3eVBqeExX?=
 =?utf-8?B?dkk2YVNNVjV1ZXd5cTlUUHRreWRnK2poYUlEYjhpMEF5SjY0L1dROTJHMlhm?=
 =?utf-8?B?WGlpTDF5TWtWdmYrS01UYW14Zk9JV3hTenNhNEVscEw4Y1FQNkRGSGtpL0dG?=
 =?utf-8?B?YWlWRGJkTU5UTW00ZzQ4Wk11alVWMWFCalhhaGg1R3Z5Um1iMFFlVW40TWgx?=
 =?utf-8?B?d0xKQk5yY2JIeGpSbXdQQkI2TEYyY2dYZVNncDJJSlh5UHI2bHF3UVFPdWF3?=
 =?utf-8?B?S2Z6dDJVSXJ2YjVUNlpURXpXTGRvNkNoZHozQ1pmOVg5dHRHaG84NEdrTlBp?=
 =?utf-8?B?STgrMi92N01HMUdtbzJzVFBuOEFoL0tabG1udURSbWcvaS9URzdRNXQwdkpJ?=
 =?utf-8?B?VDN5UTc5TEN5TUp0UzlQejdwenh0QTJCcW9vc1MrbEhHL3p1aVNON0gzTTVS?=
 =?utf-8?B?aHVqVjhnV2JwTnVuWVdBOExidGhXMjNvL2RMYmM2VURna1NLVlVOdmFWTEtV?=
 =?utf-8?B?U25Zb2tjTGh4aGI3bVZkYUpaYmRoK0ZzaitMVXBLL1BpVUV2cXZsUllTUlRl?=
 =?utf-8?B?Sjg4aTNZWlBqZ1VkSjVwVnA2dlQ4a3VPMzdEckZPOFR2K0JYaFhMdlZtQll5?=
 =?utf-8?B?L0NibDY1bzVJUGVqSFRXbVNYbEg4V0p6d2xTUWlyTWt0aktrU1E4dGRsY0lK?=
 =?utf-8?B?Mm5qUVJQRmZLdW5xZnhScStUb1NEdDVraFZjUjZ4M28rTnVkQU1WZz09?=
X-Exchange-RoutingPolicyChecked: dp/bV3HKxO47Otis+IuvixM8kp9IJ56ClAhKmC9Idv8t1Cy0aAVGcWQrCnIxYyp7LbnCJDgeHtgy9ElEHuIQkbh1cMuJLbJj/PKhkV0EbKfXMv7G+KfZK1iKAKaz5nFJSMe3OF2jkAcMeJOsTeBILzeDKHdeBLHT3PaubXKfwewJhcY2X+aQkm8FhpwgZ0HSQQ7K/KW0Mfz76Dgao6drfWkv0XeOgsAZdwn6MsHOqwgww5mPLS52xupi+g/OmZvJ53JnjHRyIQZC3LyCDYnFGr+AKfjbarEJWEruR0Q2RWakZz3lOEcalf2XOpOAHJk1WtIBA44re7KDA1M+otCGqQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lFrd0GNtviTFQabebl6bNCLEosAgzxXRTmSkesgR2csfvprA8q7CD2yzR/UkOZUsp0UNEnwWHTRPdFQT7nZjkjeMtPaLWCKolXRwlRsRcT7zVs+GC6rwWtEGXQM4+NQpW3sWF2EH2TPt/3FZeNs1bFUvcXGkSDhZmdeBdpdGiri9W0pU/hdZwD0M0IZ0dUkHwMIT2zfeRY9pExSj/EU+U1u0RH8+zJrNPghJcYFgLav4P7aahrA9+b07w+jQJT2GUByLSHimUfbZncELtDUegzLTG2S3xXWcsUP29G2U0i7RcjZRrpVQQ2NlotatedoESrwF7mEPXvWzYq5R8hYzxHU1I4+Rm0nULOh19iCYEcSGYdeQYrLxH6V9p7NUXhThT4Ym9Dd/5ejX7xuWt+gWp75mXwrcKwWPlq1uV1dtGspPBlBXVhVQ0bvxaeDkrL4Dv+t9EdL+p9PHBKf5KaTCpdlswxjE7v/gP9sXagBJ3sW7Mn0230auoeyaShFX4DG1yJfFJlo0Rol9smjIPF0RPGdsd7M/+xVUww9e43ax2eVF1nwcGenEtn+Zc07UvP2mVdI+dHNKNsaNP7BmxOKLqnBWwIVqWpemmDtgvSzQcl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f8c3d8-72c0-495e-3487-08de89c51b51
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:47:59.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhyJSgNOJ1PU6jhR4T8V9ADiblEBO1AdhWO+9heR46QvQUoYZXIcJdRKxfleY2yihngNQi1rayEWksbra04T8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240130
X-Proofpoint-ORIG-GUID: L6DXNP8bTsHMt850JERHmzOpAZ6QBYoF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzMCBTYWx0ZWRfX/Hct2CZ2LW/P
 XgVjrIhgmqvs0sHpAHhdJjeeXauzeOSyidGQKNs0ijLZvd1BeTTwoGbETkENkma+UYNJp6umLLk
 4xXaK3nSthhekRToSSi3pXJcUXzb22CdrDcNcxK7g1DE85ByI77cSZyF1LaFUp5y90d1jFoznMC
 YCmvWQMeuamqqZbawh3YHJ3ZnlDzb22cisOkNEWEDl8CAbNqAMCj4yfRhW3cps2o+wAU/yDBfA5
 XDuGYO/d9QyCzMMQI0yjuIIkxji9S5oX76IUSOWQgf33NfWUBhYclgUyGbTr3eRZO86/6XBLHBj
 sIzB4GDaJaEljowCLm+3Uq+SnVLeGVfQMRBGKjCUFWD9oD5kJzn7wtXHc2QL5bR6NtieCWQCP1y
 X1V0IS4ZQsnVHr+3vhtYieJN7yWDzcnx3FlE2CN65oDaFErnd6o69mWwH/PAyckmpC27L8L+toO
 ACCHv2sa8wTUtSP8MLNJesrLqmcuvv5JKRJJMDTk=
X-Proofpoint-GUID: L6DXNP8bTsHMt850JERHmzOpAZ6QBYoF
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c2c043 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8
 a=UrBc99cZwA6qYjPnivcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12273
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/24/26 7:35 AM, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 3:21 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Track per-queue pending Tx work state during early migration time.
>>
>> This includes a snapshot of pending Tx state for active queue pairs,
>> checking for deltas at the end of migration, and freeing the snapshot
>> buffer during device unrealize.
>>
>> With this final delta signal in place, drop the temporary always-true
>> fallback in virtio_net_has_delta and return false when no deltas are
>> found.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c            | 26 +++++++++++++++++++++-----
>>   include/hw/virtio/virtio-net.h |  2 ++
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 3ee49a043a..483a43be4f 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3943,6 +3943,14 @@ static int virtio_net_early_pre_save(void *opaque)
>>       vnet_mig->mq_early = n->multiqueue;
>>       vnet_mig->queue_pairs_early = n->curr_queue_pairs;
>>
>> +    /* Tx waiting snapshot for active queue pairs */
>> +    if (!vnet_mig->tx_waiting_early) {
>> +        vnet_mig->tx_waiting_early = g_new0(uint32_t, n->max_queue_pairs);
>> +    }
>> +    for (int i = 0; i < n->curr_queue_pairs; i++) {
>> +        vnet_mig->tx_waiting_early[i] = n->vqs[i].tx_waiting;
>> +    }
>> +
>>       /* RSS state snapshot */
>>       vnet_mig->rss_enabled_early = n->rss_data.enabled;
>>       vnet_mig->rss_redirect_early = n->rss_data.redirect;
>> @@ -4254,6 +4262,8 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>>           n->migration->mtable_macs_early = NULL;
>>           g_free(n->migration->vlans_early);
>>           n->migration->vlans_early = NULL;
>> +        g_free(n->migration->tx_waiting_early);
>> +        n->migration->tx_waiting_early = NULL;
>>           g_free(n->migration->rss_indirections_table_early);
>>           n->migration->rss_indirections_table_early = NULL;
>>           g_free(n->migration);
>> @@ -4412,6 +4422,16 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>>           return true;
>>       }
>>
>> +    /* Has any active queue's tx_waiting changed? */
>> +    if (!vnet_mig->tx_waiting_early) {
>> +        return true;
>> +    }
>> +    for (int i = 0; i < n->curr_queue_pairs; i++) {
>> +        if (n->vqs[i].tx_waiting != vnet_mig->tx_waiting_early[i]) {
>> +            return true;
>> +        }
>> +    }
>> +
>>       /* Has the VirtIONet's RSS state changed? */
>>       if (n->rss_data.enabled != vnet_mig->rss_enabled_early ||
>>           n->rss_data.redirect != vnet_mig->rss_redirect_early ||
>> @@ -4439,11 +4459,7 @@ static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>>           }
>>       }
>>
>> -    /*
>> -     * Always return true for now until we're able to detect all possible
>> -     * changes to a VirtIONet device.
>> -     */
>> -    return true;
>> +    return false;
> 
> I'm failing to see one thing: If we add a new feature that the guest
> can change during migration and it's only added in the
> VMStateDescription vmstate_virtio_net_device, will this "return false"
> prevent the state from being resent in the stop-and-copy phase?
> 
> Mandating its addition here is ok somehow, but I'm not sure if I'm
> missing something.
> 

Correct. But this is also the same case today. That is, any new 
migratable device state would still need to be added to the appropriate 
VMSD/subsection. For example, if today we added a new member to 
VirtIONet that also should be migrated, it would also need to be added 
to vmstate_virtio_net_device (or the appropriate subsection).

So it's not a new *kind* of maintenance burden, but it is an additional 
place that'd need to be updated.

>>   }
>>
>>   static bool virtio_net_needed(void *opaque)
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index 88074a0976..dbbacc83bb 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -180,6 +180,7 @@ typedef struct VirtIONetQueue {
>>    * @guest_offloads_early: Guest offloads snapshot.
>>    * @mq_early: Multiqueue state snapshot.
>>    * @queue_pairs_early: Queue pairs snapshot.
>> + * @tx_waiting_early: Per-queue pending-Tx snapshot.
>>    * @rss_enabled_early: RSS enabled flag.
>>    * @rss_redirect_early: RSS redirect flag.
>>    * @rss_populate_hash_early: RSS populate hash flag.
>> @@ -201,6 +202,7 @@ typedef struct VirtIONetMigration {
>>       uint64_t guest_offloads_early;
>>       int mq_early;
>>       uint16_t queue_pairs_early;
>> +    uint32_t *tx_waiting_early;
>>       bool rss_enabled_early;
>>       bool rss_redirect_early;
>>       bool rss_populate_hash_early;
>> --
>> 2.51.0
>>
> 


