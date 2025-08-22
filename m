Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77F4CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 18:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upWcE-0003HW-LV; Fri, 22 Aug 2025 14:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1upWcC-0003GI-FA
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 14:35:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1upWc8-0006r1-GN
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 14:35:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MIX7gl003804;
 Fri, 22 Aug 2025 18:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=NJ2toBvOdS+y772ICG/PBGgPsmcWp+qpPN00Ci0McfQ=; b=
 Xv7DUYYn3kl58wTzIj8RL0eWLmbGmbMojAn3IW4pyGcwbcIM95UOSetIaSZ7Xyfy
 8PDqnZbq9qI+/NI6IMSTk8S0UjbYSA9d1xrOch1LTdT0tRFUgG2Hs0FDPr5DCwiW
 GilZYX+WuiFeAGU/XLa/AMRgEwSlWnk7DWEPmUvWymohLUxhx43f+4blI8tbDQqk
 lwYrgCRo3EgrrvJvkw90+VVo1sg3bATWetgF7j4+4s7AD4LjXc/mRgjk4hhr3wwg
 39/MqpY2vSWaPzB54gpSVagE1jKvwbYsRK7bqTyHrhmSqTYifY7wnMddqpNRJMzg
 5aXx0XT58M4+JaYiGyw76Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pw1a03nq-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 18:35:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57MHUEAv030226; Fri, 22 Aug 2025 18:26:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48my3x08xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 18:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zES+GrSG8IKWHdvwcda4KRQ05cOCkq2EXZunJ3LF4I0uUn07ndwiRmTTE6XtUP9CsCooQv/ZZ64L4CCBeeQOIFAMwT4sm8KwNfDoMTY+0XSe7LR/AwtHhdUAQqCsiUzeJh5aOVEBY2V+CibXRaAVQ7x0r0bFfK3ZXbSczJGE4cBR1AfpLta1N91R8ApNmz/3NnBbT0ipKgkYS3ZqHDcy0Xx5dJ6is/6T2B24+SFKbGJadK+0NXyGbrEhQPmHHR92G1YkoRt0RrdV27bJI5SmB2xbwfPWrGTz+sfB0UjLxTo9Kpyp49XitiUp0TTVzUDRzuYSaKk3aQzS/5tukTTikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ2toBvOdS+y772ICG/PBGgPsmcWp+qpPN00Ci0McfQ=;
 b=o/AP4LMxLG5MyvAwgALdTIT38XDyRBdFNunXEgDAwzMXWt9ZbjCw4OZ1sPZ5zFsiHuIJtep5oVDOU2AVMYjB1h7GUV/vFmUdYiPw8cU/wwWcwGLjRCIo8SFLUqS7SgiBRvZu8OL9zfLlvYNxjA+3aXn00W+3FmuU9h7FTnxYO/E3c+8oP0pvglMg5wi81LtDzsiOn/LIBUwmS6x92fHgevwkD3t9G7gU705xk1+B1tK+xDbg5K34yxd8Tx9FxAbabSCEK56lchvV0BHBXzq+7BnoCDDx5V0TkB1BmJe4Yto7Y97YrBQhWXPFbb5O9BCUGRnHtF6aPYioKFRs1WFKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ2toBvOdS+y772ICG/PBGgPsmcWp+qpPN00Ci0McfQ=;
 b=Ze7TxPFIOr21UCO7qzMVkjfLye0NXWPu+ovmE1nQ1CF2LBdWTRomfig32JnkCWOyWSq52tMPwCmY5F0n+OVYygZ+KHw/CD3JWkIabY2xABu+RmlRR7qQbqe/1VH+cq7xiukzZEsuYWH0UydXWRWFAxYazLfTBXfx6x/hEWbhB1w=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 18:26:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:26:18 +0000
Message-ID: <a352eadd-1d43-40d7-a46f-ba5b52409a26@oracle.com>
Date: Fri, 22 Aug 2025 14:26:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 5/8] Revert "vhost-backend: remove
 vhost_kernel_reset_device()"
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <1752777568-236368-6-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1752777568-236368-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 53249084-2b07-4429-fd4d-08dde1a96327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDBtVmF2ZUE3WWhTT3JoUXk2Y1RrOW1zYlA5OWV2dExhdmpCOTlmZEtXdEow?=
 =?utf-8?B?Rm9wcVMvSGdQaDZzeUJzTWgxL2FxVEZjOWxjWmk2SVlxcDd0QmxZaUd3TXJZ?=
 =?utf-8?B?RW1ySG11eHE4V1R6dElKWnhVVkM3dGFTeEZ3VjluOEg0SXJ4a2dqL0ppMm9Q?=
 =?utf-8?B?cFNtK1plL2VsQUZrclovNHV4eWlQeWF0Z2drYnc4K3g0U3lKN2xjU1B2UlFF?=
 =?utf-8?B?N3prbm5RYWUzUnJHM2UzKzJSZVBPNHhuU3JOQmF1TVdOeFNoOFQ2WjRBMUY5?=
 =?utf-8?B?WGQ2L0pqUmdVV2J0Vld3Wm9XMUN5WU4zRWx4VjlEMDNCMDA4bDA2MXNKNXgy?=
 =?utf-8?B?VnJIYmtBZFpHb1dxWTRRdkZ4eGFYMkZqTXdzbzNlYkJqWGVGSHIvcE93d2ho?=
 =?utf-8?B?c0ZocHdIQTM4N1ZJcExiYmo4U2NKSEk1eE9WZC9PYmhUTlVUeWxJWlJURW9a?=
 =?utf-8?B?enBGaGYraUdrckZvZ2dwcEV2VzZFbkdkNmdYSW1mNDFMSXlrREMvL2lOdWVB?=
 =?utf-8?B?VitJWWpIdXBLVWtDcWdyNFdQSnlDZkZKeGljL0V1cWhCTkNUZitscmNvc1ZM?=
 =?utf-8?B?VFBHcktHVzVmNUs2S1hla0NzVk5Sb2Vid3NOaVR4YjVnWVhvMlZlQTBCQzJP?=
 =?utf-8?B?MWgyeU5aRTFWOVdyRWtKSmhNdVZsZHIrbmw4TnJYM2tDb2luR0srMGZISWdO?=
 =?utf-8?B?Z0hlZnJ5MTBlYU1aODBld2hrMUpseXg0QkVmT3VXbmdaRXFuN1NScThXa0pY?=
 =?utf-8?B?VjFsU2U1WFVWYTVVVTI3aVh6czIzdkpkKzlxNmNoUDFEMTk0K1M3eXd4WjI4?=
 =?utf-8?B?ZFBWRDdZa29PRWJmbERhSzRxQTBSMzBMWkVvbWYxY0ZLQUlFbjR5RWt5ZjZY?=
 =?utf-8?B?Ylp3NXJtZ2ExVEVUWTVaLzhxZExyczU5bnIwY0N5MUhQSENUcDNyQWZHVkxR?=
 =?utf-8?B?ZjMrZ09GMFVQaXVUSjN2Q1QwK1ZFY09VTHNSR2F3elljbEpDeDA2Vm5rMlgv?=
 =?utf-8?B?RFVjK1ZGbllQZnl4MG5LWUtPRUgxSHMxRy9tQ3dmUVhpY2hmYlVmZEk3V09I?=
 =?utf-8?B?OW5IWHVSL04xVUN4ZUFaTnlraHpLellPK0pXSEVmOGQ4bGc5WGxJY08vZTZh?=
 =?utf-8?B?NFdtdko2eVBwcjhhRWxDbHFBcFpXbmhJV215TUNSOXREOWh4dXhMNTJtbkJ5?=
 =?utf-8?B?amhzRjdvWENucFR0NXhLV0lsUmR2dVYveitHNE5DUDZ6dm54Wm00SzY0ZlNM?=
 =?utf-8?B?VkNKUnlMY2NrTjg0azZSNituSitwS24zR3RYV1ZHZVRVN1AzY0lnSGdSNFEv?=
 =?utf-8?B?amJvUElPejlPMks2blZ0VG1JbWJiMUV1T2cxY05ZQWZFL0djRWNDbHBTUGth?=
 =?utf-8?B?c2hTMnFib2VvV0dhM0FXVlkvc3BqNURNQmpuN1BndWs2TThhQVJCeFU5eUpO?=
 =?utf-8?B?M1lyR1FhWGE4TFZvbFlyd2VKdUlVQUM4QU9CWjAwVkJMZUsrNUZza1IwakVB?=
 =?utf-8?B?eldHME9DTFNQK1dkQzV1TkVWaS9MM1BueVBueUxRZEUwTU5rMVRya1g3U2R3?=
 =?utf-8?B?R3pCdDZrRXVEbVNOd1FBdGNjd1krVjRSN283cnZ3WS8va0g2UEtqaUpSY1ZY?=
 =?utf-8?B?eSsyOWFCamFpM0NTRFlPUTQxa0RmRnpuZDNxQmlsNEF3ZG5SUGlWeldPYXpv?=
 =?utf-8?B?VzZ3RnZIbHBCc0d3YnJyV2xJVzJQWkxLbEtZdm9MVE9HbkNVeEVuTHZXTE1G?=
 =?utf-8?B?b2tvQzRyNEpmeHZoRW9HS1N1cUxNclczaTFZcWZQMVMyUVlzbUxkcUdLaXZa?=
 =?utf-8?B?aklvYU4xaFVvanZlN2E5aXVrMHZHbGhIbEVJcnh5QytuaStOZlJ0ZGl6eHVw?=
 =?utf-8?B?SU9oY1BTbVhFVy8rZCtBTXlRUDhFbEMyWTVDZnZSbG9EQWk3UGxIam5Zck1t?=
 =?utf-8?Q?thdLcBebO2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUQwWm5OZjBDb1RER0F5bU1IaWRrN2M0VnBRWEl6dkx4dmM0ZGVzejZ2Yng4?=
 =?utf-8?B?UkR2eU9SejRTWEdJYTdYemRaRHJMNU5xdG9pTHgxeFRkMFpXcGY4TCtQaHBF?=
 =?utf-8?B?bG1NTDE1VG9nWEszWUJBcEhXNE1oYlhrOTA4M1l0NGl1TUVNK2UyMFNsNjF5?=
 =?utf-8?B?cnFkbG9BTE9UQUpXbTlzYVBlbVJSRk9ncTN4bzNGUTBzVWRxUTV5SG5MUnVq?=
 =?utf-8?B?UlFzYjF4bTVuSyt0clVSa3EyVXAvckpKWTl4VGtVbk1BVnAvME5KMWxtMGVk?=
 =?utf-8?B?ZndhRHppQm96TW5neS9vODAvSG82M1lvSW1WUkZFM2lmREd1TCtnUVJUSGxj?=
 =?utf-8?B?OWFmdmhpK3NSY1VjRE1uZE1tSnVmMHZGZytvSlJsblpXTVpXQ1dwcUJJQ05Z?=
 =?utf-8?B?ZzArTjdFSVd4UHlTcy94aWJkSXhjREp5WGdMbnVlWWhWajk3UEQ2UGpNSmpp?=
 =?utf-8?B?VXg2U0ZlWE8rZWdzb1lMMjFXWmV3ZU1rVFNKT3duOUhSOHhrMXY1Y2V1djRx?=
 =?utf-8?B?aHhaNFRMcnV3WVdHNHNOMXBraXpMRHROTHRuOGluQkoxKzZlYmZ2UFJ4Rzhp?=
 =?utf-8?B?QVNMUjlyS1hCcnJ4emI0d1c4VWhBNlNEelZ6L09YcTIxekw0RVhnd0RoMGtN?=
 =?utf-8?B?Y3ozdnpBc1JzZTkvZkU1ZEVzRTJWZ1hZdngzaXBoYlMyaHJtK0FmOFNTNzNz?=
 =?utf-8?B?cml6VFJ4d2d0TnVKZE43bmdVRkkrZGZha0hOa2pqTTFwd1FPTFROTTQ0WjlG?=
 =?utf-8?B?MlVEd2FzaHo1MXBaeXBKSlNCMElnVE1GNW5QNUVscHl0TkFpakRENGhMNFlZ?=
 =?utf-8?B?T2M1SUVDNFAyTmIwek9UaCtjTVl6b2taRnlMYktSOEtCYmF6dXE5bC8wcnlY?=
 =?utf-8?B?U2JHVEovaUdzOFFjTE83bTU0UDJ1Nk13bk9UKzAwNWhqVnFtNzlkcUlDSnZK?=
 =?utf-8?B?WGFLRE13bnNHZURqNUlSWWwvUzVsazEwdk1KL1BTVG1VNTNoMDlHQlNnNkJJ?=
 =?utf-8?B?UlZCVEp4VXdGQzhzeVlyNXlxM2xGRUpjdHM2WlFySjNSUkpRekZBVUhBUHNl?=
 =?utf-8?B?cDNpRmwrckY1eVlsT0VEVWlTUUxRSmtCOS90ZjZtcllwTmdURmp5SU9UbXVB?=
 =?utf-8?B?MC9uVlBhZEhlK2JBSkhkWXZmdlc3cFlNOG53eGRqMGRTdEE2Uml0a0dPRmJh?=
 =?utf-8?B?TVY0bDZSS0txMHBuNzdOcVZsbkZzdWROckk0ZHROd2wxbVNyVlRSMVF4aWt4?=
 =?utf-8?B?a0pwVTJBY3YvOEN0QmxVWk5JL3I3b1ZzWFo3UjFTL2dYTEZ2aWQxT1k2cG10?=
 =?utf-8?B?aWZEMHZHZjJYT0x2bEtMUUt4SW5HVU83NGQ4eDR2a2xaL0RDY0drWGpTMUFY?=
 =?utf-8?B?Wi9KaVRpRWF0OG5lS0JSZUdFTG9yRHJJWlhGaG80VE0zWFNGRHh1am9YRkli?=
 =?utf-8?B?ZXhEekFLZ3QzZVRBaVZzT1FLQTFNR2phNzBKbVV3dTdzbS9WeTZ2QW1EMVVP?=
 =?utf-8?B?ZmpnaUhRVi96VXVhWlFONThQdFJ0UjBNTmlJNHZVNkR0YW9acmt3eFF1VXYz?=
 =?utf-8?B?UHpYRHlGVmpId0RxMG5LZndJaUY2anFZd0syRmh4eDkrZjhhbWlOQWNjYmJG?=
 =?utf-8?B?VU1XdkNjY045ZEo5WklOVzd2K2dQeXkvWm8xRmdKWkxGa3lxc0I0MnRTanlr?=
 =?utf-8?B?WkJuYjZzR0JvcTNzaXpzemUraStIeFFVem4weGtYKy9udDUxS2ZkUFhiYlVP?=
 =?utf-8?B?ZGNMN2c3TVk4dE40ZnhtVVVsUXI1NUpUZ1BKVmV0b1VhMWNNSG5NRE43bzNk?=
 =?utf-8?B?VFkwZFd2YWh4RytCdG15TFZaV25qZ0dra2tkSHp3eWQwMXEyRGJFNG9DUEZ4?=
 =?utf-8?B?Mzd2NHNsQ3E5eSsyNE5YcVNYaUNUNFpuT0l2VzlpN1pmbHhyWWxKTnY2MExK?=
 =?utf-8?B?cTdlbFlVU1JJVjRqMnIyNnFUd3NrVG9xNDZ0YnVlYTJONi81dkQwa2ZIeXJI?=
 =?utf-8?B?dVBnTTd5ZWI1OGUrSmp3WmFJaHJmZkZMb2RwRmVoVzVFd1VYTWM0anZIREI0?=
 =?utf-8?B?YUF6OU56eVMwanJoelpka1V4OXlic1lFYTJwUjVoYjNPY2JWRFJxcUJ0YXRr?=
 =?utf-8?B?UWlPcFd3L2ozQWJlUWFYNDh3czJ5dzhieXorMnZqRDl6Z0tmdkkwU09TWURT?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d4tQF7D7zBYvHv7X1uIb45CkBcNgP5MMjXzYolvmnlFob1r47p4iHPH2jLsOD5aFeeOV90BqzeR7Ba082UmmiS6LnMlwP+u+DIEvS5qrZskoBDMJH64mFqRLTGwULEAxoQ3NbKVuDE2/0U1SO0saVsKMOh6+FPycp1Yqkzam8Fu9m57EFY2oypIIyNbyxItMnXGp/UYjgbLDm+XVZiI9IU8k55LqbSo/PJTKfKTMYetsYTUmEKvfPrwl67sPVUXxPaSKoqVXZi3Y+MbJuGeiCPW4p0Mk1VA7L2LwiLoF5Jymh5THuMYCpdas6H6ZuTuO77ARkmS9rNe4f4ixRLLj2mj1+IoSr+kiOLEivI9JGhUWpEUgtoZSGOcofl7Tydk7xEZvIHTT4fGxw4if0/3f6qGb3mEAlNWLvbr+ph5VDS5/vUzSwoqoJgNwjhesHvT8rHZFves2AMDPYNwvrp9We3uz4yduHR75bgw1bPYd7ye9kv+q3cxblxrE4wHr99vMtdVBAWYiOZyhat68DZZfP2IpNImgSNqQJnYEvyNKuAN91t0hzqm5BfzAX85X4jUXay1s0DmrLsdOFEATJMh9MVUv+YxevZKYAP8v40Wa96w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53249084-2b07-4429-fd4d-08dde1a96327
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:26:18.6799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKf2mOSN2jJYf6TjfHLaySRisAPGzqt/Eqr3hJCGVGa6j+HcZGEypOhaeo+95vVksxrhgMQLxob5RNrs7edMtxWuoUKmDpY4cmME5db90eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220169
X-Authority-Analysis: v=2.4 cv=b6Ky4sGx c=1 sm=1 tr=0 ts=68a8b87d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oFhYDOKIYjcGgn7RrrIA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX8IIbjPcYKXzN
 TcAAxOkqW3NMtaLFVxrCqmMrfMB9FJpuwi0qpts9g9nvpXYHguihVpJz1bvPbM7Ij+ne03DyBtD
 lQUUOlYRkmo4IZd7S7n2tzTRxGQZ9j+8ww9/Dii68Lcikw6ugSGVjNcfeaA1vBq6XPvnQq8eI1Z
 WMM9Ik1nWaEGBIQFgOxuR42pR5ZQWlHYGVCWwQTapONf7yr3aP6vIGwcrGTi9FjkQ40UvPJGoH2
 i4WN+AabP6tD+oBGqa6LwP2s7VUMvTvES/iBjp0b3odeea9fCcnK4eQPsJGgmn1anMhdFm56GKY
 mN23vufZ7GK4ZoS8FQrxTmXN/Fk75JE2biGkBHSt9CJpjsVWRkNiJ2ISIdmgsHy78tBxZrmCR6W
 aFHA+koPhWUU3cCGmAA262fLKadBOw==
X-Proofpoint-ORIG-GUID: IKcPP3lO0HMrEShxNkt4Fe1etavJzezc
X-Proofpoint-GUID: IKcPP3lO0HMrEShxNkt4Fe1etavJzezc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/17/2025 2:39 PM, Steve Sistare wrote:
> This reverts commit e6383293eb01928692047e617665a742cca87e23.
> The reset function is needed for CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/virtio/vhost-backend.c | 6 ++++++
>   1 file changed, 6 insertions(+)

This is broken.
Drop this patch 5/8 and replace it with the following.
I still need to refactor this slightly versus patch
   [RFC V2 3/8] vhost: reset vhost devices for cpr
before posting V3.

- Steve

-------------------------
From: Steve Sistare <steven.sistare@oracle.com>
Date: Mon, 19 Aug 2024 11:16:27 -0700
Subject: [PATCH] vhost: vhost_reset_owner

Define vhost_reset_owner, needed for CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
  hw/virtio/vhost-backend.c         | 6 ++++++
  hw/virtio/vhost.c                 | 4 ++--
  include/hw/virtio/vhost-backend.h | 1 +
  3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 833804d..54fc8ee 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -221,6 +221,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
      return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
  }

+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
  static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
  {
      assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -345,6 +350,7 @@ const VhostOps kernel_ops = {
          .vhost_get_features = vhost_kernel_get_features,
          .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
          .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
          .vhost_get_vq_index = vhost_kernel_get_vq_index,
          .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
          .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 40d5cd8..72e010f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1522,9 +1522,9 @@ static int vhost_cpr_notifier(NotifierWithReturn *notifier,
      }

      if (e->type == MIG_EVENT_PRECOPY_SETUP) {
-        r = dev->vhost_ops->vhost_reset_device(dev);
+        r = dev->vhost_ops->vhost_reset_owner(dev);
          if (r < 0) {
-            VHOST_OPS_DEBUG(r, "vhost_reset_device failed");
+            VHOST_OPS_DEBUG(r, "vhost_reset_owner failed");
          }
      } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
          r = dev->vhost_ops->vhost_set_owner(dev);
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d6df209..5b68bfb 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -190,6 +190,7 @@ typedef struct VhostOps {
      vhost_get_features_op vhost_get_features;
      vhost_set_backend_cap_op vhost_set_backend_cap;
      vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
      vhost_reset_device_op vhost_reset_device;
      vhost_get_vq_index_op vhost_get_vq_index;
      vhost_set_vring_enable_op vhost_set_vring_enable;
--
1.8.3.1

-------------------------

