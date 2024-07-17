Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C79CC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SN-0000Ln-MH; Wed, 17 Jul 2024 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU2SJ-0000BD-A9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU2SF-0006zf-4t
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HAuOOU013874;
 Wed, 17 Jul 2024 11:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=98UcBciFgkRG052xvFxlgEH9Nliuy/bd0wtwXxDIAZw=; b=
 D+LyeOjnV0gOmO6DSG1zYf5XzEHMAXeK0i0PTIZR89/f872RMJYR2LOzNyD9feuM
 fTLfOqaF7wWXBqoNAFwEbDOD7nUm/A2WRBXYjT1isNWqet8ZMo58neYzFTEI8uxj
 IjsEzFtwb+MHpvddhDZowSuzlul2N20LqTevLRbl0ijakAwibTXqey0puMWnEHXX
 dHrUqKsFZ0uFUXqI+alCDpVyyhhu59qG2h+uj2IJqD7xd1blbPAWbeH6BVSeyL+Z
 ueUWCPPskJvsxq7IkJKAzmjEcyKjsp7uugQg6dSEbbKr4YgjeNAJi2zLIp+GsoDf
 tJ/gfsMPd3cq8xKDLIIeGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ecmjr0fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 11:04:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H9knoK006896; Wed, 17 Jul 2024 11:04:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexdvmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 11:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9eEfSQO86NJ1AgNDheA0uK5z52ZSTcYamAmk3mju+NJ7JV6cXUQvojFe+sovJi3097FCjUdg+yf+go1xdHvN5zweeOJE8zzzlZKGjieK8cMSnUlfPcGsB8oHPxVs15hoaM6MMcPeeXWDxFybfvG07a397HoHWERh+T4I6RbaVjdGF2N+s7KgTCKo5w2hlJCNXPCtvy7I9gTP5qPmfNcaACuoNuaVIuNzEda6vCrfgjI3DAqa2YZ+3srC7hc0nwGAjV82vRH//yQAf5rr2SM3d0AYINWbbPDbLLkFvbzFNAOx6P2b/YYzek17pMcPRTRN51qLvY9FWeCgiACrzfeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98UcBciFgkRG052xvFxlgEH9Nliuy/bd0wtwXxDIAZw=;
 b=IWia/OGytrJW6offj3eEkx/6VCiFG7TBjtFPB+u4wjSlutFKxn8GsAbV40sgHHU5Wxm6G6d2OsiF+qgOOu7ZSCJxNjG/sXxz4rw8PLCemhAvnA/KVroTXtXd+ZPRt2E4hwaeB8Rb2OD+CbKrMQLB1rIaZIp+Jflq+10cwehY7Sy9uLhq2RfopuBpy+hsWQvdbiVe1cMMJGTZwf4g+R7NEymEmv26F2rp3z8NTu5t/TVcVSR2fA4prSCuEGtO0SPVz/Ci+GqedLdU3HqZQo5I66AIyXT/ho9FLcN49AJvgxqfwzF07yKoW/IOErzNLrpMB/eq7g6QKzbHhihVBTezLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98UcBciFgkRG052xvFxlgEH9Nliuy/bd0wtwXxDIAZw=;
 b=dUEzHHTsPTPtVkthtX0FmQDryTo3p0oemmaNLUONtT3IAPmUcjONXg2qgFiT2L43M2F7UNhUD3VbaLmURDKFpsD8g53uUsMs2SLrsbCgbXmx2CHqL/FrZ18nNzosYgOp/DhlmGcMA8HF9XExfSLAAoMocaMcXueJJRtfZaIeZvg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 11:04:08 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 11:04:08 +0000
Message-ID: <50bf8b57-ca18-4898-9e94-fa4420c58acb@oracle.com>
Date: Wed, 17 Jul 2024 12:04:02 +0100
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <SJ0PR11MB67443AD929EFB426B4E4FBBF92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <91d16e89-4733-437b-9674-b5a96f4398ec@oracle.com>
 <SJ0PR11MB674420D8D4742A704036C9F892A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674420D8D4742A704036C9F892A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0035.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0103c0-2ef6-409e-1b81-08dca6502ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXRja1FPbHUwSnFXeWNVSjhkODE1TjJNRU1PTnRxeVgyb1Zvc0liMzJ1akFN?=
 =?utf-8?B?UEo4dncxN0M5aDF3VmkxcnpGSnpsY2MrdzMwRGltOEdVb2Z1TVFUK01HSGpn?=
 =?utf-8?B?RzZRSGpnVVVJVDgxZTRRWUFtQnZoYTFLd20yUmgwRjNnbnRPTTBneGJEaWJp?=
 =?utf-8?B?QmY0dEJkb2pFcWRRT3lKbzV2aDByVzQ1dnFwOTYyNko0MGNuckE0d3l5OUY3?=
 =?utf-8?B?S29WVytWUWZvbzVvemVmdGFXYXhFSlZ5MzN5WVBsUklCSEErdWdOQWxoTER0?=
 =?utf-8?B?azRveGh2WEV6Q05lOU94UnY0NUVJTW5MMEtQWUNCYjVHVnBFUTVqUVcySXJO?=
 =?utf-8?B?bklwbm5uaXl0M2JWS0lrNUEzRFdrRmxMMjhSZ05TeVZ2WTlneTRlaERnUTJ3?=
 =?utf-8?B?S0RBUkJEOURhdEk2YjBWOGQ3SFdLbUZtZVJJN056bDF0M0U0WDl4SitxMnRR?=
 =?utf-8?B?UzFVekpqejVPUUo2UVJ2ZnNzRndlZCtaaGRYVHpsTUk1WmpnWTZ0cFR6L1dV?=
 =?utf-8?B?eDl1aG1GVDcrcFEvNDQyV0VhRGJVcFN3WjdHVmxabVpZUGhKdUY0RXpXTEV1?=
 =?utf-8?B?ZU1KL3RSNEMxRTRiYUJoTmlVUzR6UDJEVDBlU1o5bDJDdkFiemxybCtOM0Fi?=
 =?utf-8?B?YnlSZXNnYkdJRWU4OFNvREM3TWpkZlZRYXBqS3hOVDY3V1JXSlFEOForSkZZ?=
 =?utf-8?B?d0ZsQjNVUUNLUHM1Tm9ZL0VFZTF1MkZQbzRrODZSYmxramxvT0prUDltN0xH?=
 =?utf-8?B?VEkwaEQva2M5VVJBWTJOcDNQcm1VckFZNFJKbEU2WVd4Rmg2TXRXOUlqNGky?=
 =?utf-8?B?RVREcVp3OENNNXl1WkR5S1dnakdCQmY5UmVDSnNEd0VodU9zdkpsNi8wbzBY?=
 =?utf-8?B?MWNtUDMveENqcVRBa2F0VFozOWFOc29YY3Z0dXYyY2hHZFo2ajVPVlB5ZTZs?=
 =?utf-8?B?YXQzcEpnMzd5cWs5ZlkvTHJxY3pERlNONVpHbVJnSzhCNndwL3Z6dmtEdDYz?=
 =?utf-8?B?YjlnU2tDNE1IWFgzU01UbkZNUFBrMTIyREg1eC9hckE3TXlZZzJVbzQxdTQv?=
 =?utf-8?B?d0RFN3d1by9yQ3VHQW1vSVFFYndXWnU1dUVNZVhSblJvNFJkWWlHK0lZbE9X?=
 =?utf-8?B?UXFSV2hmTjU5ME9Id3ROTzNySWVFV2ZmRktuTXhIa1F6TVJxM0lrVEgxczJL?=
 =?utf-8?B?RWdTVDROMmpPZnZ4K1JPVXZkdkwvdUJhQUlGV2FkZ0MvdmpoN2RNOTI3c1Az?=
 =?utf-8?B?NUhpaUJRSHd3bllHTmpWNjFQck9VK0xuRmxHQ3k1Mkl5MUdBVUVmdFFHOXdF?=
 =?utf-8?B?WU9zdjhGYnhtK2d2VnJsZG1LMXAxRS93NnpZQU9XOVNhd0R1ZGx5SFg1bGUz?=
 =?utf-8?B?ZlgzYWtSNHdyU1p4UlFjdlBNaDhkQytpRS9TRERGS0ZUblVpcHlqMHRUVGpJ?=
 =?utf-8?B?NU45bDg5d2lvSTFBWUpNNHdLNDZYMzF1dDAzSVk3akZ3amRQMGVJancwek1p?=
 =?utf-8?B?TGUvcXE4R3A2b243Z1FLOEl6NEZoZk1FbTdsUzE3clpDSk94U0xPZE50aENs?=
 =?utf-8?B?aHQwVlE1WjQySmdTaHlabTlaRWRIcmJxUGVQbkVmcGw3ZFp3TWJPN3dzM1pP?=
 =?utf-8?B?UWNXZzk5Uk02akExZU01L0p4SVF4dmlEL2JmYW0rVEw1VGF0WWh2dlVONDll?=
 =?utf-8?B?ZDFmNzlqeVpKNlZNU2Ryb3FpOE9PNi96R2xtUzRhdHNvMjgrTzZUbUp4bEp3?=
 =?utf-8?B?Wng4N1pVWEpmWmhwTzgvelJ5Z0dsc0VqT3BRZElBYnBmbFphZkpQQnZkNHBB?=
 =?utf-8?B?M1hsY0tzWnVrbWl2NFRkQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJ4WTd3bTJaRXU5alVNbEtzMmYxbkJ2OVp6U2N1bWY3V0U2a3RRYm1sV0lj?=
 =?utf-8?B?MVByaXFNWTV2SE5EYUJhQS9hUEx2MUU5dVluOGdaWkJlbUFodmNZTnJzdkhW?=
 =?utf-8?B?cklwc05aVGhJT3VyaC9ybVRBUmloMDF3aVcvSmVDUlVPcHZFdm11aXl3VFNu?=
 =?utf-8?B?UStUZHRpKzdHUDZRMFdzUGVveFRNSVVvbUJ1VDhYOUVlUUVvTXZtZzl3YXF0?=
 =?utf-8?B?cVovTEdWSnFPTWdCb0Rhdjd6bjcvMlpmNGd6YlBnWmlSKzUwTDVGVTdqRnVv?=
 =?utf-8?B?MG1UWHlmcUxYaU5tZStYOVFPY0xHS2FlT3ZkMGhtVGhyOUEvRG5PbUFUM0hL?=
 =?utf-8?B?TDZCTnAzWGtuSGpnYlF3TGhQVGdOalZ4QnlLYU1OdHREMWhwUno1VUR4UW82?=
 =?utf-8?B?T0lzVXJGeW9saC92OTdiYUFtVmIvdlpUK2xwQW8xYnRzSEMvOTFKQzBwalpp?=
 =?utf-8?B?Mmdyd0IwVHhJYzRHb3d6YmE0MG1HWFl5N3doYUZNU0puWlpGMG9sTUErNmkw?=
 =?utf-8?B?ZlEvaUdKdi9aZEhkL3RXa0dNVmhLU3lUNDB4djlYQVY4S3k5SkMyL3RhYmFl?=
 =?utf-8?B?VnZLUjlhVmFBLzdOeGdjaXBxY3NCeU90cHdkWmN2cVRiakVDTHVMYloyRUND?=
 =?utf-8?B?MTBPbjZnNW8xUUlqN1RKVFZGZzdsRHBHZ2wrTE9wcTZnS1pnNGQ1ZmNUdUVO?=
 =?utf-8?B?QlRuOXBWL3BnV2ZSbGgvdFZUVUNGWW1QbEtBT1FnUjRzL0pwUFVDZUxWc1NF?=
 =?utf-8?B?QzRxZzE3TTZuNzk2MXdSUEhrbzc5SlVKNWlJbVNvdVJYaVo2UDJIUzJXTlNR?=
 =?utf-8?B?TzdSZ1ZySEk4OHVOWVBuRkxYUFpMcXFtM2VYQ09qTWIvMjgreHBwWW0xUjZD?=
 =?utf-8?B?dnZndE1NNVNGSTczVjFVYVRoS3JxTHJyWUdqRzhmRE5LaUk2aFNDN2hMS01W?=
 =?utf-8?B?V0haYzNSNDhhRGFROW5xYkE1K0lwandnMUllb2Y5ZXVpbXBncDBZTm42RGpW?=
 =?utf-8?B?RWVPS0FpbUZFSVAzd0J3WER3T1JmTkIzeTNWeUcrdldQTlJTaUtQNHFWdmtJ?=
 =?utf-8?B?ZHNDelZPUmY5WTBsckFYUUVkbVhVeGJoUC9aaVRmSXU2Q1d1Tk9KSUt1VURM?=
 =?utf-8?B?a3BXK0dyS2wrcWswS2UzSHhIUUJ5QXJUSk1FUDFGbEgxczBoTFp0bFdoUW9i?=
 =?utf-8?B?SDVzWTdEcUltT3dhUWhsYlJ5Z0ZLbGc2VFlzQ29PMlhpQ2Yrd2NCdXFpVHZm?=
 =?utf-8?B?RVNyTm5IUU1CSmVkUzVqM3lDZ1phKzdIRGZYSElleHRwYzB6N0s0dHZFTzhw?=
 =?utf-8?B?M09nMFFLNi9WVVFGRGVueXhld1FlR3dibjluZCtXZ3ZFYlBHVTBjaktYV2g2?=
 =?utf-8?B?SDV0eHdZc2tXQkNQQVBOeVc3Nzc5c3d4NVg2czhncGE1NVRqc0p1VGY1UDR3?=
 =?utf-8?B?S2tPeGIyazJSd1hzcDhWTWVaRUZFcXhhM3lhTG5WaVVOVDZ4ajB4TUZMT2NQ?=
 =?utf-8?B?YkFqekJRSFJMdW5IeWQ3aE4wdzZIQ3JLbUJ5VzBESmNFY1BMS2JaOXRLLzZ2?=
 =?utf-8?B?Zk9WNm9kSU5lc1lFdkJNZ3ZlVGdnOXZTMy9mWkFiaitBelNnanI5NWYreHI3?=
 =?utf-8?B?bFlpY2pzcHdvV1R0eFFleEpoajlMdmVLeEduRStzVUp1d29RQTRZY3BmUWs1?=
 =?utf-8?B?QVBJZHdmR1p3ZVFvODBkRWpjUHdEaGx3T3dsZ1JmT3FLOUhtQy9YZEVtUjl6?=
 =?utf-8?B?OEt4MTl0elhPbGtwNCtqdVcvOHdPVVFjbEJtaEx5K0tISFMrRkMybDViektB?=
 =?utf-8?B?L3NGeFBHdWdjSmVHWk56SUlaNHlvMXlEMTAyczd0d0pXemFDekJKUC9UN0RB?=
 =?utf-8?B?TnYxL2ZRN0hPOGJoR0xQV3dTZHVWem80TXFMWkcyRE1FZWsxL0FJWG0yWjhz?=
 =?utf-8?B?RThwZnQwa055bnMwWFVSSWJkTUViazNobkZjYVEwMWFMa3RhTWlFVENEUVZu?=
 =?utf-8?B?eklZOUhNcnlvcVVETStKRmNabVBhOFcwME9mOS81MXo1K09Edyt6MEVTcTZ3?=
 =?utf-8?B?ZHBvMHpsMlNQQXlwdjZvL25HV1IzWjBJNnZLcE9ON0NhaVJDSXdON3NEQjVJ?=
 =?utf-8?B?eVA4RnFCNk9iUy9MMnNHWFdoZklDY3ZEQkdmMTJsSWYxcklZVmpBbXlUMnpa?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v3fQq5+KoaP0EgwhU5AONwVGDYDWbc/MzHTi+xy5bvIBYiXxuMi1flgzal7VGo6m4Nzuhpfm+KWNJ+LJpJJOuSfBSgBw09vx6x9pX63JdxNNZO66YEuiKV+eRF4zDc+6qW5T+v4gRUOTvQCGUAtVFSdBW+aVf4fk5Tlcgdpxkxt9E2Oce6Gk8M3/BYKpHISG1wBW1zceDU3yjHlPCGxqQWSQwXAzMeKSxenFHWZRa8K97xrJyOGjwABf/wlIpuZlQt/1mwjolk4i+FK1vuFtlypVokuPAJ4/VTRin6XbXbHNWZPSRgEz+rgZnBb6JGG/K5dpbqHf0kf9RLNW5wxpVfV7NDlKOrI5sydH6DZ0NiLlrP8ns7b4rgkxHirfOJCqikIydbDyVmWKR2bnNL2QP/lTvevmd9ZJ2RB3xeWryNukcnKN0+p6YCTcG+FxccwHMIH7nsg3x4+DRH5jnqiGIVZjeVfbqcyi3ajXN3C3stMxb7H7qH7guNQ/G/8haCaO/avbRwykjGgz3kqXCYTYZ+1tAN1rQ5XxqYymN0JI8vipJXVxD+T0WyASaJlDelmXaP5miv9rAWZfrNUJmCwd+6fWqNLjyoMI/irgw0S8h2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0103c0-2ef6-409e-1b81-08dca6502ddf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 11:04:07.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPBjLErLwACthZLojbM8u8F3y8K1TDmr4m0xBt/7E7SS7Cq6WLHEJ0ja6tUJuqo0ytUFyViRj9JcAtarXBWolYbhtq1ODRREIcHO8MKjjcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170085
X-Proofpoint-ORIG-GUID: LLZQbfXUhoOMmtMvqaH_00mPw4Q44UXw
X-Proofpoint-GUID: LLZQbfXUhoOMmtMvqaH_00mPw4Q44UXw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/07/2024 11:05, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain
>> creation
>>
>> On 17/07/2024 03:18, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain
>> creation
>>>>
>>>> There's generally two modes of operation for IOMMUFD:
>>>>
>>>> * The simple user API which intends to perform relatively simple things
>>>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>>>> and mainly performs IOAS_MAP and UNMAP.
>>>>
>>>> * The native IOMMUFD API where you have fine grained control of the
>>>> IOMMU domain and model it accordingly. This is where most new feature
>>>> are being steered to.
>>>>
>>>> For dirty tracking 2) is required, as it needs to ensure that
>>>> the stage-2/parent IOMMU domain will only attach devices
>>>> that support dirty tracking (so far it is all homogeneous in x86, likely
>>>> not the case for smmuv3). Such invariant on dirty tracking provides a
>>>> useful guarantee to VMMs that will refuse incompatible device
>>>> attachments for IOMMU domains.
>>>>
>>>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>>>> responsible for creating an IOMMU domain. This is contrast to the
>>>> 'simple API' where the IOMMU domain is created by IOMMUFD
>>>> automatically
>>>> when it attaches to VFIO (usually referred as autodomains) but it has
>>>> the needed handling for mdevs.
>>>>
>>>> To support dirty tracking with the advanced IOMMUFD API, it needs
>>>> similar logic, where IOMMU domains are created and devices attached to
>>>> compatible domains. Essentially mimmicing kernel
>>>> iommufd_device_auto_get_domain(). With mdevs given there's no
>> IOMMU
>>>> domain
>>>> it falls back to IOAS attach.
>>>>
>>>> The auto domain logic allows different IOMMU domains to be created
>> when
>>>> DMA dirty tracking is not desired (and VF can provide it), and others
>> where
>>>> it is. Here is not used in this way here given how VFIODevice migration
>>>> state is initialized after the device attachment. But such mixed mode of
>>>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>>>> be added on. Keep the 'all of nothing' of type1 approach that we have
>>>> been using so far between container vs device dirty tracking.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> include/hw/vfio/vfio-common.h |  9 ++++
>>>> include/sysemu/iommufd.h      |  5 +++
>>>> backends/iommufd.c            | 30 +++++++++++++
>>>> hw/vfio/iommufd.c             | 82
>>>> +++++++++++++++++++++++++++++++++++
>>>> backends/trace-events         |  1 +
>>>> 5 files changed, 127 insertions(+)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>>> common.h
>>>> index 7419466bca92..2dd468ce3c02 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>>>
>>>> typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>>
>>>> +typedef struct VFIOIOASHwpt {
>>>> +    uint32_t hwpt_id;
>>>> +    QLIST_HEAD(, VFIODevice) device_list;
>>>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>>>> +} VFIOIOASHwpt;
>>>> +
>>>> typedef struct VFIOIOMMUFDContainer {
>>>>     VFIOContainerBase bcontainer;
>>>>     IOMMUFDBackend *be;
>>>>     uint32_t ioas_id;
>>>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>> } VFIOIOMMUFDContainer;
>>>>
>>>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>>>> VFIO_IOMMU_IOMMUFD);
>>>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>>>     HostIOMMUDevice *hiod;
>>>>     int devid;
>>>>     IOMMUFDBackend *iommufd;
>>>> +    VFIOIOASHwpt *hwpt;
>>>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>>> } VFIODevice;
>>>>
>>>> struct VFIODeviceOps {
>>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>>> index 57d502a1c79a..e917e7591d05 100644
>>>> --- a/include/sysemu/iommufd.h
>>>> +++ b/include/sysemu/iommufd.h
>>>> @@ -50,6 +50,11 @@ int
>>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t
>> ioas_id,
>>>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>> uint32_t
>>>> devid,
>>>>                                      uint32_t *type, void *data, uint32_t len,
>>>>                                      uint64_t *caps, Error **errp);
>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>>> dev_id,
>>>> +                                uint32_t pt_id, uint32_t flags,
>>>> +                                uint32_t data_type, uint32_t data_len,
>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>> +                                Error **errp);
>>>>
>>>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>>>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>> #endif
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index 2b3d51af26d2..5d3dfa917415 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -208,6 +208,36 @@ int
>>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t
>> ioas_id,
>>>>     return ret;
>>>> }
>>>>
>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>>> dev_id,
>>>> +                                uint32_t pt_id, uint32_t flags,
>>>> +                                uint32_t data_type, uint32_t data_len,
>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>> +                                Error **errp)
>>>> +{
>>>> +    int ret, fd = be->fd;
>>>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>>>> +        .size = sizeof(struct iommu_hwpt_alloc),
>>>> +        .flags = flags,
>>>> +        .dev_id = dev_id,
>>>> +        .pt_id = pt_id,
>>>> +        .data_type = data_type,
>>>> +        .data_len = data_len,
>>>> +        .data_uptr = (uint64_t)data_ptr,
>>>> +    };
>>>> +
>>>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>>>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags,
>> data_type,
>>>> +                                     data_len, (uint64_t)data_ptr,
>>>> +                                     alloc_hwpt.out_hwpt_id, ret);
>>>> +    if (ret) {
>>>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>>>> +    return true;
>>>> +}
>>>> +
>>>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>> uint32_t
>>>> devid,
>>>>                                      uint32_t *type, void *data, uint32_t len,
>>>>                                      uint64_t *caps, Error **errp)
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 077dea8f1b64..325c7598d5a1 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -212,10 +212,86 @@ static bool
>>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>>     return true;
>>>> }
>>>>
>>>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>> +                                         VFIOIOMMUFDContainer *container,
>>>> +                                         Error **errp)
>>>> +{
>>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>>> +    uint32_t flags = 0;
>>>> +    VFIOIOASHwpt *hwpt;
>>>> +    uint32_t hwpt_id;
>>>> +    int ret;
>>>> +
>>>> +    /* Try to find a domain */
>>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>>>> errp);
>>>
>>> If there is already an hwpt that supports dirty tracking.
>>> Another device that doesn't support dirty tracking attaches to this hwpt,
>> will it succeed?
>>>
>>
>> It returns -EINVAL, and we handle that right after this statement. Which
>> means
>> another HWPT is created.
> 
> Looked into kernel code, I didn't see the check about dirty tracking between device and hwpt, do you know which func does that?
> 

A device is associated with a group (aka IOMMU instance) and those checks
happens when the device in a group is firstly being attached the first time or
belongs to some *other* group and gets attach to this domain with dirty tracking
enforced. If the device belongs to the same group that had a device attached
already there's just a bump in the refcount and device is added to the /same
group/ device list. Otherwise the device belongs to a different group and it's
being attached to a domain and the various checks get triggered (dirty tracking
being one of them). These attachment validation checks are part of the iommu
driver, not core (the core just sees a .attach_dev() failure).

Usually follows this codepath when the group attachment checks are firstly being
done:

vfio_iommufd_physical_attach_ioas()
 iommufd_device_attach()
  iommufd_device_do_attach()
   iommufd_hw_pagetable_attach()
    iommu_attach_group()
    ...
     __iommu_attach_device()

Then each iommu driver defines the compatibility checks and if the domain has
dirty_ops set (that comes from this ALLOC_DIRTY_TRACKING flag) and the IOMMU
backing the device doesn't have dirty tracking the driver returns -EINVAL
e.g. on Intel IOMMU:

intel_iommu_attach_device()
  prepare_domain_attach_device():
    domain->dirty_ops && !ssads_supported(iommu)
	return -EINVAL;


>>
>>> If existing hwpt doesn't support dirty tracking.
>>> Another device supporting dirty tracking attaches to that hwpt, what will
>> happen?
>>>
>>
>> Hmm, It succeeds as there's no incompatbility. At the very least I plan on
>> blocking migration if the device neither has VF dirty tracking, nor IOMMU
>> dirty
>> tracking (and patch 11 needs to be adjusted to check hwpt_flags instead of
>> container).
> 
> When bcontainer->dirty_pages_supported is true, I think that container should only contains hwpt list that support dirty tracking. All hwpt not supporting dirty tracking should be in other container.
> 
Well but we are adopting this auto domains scheme and works for any device,
dirty tracking or not. We already track hwpt flags so we know which ones support
dirty tracking. This differentiation would (IMHO) complicate more and I am not
sure the gain

> If device supports dirty tracking, it should bypass attaching container that doesn't support dirty tracking. Vise versa.
> This way we can support the mixing environment.
> 

It's not that easy as the whole flow doesn't handle this mixed mode (even
excluding this series). We would to have device-dirty-tracking start all
non-disabled device trackers first [and stop them as well], and then we would
always iterate those first (if device dirty trackers are active), and then defer
to IOMMU tracker for those who don't.

But given this mixed mode might be prone to regressions plus with me being
dangerously close to softfreeze too, I was deeming it follow-up. And hence
hoping I improve detection when the IOMMU doesn't provide the lowest common
denominator for the 'all or nothing' mode then it would block migration. I can
turn that if statement in {start,query}_dirty_tracking into an assert if that
improves things.

> 
>>
>> Qemu right now doesn't handle heteregenous environment, it's all of
>> nothing
>> approach even before this patchset. Additionally, I am not sure server
>> environments are applicable here. So essentially I kept the status quo --
>> more
>> follow-up is needed to support a mix and match of IOMMU + VF dirty
>> tracking too.
>> The challenge is having the migration state of VFIO device initialized early
>> enough that we can make all sort of decisions whether IOMMU dirty tracking
>> is
>> desired on a per-device basis.


