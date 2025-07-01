Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3476DC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwv-0005bS-Nf; Tue, 01 Jul 2025 10:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwt-0005az-It
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:27:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwq-0002Ba-Ho
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:27:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9Bjh028008;
 Tue, 1 Jul 2025 14:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=IEJQrAZ+AEitsGzJW1fJTmtHmUlT38TSm1H/oVwCsCs=; b=
 IwvSomLGJxRetfQD29/UMcjuDbfK56MnZAhUUCOEI4ZESvMVHMeETLnXMvIEYNG+
 lgjUUEx41OHSGk1Re8JJbQ8YraZPTw0P8p7qQBMqcnnkNC6rmC/B6w5UaBMkt0N8
 ncvdcMRa/yOtRkzssqOVmOmz/x6WYl/V/dlYWbnUAY6jegRH7SNMcVaYlZdsV0jJ
 EFsmT9vu73ScNh0DSq2VBeeH3hMrugR8hwcYk9UDtyux9MTxNe4PiSDI909PZFLg
 EyDlSk1K4nJQmqRRBzIpIgYRBK+WXr136iHKyffNngrUQZJcqaB7AntRlIhNo3ki
 TRagy5VJ1ecguEQtLu3vKg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766cwer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWG06019230; Tue, 1 Jul 2025 14:26:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1ekpmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt8QNsT3EuDijKUSoeOJHroksbB1rQVQZFbe3+N16oWuhE8QQvWE7ykFXOFNmRgCYVsPtFyZmoerowjzLTnmbUiypuM5S5Dsx6/7FVEvzDD1w8nm7+wzkqNXtS1iRDuUtWglEWzeBrLtVKi6BUm1E2ByN/EYNhYzkZ+n8qgzAzqdsztBRPjLf3fKNl71VxsLIONIi6ZSjmd4FgKOv5MtXDHOMA3MKWfNiJHP/ucsKNTr6b4fY4u7skt4RcbubSxkg577LlolGJfqM8W53n0a5/NkCFXbALBhoGuObP8OGy2AYa7P1VtqQNTLdHDeZpd3qP5NamiikONq7Ot/2mEz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEJQrAZ+AEitsGzJW1fJTmtHmUlT38TSm1H/oVwCsCs=;
 b=aXVnWWbeJuqz6T+Oy1rmkE8EGxz5qntL+ZImP4+T9Alli1yhPsSVuqpcjBFXqdz8TqUYBgCp3JDBjpC9cA2CbKEKrBN6wlLEyffTXsAcaVb7Z/+zZWddWcms9+vc4B1XlzkOmhXLRhJoFKWhssnk9SRwYWMHVbum68JOa3GWIYGz+ye4y0BmQsthjhbqANsW2JliyF9KsXp4DnRrKNnw0gktFNP69E+GRiIBawboBftShiipdzSJdc1G78jD7XKOJPO1Uycr0JMlnA96qdWsMTkIrY9JkjkSSToxsQxm+Wpga9L27rtwY1IcGhpcMLV2XKCwjEMsWvzHn0apEtaACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEJQrAZ+AEitsGzJW1fJTmtHmUlT38TSm1H/oVwCsCs=;
 b=J5xmdZ7+4e00AFzCKw4hby+S8ZgQPxalx3YDg7LyNHcmfkfqlp79jQu+EJW9RB3uFBDl9lklUqMrDIJyg/OfeUujfvvUpgE+QiNyM265y2oXUlIMinj6dlNq/0z/8MiSJGbqLjXavwWXEsy7rzY+rxgmaQz2klgBEftYiT8P8mg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 14:26:50 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:50 +0000
Message-ID: <d3bbce1b-4b19-4e3b-83e4-e51404b10102@oracle.com>
Date: Tue, 1 Jul 2025 10:26:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 27/38] vfio/iommufd: add vfio_device_free_name
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-28-git-send-email-steven.sistare@oracle.com>
 <0a0ff51b023df5e627981225bf229b4de0f9112b.camel@linux.ibm.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <0a0ff51b023df5e627981225bf229b4de0f9112b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF00013304.namprd07.prod.outlook.com
 (2603:10b6:518:1::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 234c5896-614e-42b1-e8ad-08ddb8ab518e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGZkaEVuTy9DWGN1UDdBdW5NUTN3N0FxajFDWGFDcldLZ0o4ZGo3bFJDcTFp?=
 =?utf-8?B?VCtNN0dvV0R5SnVEUFphdGNiQndFTlF0VVZCQ2w0eGt4VURoVmFKMUwvcUNV?=
 =?utf-8?B?VGkrUndraFJKeTRUZnNvS3daRGtDaHRlR2hwQ2l4bGtpWU0za2tuZkVNR3I5?=
 =?utf-8?B?dXJZNTVUYkxjVEczWll0UzZKdWNZa04veVAydnhqYVg3MGpVUC9hVlVuYTFU?=
 =?utf-8?B?bVFxelZjK053NzhSSEZ4YWgreVA3SU0vVnBBeFZiME4wUW1MNVp3eE80RGhB?=
 =?utf-8?B?d2xSMUhLZXRsODJ2YW42R2dqNjU4UEcvZzk3ZExhMmZvbEFlS0VIZDl1OE1V?=
 =?utf-8?B?TGFYaEpQdTliSlRUMmQybFd6Rm91UXg3ekwxUUNSdzAwcVQvM3V3djRpQ0kw?=
 =?utf-8?B?R3lIUFl6dm9nVE0rakt2bzdEbWdONEN2SmpQaHZwNkw4OGwwWFlLWmFIL1Ix?=
 =?utf-8?B?RTFsemN2aWwrbHBHTERsNXJ6TVNMOWN1UnRTT1IxU2poY3V0NWhxamZ2MGdv?=
 =?utf-8?B?ZEJnWWZ4dEZiNy91RnJkWHlIekpZdVoyempJWFJxVks4SVVoeVdXc0M1TGtj?=
 =?utf-8?B?enZDTmJnallmWmNUeTQ1UFdBK3ZFOHV0bE0va04xSWp5cDVWOFBzMmpMQkJ5?=
 =?utf-8?B?L2lMS1B5U1BzNWFNanNJNno3WjNOR3NZbFgzQVREYXZlUzhxa0Nyc3dBVWVh?=
 =?utf-8?B?ckNWL0x6V0RIbXova3pEZmZ6dmVGTXVFM1VNTzFZVHE2YkdDZE42S01rUTgz?=
 =?utf-8?B?THpjTzNrTGU2QXNvTnFsbFFkUmxWNWxuZUJjSm1EU1pHMjFqWVJKaitjcmNR?=
 =?utf-8?B?MFZ1WTJVQ2d1U1VGWlNKWFJ3ZEJZWXhUZW8ydXVsMWh4NGNHeEhLL3EzajRq?=
 =?utf-8?B?R2dJRkNWejRXQnFuODVlNXVEUmt3ditGRHJXNHVvOHF2QzVOOVc4SlkrWmtr?=
 =?utf-8?B?TEgxTlhiWmpGK2VJdk4rM0dXdEwwNGRKc2w2WEJMY2FsdGdZMnhYdE5idVZT?=
 =?utf-8?B?bkpXc2doVWlVQTFnUjZmUGZDNGJ4elM3N3NMYXFNZEMzUldCdm1FR1VBTnAx?=
 =?utf-8?B?SGNTNVdaaTYzcmxBbVF2Q0pNZTNjMVFWQ0w3clhZbTdUY2djZEtXY2Zvbmhh?=
 =?utf-8?B?TFVIWkUxTnRWeDBQaDFkNFcrTTBoeTVwTlRJUHd0QmVkSU1qZnJYYlRXOEs0?=
 =?utf-8?B?bFVrczdYS3ZwOUdpMHVldG9GTysrZzB6R2NVR1g2b1AyaUZmVmJsMW1VekpR?=
 =?utf-8?B?WXlYRXR5SVZZdGJlT1VSNVJnbFZtaGlUWjV6Nnd2MDJWNHJZeDFXQnQzVTlR?=
 =?utf-8?B?S3cxbXFkOExOMTkxMnNGT0V2ZS9ycTdSb3loS2QwVFZncnRpZDg2SmFPM2Jq?=
 =?utf-8?B?M0JHZE83ejJ1ODVsVDMvMFJMdS93NllJZ1M3VVpHVEZLYzdHWDBQRTJaZ3la?=
 =?utf-8?B?a2RJeENRS08vSVJCWHZlcXJhUXZpVzNUaEdFQWpEbytHa256RmxVcHJyZ3BL?=
 =?utf-8?B?cERkUnhPS1F4NDlPRlo2am50ZEthZ2pEV3pMLzJjQXJ4ekxoWHJ3YnBzazM3?=
 =?utf-8?B?WFkwWk5HbUs3NXpkQ3BUM2lGNFoyVDRUNjQwUTkwbFpjNzUzcnMrdHdyR0t2?=
 =?utf-8?B?M1duUHVWMS9UWmQ2MFFoV0pTcEp3TTJLY001MGxUY2RBUHM5YzlnRmdXb0Rj?=
 =?utf-8?B?UmwwZHdXMlg2cE80M0JqY2swQSs2OHZRSmRnSDU4dHRxTWVDYkluKzNTbml0?=
 =?utf-8?B?aFp5TW9iRy9zTUVZWUVMQVV0WjNjOVRjb2kvY0NiWjRuYjRkZmM2bENRZjZO?=
 =?utf-8?B?QXBJY0t1RHVCTGJwVldJTkNVYkNUcDBDcHZ2TG1kMTlwT3BOdVZtdmJBaTZk?=
 =?utf-8?B?UlR0RmxjQkJnRHI0NXRhMVc2ZEJTR2k5ZkZmeVppN2MrbkxWY1lQU0RpOVFG?=
 =?utf-8?Q?NtrqTzB85Pw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJIZElaTVBRMGdwM0QvWkxnRTczNktnYTBDdERDYmdUZnM0QllndDQ2dFRG?=
 =?utf-8?B?cTNYYmVFNEZaQjI1NTNyZW1BTnd5TWpINlF1dGlMb1RLZTZWN3lCTmlIT0NW?=
 =?utf-8?B?NzFUbXJ1VWJ1L3A2bUxSbE0yVld4RjZnOUFxZFNtTFU5NHE4d1owWmkwVTdl?=
 =?utf-8?B?WWxoOVVZaGRZWVp1M1hWSkR2dmI4WEhDcVo4U2k4bkw1WWp3aUxUUFBxeFZK?=
 =?utf-8?B?NXRJSUZSZXJCTGp4TzIrMVNiaXBtN3dTUVMyZDE5UEg1aFFpSTAyR1c3VWlG?=
 =?utf-8?B?dzZHRmgrNXVpd3ZGNnF2cE80dzErUUN0RDBlakZRZ2tQbXFHK29NRDEyT20y?=
 =?utf-8?B?eVV5YzVLMVQwRThxWURSRVdHYi91MzZjRjRnWDl2NzY2ZTRpNm1HOHZ6UCtE?=
 =?utf-8?B?Tm1QNzBJNUpudlhHVCszNW4yQTBqNmwvVFczTWFWVENTNE1aUFB2QVh2eFF1?=
 =?utf-8?B?UHdBTTFJS0xIQXZQbmVNU3FtNGMxQWNBTklCRDVSSUI0cXRpY1ZSVzJlb1pn?=
 =?utf-8?B?aUZSNTFaU1NBQmtZVDFiRkhnZWpYL2E0bzlrbHNER0tKL2pGaUpmSjVZckJj?=
 =?utf-8?B?cS9qUUZyM3hlS0tjMmczSU5ub25FZndaUXd6S1loTWFIeXcyOHExWFhPUnlh?=
 =?utf-8?B?REJuREFYaDFiWEFiNlBtNklFNllWVnNZdDFrczdHMmRQbFMvRkZIMzBvbStX?=
 =?utf-8?B?d1NOQjdoRlFzQWdLL0RpZFZFTkZuQ1AyYjQvQmNIWDFleDQzWUtrQVRqaldk?=
 =?utf-8?B?MG92Wjl4dklwaXc2QXRXWDRjWGwvYUxkTGRFdFNBSVZ0ekxZSDlORXRueVZJ?=
 =?utf-8?B?dkRPYjhlUVJBR2FodW5ydDdxL1lDZkw2SHBQRk1tNHNmdlRsTG1GcWpCSUd1?=
 =?utf-8?B?WnVLVFNFMXhId2gwNDdsd3cwT3JROW9QQzJrWk5KUDArZjJsYXFKeVhIanVQ?=
 =?utf-8?B?a28yWmNzT3lJUnlTdkM5VnhrZE9DRkhtRk5RSjdacmEyZFZMS0N5Vm9LNHVh?=
 =?utf-8?B?Um5CamZDc3AzbFhGRkY4M0VZSTArN2FubkljTllsQUpybFFqbUU1RWYxWnJ3?=
 =?utf-8?B?UTlpOFZ0eFQ0T2p3cnJhMU56Q0h3U2Mra0c0OXBqck9kUzhYVDRCNko1MVl0?=
 =?utf-8?B?bFNZNTRld1lEZi85YVZFSjBLaUFxTmdYT2dLdWZQMmV3WE51S0IrWU5UdFRi?=
 =?utf-8?B?Snh5TEFaZkNxcE9jdkJJR2lRdDJwa3k4bG14dGdIaFNNNGxTZ1g2RElVUWpi?=
 =?utf-8?B?R0dhZTNWUlpUWUZBMTZyWklreXNLRnFvaXlIdDJOazB0MGpvTlBlVnFEaTVp?=
 =?utf-8?B?RzB6UStmOGFUQlpDdUIzSFhPYU5YYS9reG95VlNCT3NGQkw1QmtWQmJIYkFs?=
 =?utf-8?B?cHlHak1oZ2FrSnlOREZXQlBjak9iTlJLRzRNbzQxeERtZU9zT3F1ckltWVZn?=
 =?utf-8?B?dFRiRGtyUW1JVERWQWQ1Z2FKSUdsU0laNUhVRTZqaTdsV0dIKytZV0p6WXhF?=
 =?utf-8?B?MGJ3c2ZnNXlzdDM0ZWdEVXVSTk8xdXhyL01LVFZqVndHZ0dYTXdFbDBlSjZs?=
 =?utf-8?B?L0EyRnBSMnpXWXhCQUtZbmJLR3VyRy9lM0RpMmRGUVAyOCtiTmJuTDNPcVk5?=
 =?utf-8?B?RXFma2V5YXpXL1NSRDFBRFc2eU16ZGNrM2NKTEU0ZHNIYWljb09RMDM1b2Fw?=
 =?utf-8?B?MW5uaEtjY2dSMWdUMm96Z3RrdzdnSWZvNUxqSTNhR0NWQTNENVJwSlVnbEZl?=
 =?utf-8?B?emh5VmRmUkdOVm41T2JPNlVCQXZtZ0pSVGcxb01vVzJpZng2MW11TnNMRy9L?=
 =?utf-8?B?akpPalRXSkhoejhTMUViU0NhMnVSQjdseG40eXJodkJsM24xYVdLYnBuNEpB?=
 =?utf-8?B?cmV5RmZudUVGZnRtK3o2ZjJvTzZSQ3J4My9MQlZrSmV2UUJLdkt6SW5oUlRi?=
 =?utf-8?B?T0x1bG9lbmh4NmJnL0VFZHF2ZmhtUkRRcEJvcGlYcjZLTVdHeEY4WGdmU0dl?=
 =?utf-8?B?YTJLWGdVbWVrQkVJUXc1R1BLMWFXeXhoTjI1T1lVV2orNjJjbHdrNGwycVpj?=
 =?utf-8?B?dVQ5c2tCdVRrQ0JrSEo0OTZaeUlqbFpKa2lFYkVJUGJGbHpmUUlHUVhPUUx1?=
 =?utf-8?B?ZXR3M1BZRitXWkkrSkxSZy81V05RT1BVMzd6UjRMK25sdUUwZ2dtR1dBVXJH?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8evQEuBmYsUiv5a/K5SMHbwiQUuQkMCAJ6OkkVR/w1DGMhMla8vpQD/qgwsWRCEe/UowxOVudibSzBCoDuEFz2dYZIdAM5rch76mI5Z5WVc6XVBurSQ+2KSXifaECeI1f1Lk4Tj/Cugca9Ycg5SRNcKibJcW9/QhBi7hMA2zHajG2FFFH/78o/uoiNZmz2nw+bjeCZppric/4Dxe+UIH91DQmU4cLnMZ9+bv/nLq04GU+QTyW89MSD6h9E718IowIMS+xkWRM4296OS0P4sVlOzKFkRa/9GxuLlLHmh/sqKIUOThIq2lpWxBbsPHIGZNxJPwCVcV5YW+rE24XjQ7XluFAeqe3D1sU2t7AbQqBJbPeyhKRG6BMkU1+2EFwuTggt5OTKba2XMdorP8PsSOB2xbRzbWmrmESz+GQbMoMmUTglDH3y+Oy+Nm7gCz2tjsEg0NDoksKmfH0lrtyQByVhjApJXMw+HdnA+Wl+/pwV9K2jMI09brW7tvWytt89GFtSpGcW74TFUPwIf6c7GAObVrVADN92U/yu+QjtH4KXjgF+gS+YsZ076lByZ25VZT4PKWWVAd6ETLYCjI24Bf7gbtusQiG6vpx23kASE6PdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234c5896-614e-42b1-e8ad-08ddb8ab518e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:50.5648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26XYyiB3cegFe1a1ShayKFw78driJr7WJzvGmRdMTVKGuZ8WeY44kZlFoesHxH26IzCpVy3S188I3Ym+95zMe9EIxlrkOy5ui0eo/u9Ict0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010094
X-Proofpoint-GUID: uTF2gaiUSF1wjyAILsE3f454opPFIBuF
X-Proofpoint-ORIG-GUID: uTF2gaiUSF1wjyAILsE3f454opPFIBuF
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863f02e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rSw3YGzbq2frHgQ4QjgA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfXzOHyG0l4oK/8
 LlxGz84YqGzR6A/XKqyXS1ss0bLpz/WTog+fZ91PaPsVRcwKj88D4PJSxjlx54GR0y/OGaXe1Fd
 owQz9nroSCTmL8Ct1fiC/pSAZhA+rOQsPGv5ulbjeOYihP5Y3YgyiPt9D8RNP6ADkoBzanrwmVq
 oGGzRgl3m6M3rxP5PaI6EXNkBx6v1Qch3kZP7SBkGsrZ6InGTHa1D3QS4r1PK3kdHRt7b67bNZW
 LQnqtg5F6jD0M2eI5B37owbQbJ9YhEJydtwRTYM351pEwNJub/lvf/IWiNmNo+LgPwMeuSpfIvC
 rcuXUlGrmVvshW6asWXUbUVYOvaOK34CuiM6inHW346/5FRaPtnbhqbksSgyQ7u7VzYCJap/EDR
 XaHZ5o/7mUf5gcyP+2kvyFJk5QsShGd7+vo7Pfx9dPYZVzWEgCCEZcn1tFkdlIRNKmZsjUiW
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/23/2025 9:50 AM, Eric Farman wrote:
> On Tue, 2025-06-10 at 08:39 -0700, Steve Sistare wrote:
>> Define vfio_device_free_name to free the name created by
>> vfio_device_get_name.  A subsequent patch will do more there.
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/hw/vfio/vfio-device.h | 1 +
>>   hw/vfio/ap.c                  | 2 +-
>>   hw/vfio/ccw.c                 | 2 +-
>>   hw/vfio/device.c              | 5 +++++
>>   hw/vfio/pci.c                 | 2 +-
>>   hw/vfio/platform.c            | 2 +-
>>   6 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>> index 6eb6f21..321b442 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -227,6 +227,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>>   
>>   /* Returns 0 on success, or a negative errno. */
>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>> +void vfio_device_free_name(VFIODevice *vbasedev);
>>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>                         DeviceState *dev, bool ram_discard);
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 785c0a0..013bd59 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -180,7 +180,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>   
>>   error:
>>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>> -    g_free(vbasedev->name);
>> +    vfio_device_free_name(vbasedev);
>>   }
>>   
>>   static void vfio_ap_unrealize(DeviceState *dev)
> 
> ^^^
> I suspect you want to convert the g_free call of the VFIODevice name here as well.
> 
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index cea9d6e..903b8b0 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -619,7 +619,7 @@ out_io_notifier_err:
>>   out_region_err:
>>       vfio_device_detach(vbasedev);
>>   out_attach_dev_err:
>> -    g_free(vbasedev->name);
>> +    vfio_device_free_name(vbasedev);
>>   out_unrealize:
>>       if (cdc->unrealize) {
>>           cdc->unrealize(cdev);
> 
> Similarly, the matching g_free call in vfio_ccw_unrealize

Yes, thank you.  I will do that in the next version.

- Steve


