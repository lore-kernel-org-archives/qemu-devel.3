Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D4BC83F0C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnJz-00038M-9m; Mon, 07 Jul 2025 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn06-0005GC-Jg
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:39:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYmzz-0005Xu-56
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:39:21 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DC5iD006381;
 Mon, 7 Jul 2025 14:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Ui+2JQFnQGOiHtpL4hOsKtcY7+iCi3dyGf34Kr3sooM=; b=
 SxvawF95w/2snIOTxDQV7HYTb22QPkpKQSGG1EqloS8q7X+XZycYxoj7hHL1XwdS
 5Elv/YLPe4nsQ6QQeHK8PNdWiko5krJnXW7P9HAdNszB5P5Nj0tgA4lk3Txdzf5D
 bRyKWW0TKptrWbgWYtNk4PZLqpJ+q7yJ5TiIH6/l/CLyfwDALmA/fy9imFM1oYuF
 4Q0B44fhTPdBHSqY/uf9eiHkP/P0fv3LEYgdU9nb6l9KWI8gnwoqtA5O35hWfUWT
 irDHLJl3137axofIK0fR1mqDvKbgluHhI8UgnLgORUByvF/UHCKGV4rlDoGm7cge
 ggpPDx5KOJTU/w7scjBkYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rewhg7k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:39:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567D8miT040458; Mon, 7 Jul 2025 14:39:05 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg8jurc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqQjkm/+k8G+Jj+HYKZ/mfBZzBsiq1w4qaknTxqjym1vaf6gg4CVMm/q3C7im2bCGH92bxJfXoiUS6v7+032INqFr9uCf6w90FjHLLYButTSOU5S6t4tuu/svcRUk4v+AAxI3DfExYYnEZFv9KHnW4/ntCAYcQoptmEU6zVe02Ec7cPLNbJKWFNnapc3ghW8Vi9xx+c4mNBgBMeqtjLvOVZWJgxZZ+3Ivea+5H+1ZwyN6y52x+25RBwL7lJz/03GrbmMpwhuN9w0eaKrrvoAhq+UijjKPEdqIztNK9nibdrtE+aQSZlCm6JOnnY5WmrfAKGWstTsD5zJfXCXYm+C0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui+2JQFnQGOiHtpL4hOsKtcY7+iCi3dyGf34Kr3sooM=;
 b=r6Iv1ZZN4cBW+ASSbHSehhlPnkkS+zeLMcogAFOXAqWum424BGYSuC7+ZSzU1CBNXgUj+nqYa4re/RfWPHOc+Y+MmdBO15BFeKIJHXRYy0aqe1037FAtkgqD7QCeMTsdjj3Fw1YfnIo5D0ry2X9cOtQ5DWnnVN2P/IFrkOVLPHuq1MiVpa6JVWBD9Oy1kYIkUZWNdDGRMmw+5KTS3LSXzytqJpCUGRsZlIe3eu8rFnLUMDllKVpqY46ZWHv2mvPbEqyTWFiBXJqBUgzoEJ55wpWFf3d5JRUpNgYop6THmNl9MQtqfywLsvAL4vET1ka1dykNrLx1lEDbeAgWnBbnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui+2JQFnQGOiHtpL4hOsKtcY7+iCi3dyGf34Kr3sooM=;
 b=Mrjcg/5JURengWWL7aVjT37ggT6pufv1sF9ywgiAQILl+V/juDsOXgEyO9qzbTXyquKODoaT6mUHick+ngoyGS5FOudAbd1/j76rHnRBkWDzPqFeZpNY9Klb3moeJQ7Ha9HkQJREg8dycSOdp+phSk/P8B56lLRmPAZfjXhV1sk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 14:39:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 14:39:01 +0000
Message-ID: <39b44d07-f093-41db-9784-b0d029b7eb34@oracle.com>
Date: Mon, 7 Jul 2025 10:39:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/5] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 devel@lists.libvirt.org
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <87v7o8m99x.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87v7o8m99x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b392a98-5d17-414a-0676-08ddbd6403a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTFuZXFEZGRqK3hWanJJZkNxaWo2NHU0UVFYdVJPQy9VRklpWkt3dHlBMGJt?=
 =?utf-8?B?UXdFWUtnbzVEdHh0K2ovdzMzWnlYS1l4YzlEYk1PZlExRExSOWprWUtUT1Uw?=
 =?utf-8?B?MHY2eHB2aTYvMXNHcy85cisvaUxKcVZob20wMkJCMkx1YTlkMStwN2xldnNm?=
 =?utf-8?B?dng0OXJ0eUUwVHNUb3BaQUxGQk9DSUVjOFpUZnBHWFZadnQ0dmdWdVdnTlVO?=
 =?utf-8?B?WXJBeUxvaDZ4RWVzOVhVdU44UFVKeFZ6RnRXb1UrODRJUzFYcTVPdTR4THFS?=
 =?utf-8?B?T2g5VklIalVEbVprWjhiVjZpL3ZJRHF6QWlxTlZSQ3NOamQ5bE10L0grM3Yz?=
 =?utf-8?B?L003OGZiMXQrQnplZ0N1cnNUcUV2aldjVGlkYWRwVDMyMGFvdG5qdTdoUlFn?=
 =?utf-8?B?ZEhYMG5xRy9hZmVWb2Nid0N5cDFKZUhicUlNdVl2WlRMMk1vN2h0SCtWeE5o?=
 =?utf-8?B?cTNHVFZqU1UrM3ZHaVlOdk5mdUx0cWQ0QlpVeEUrTXBKMCt1WEtaUXVpRmRh?=
 =?utf-8?B?bmVKLzZRNkRBZ2t5ZU44NVU4Z2tpL0hWNjVadFVmSnk4aUdyanNqWk02RWU1?=
 =?utf-8?B?WE9KYk5PcmtWTG9BTEhvc2FIbW1Xb0g4OWd3RktzSkxsOUw2WU16NFkxelhh?=
 =?utf-8?B?dnVuZjk2Y1FNZHQxUjJjSnNIS3VheDVGVXNLU2JQOVYrbFlRMlVJSDd0TFNr?=
 =?utf-8?B?QmJ3SVpwMU56OFdHL2htUHFWT3RNazRLN2RXYzUzWTZGZEJpdmZxbmIzWXFh?=
 =?utf-8?B?dEt0ZHN1cng4eW1hWTBVYXQwWEgycmIxTGxpeGtlT1hBYXhzMTVxRFB5QmYr?=
 =?utf-8?B?ZUJmSGNjV0ZITXB2cDVsZGh5bnF3MUc4Ry9Tdm5vOGhqNFZReUZWenFqWExU?=
 =?utf-8?B?aUFZSU5HUlJORklsbWdGdFBwNWlqaHlzQm40cDRRRFpRK2hpa1ZxL0l2NXpo?=
 =?utf-8?B?VGM5VGptMkJVak9vNWVUUEV6aWgvWVlxaUo2djFLSkpORTFMeUN4Vk8xelB2?=
 =?utf-8?B?U2ZoT25mWkxTVGI5amduNmtnbkcyakpMVmNDWTlDdHBhRlBBTVF6SjNxWFR2?=
 =?utf-8?B?SEpZN3FaWEdOV3JJTHJIL0FwNWI4M29VMkRDcURtTTFEMm1OaEJDc0x5Vi90?=
 =?utf-8?B?dW1tZVg4Sk5MQmx2eWpaSE5jMnR4Wlc0ajdsZGM1L0NjdzBpczdha2pCdW9L?=
 =?utf-8?B?cVRHVGFjUnlRZkE0NU5iN1RDT0RodFQ0TGVrOHBNVDZkVjNJOWZqMlBXQzYz?=
 =?utf-8?B?N2h6aERER2xvYjVUL2N2dyt6Q3VScWN6UzNzS3YrUUhJNWtJTWZRU3NDREhu?=
 =?utf-8?B?elREanRQQndiWjlFaXNGVHlIc1JJWjYvN04xVGNXQkZyTWg3R21leEJwcFU0?=
 =?utf-8?B?NTNZZ3EwbVFLRmlHd0hPdGRzQVVpbk5DcERjRDhDR2J2S242YnBQbXF5dU9w?=
 =?utf-8?B?Mzh6ZGJVVURpZjVhNEpHbFVXTHptU09oVk5lZDZkekU4VjArdm1sbnJrbnJq?=
 =?utf-8?B?dXNxcld6SlcwVTY0L2hCRURFQjk1N2hGb1ppald1RGJqVjVRM2tBSWdmWG1m?=
 =?utf-8?B?TXBqTTBLVTdQb1IraHAwanF3ajBhVE1HNmJjUnhvSVQ0RlNJb3p1UTNFbnZG?=
 =?utf-8?B?bllkM0VoWkw5eEJwdnAvc1NIL2FBZ1M3Sjd3YWhNUWxVQ1B3ZGppNElvbGgr?=
 =?utf-8?B?VDJxa282WE9Qd0gxaFV4WXV0VEpuQUZVSlVqNFZ3SURvN0I0M0QyZWxFa21J?=
 =?utf-8?B?Nzd3RVZwbmVqTTMwM2RVSFRHekpoTHV2T3JVZk1tZCtVbm9vaXFVdDR5Kzdo?=
 =?utf-8?B?MEh1RUxYNWNtWi9FMDlCb0FNUVZ5dVNPOHArbmpIekxDZFBPUFM5NFo3QzNa?=
 =?utf-8?B?Wmc3WnhIaFdPNzNscjJNWkNxZndyVFNKcXdLL0VtbDVJa2N5QTJ0K1hoWGF0?=
 =?utf-8?Q?TYCJK9Bo2jE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHlIT2cxK3lYODNnY3dJN2ZDL1dZYzhLL0M1K0dSck5oa0l6Tm9icFZ1VXVY?=
 =?utf-8?B?eXYyVkoyQkZDRFluSUxJN3FnWVlqT2pZdHpOZnkvNkdpMlByMHVjUVIzZkRj?=
 =?utf-8?B?UkZNU3hFQVdxeW96clNlOXJvSEZJUU9teXk5NGZRSTI3eUJ1MVZ0Y0p3d2xn?=
 =?utf-8?B?Z3lTMm1JclQwLzA2WmdvcDAza1ZqSlMxaDZhR2pnVnlyUEJOeU55Qlp4dUlW?=
 =?utf-8?B?dTRYUloyYWd5NVE4b1JtazEwdzJtMzRvZHpUVXE5ZHljdDZtNFdOSG5NTXBQ?=
 =?utf-8?B?dmpNbzBGUE5xMEZ4VjNlc1dJK1ZKcURlMWlnTkJha3V5c2JOdGN5VHV5TDUx?=
 =?utf-8?B?YUlEejFrYWVROVNzVFlyb0dmZGVqbGQ3ZVM1bWZ4NkkvZ2tVcHNIYURqNDl4?=
 =?utf-8?B?SEJtUmhtNWc5RmRkRTA4ZmRLZ2dsVm1hRkxzUnJBK29QdkVzWU5JUjBERDhj?=
 =?utf-8?B?SHh4UmUvVGM4WkpkWnZHVDRrQ1c3ZVhwdmtic0twVWtDTG1RemFvWlZNQnYv?=
 =?utf-8?B?aTRFR0JZMmUwMG9iNTByTXgrMHVIWnluMGRpRlRkQzBySVFnMGtUOHVmaVZW?=
 =?utf-8?B?UCs2U29PUWFVTldRc0o1ZklJUjRiQ3ZsQVk0OFh3VlNnSWNoKytvdXdCZE16?=
 =?utf-8?B?L3dVNXBOWEVUci8yWTB1bkdoUWc4WEdZWkFUTFNUQlQ3ZDBucHkybE9WWFg1?=
 =?utf-8?B?QUdMNmZqWFJ5andUNDNPdklxU3gxZFIrUE95VTFuTnR5bnNyT1gwWi92dVZS?=
 =?utf-8?B?ZzkyUkNiMHFTdEhlQWJ3SERMZ3U5U2pSRUk3TERYbFpMYTlBZVp5YVBMNUtY?=
 =?utf-8?B?SGFseUJvcy91RVQ2NldsYW9GRjduS0dsbC8va2k0N3B0RTlyOW9nN2FiM3BO?=
 =?utf-8?B?dlRNeThuZUlEV0xxWmdrQ285M3ZUNjU0enNxTnF0Wlg1UkJhTUE1WnR0TU1F?=
 =?utf-8?B?d3pLd2JCMEZmSkFXYjRzZm90djRpMko4dVpDcmM3QTdtS2JJMm10anJWM1R1?=
 =?utf-8?B?ZVVDQzVFRWE2c2tURzZkNG5nb2hHa3lRZko2YW52eGpHdU40TnNoTHloUXVs?=
 =?utf-8?B?TjVqYlVuQkhSY2QvaUxjdzg1V0tsRmNtVzN5Mis5dmE1ZFhXWUw0OGpSRncy?=
 =?utf-8?B?OTY4OGhXUi8yZnh1MUxQTjQwWUp4QS8zaTN3K0tXSy92VG1saXU5c01keDIv?=
 =?utf-8?B?Zk1pRnlLV0hNVnZ2SzR0TFptSWQrd0YvYUpURnp4RmdUQXA2TEpmc1lkcDBu?=
 =?utf-8?B?N2RMQW9BUDFYSW1YOFA1VWI1SjErMmgvaDhBNE8zcnhmaml5WExVYzVvUU14?=
 =?utf-8?B?b3pTL0c4bm82YnYrS1VYb2hQT0pQT0I0VTJxSmZUYjVuekl2UDRlR3dxVjFB?=
 =?utf-8?B?MXFDUEFPTzNSbEVCbHhzc0tIYlFkS1J1ekl4S1NGM2tMb1NmRHVHMkhONHRt?=
 =?utf-8?B?dlpBU2k2QStiaVhJZi9oODRmZFFYOGgrVHpWRmxvWkRtb0kyODhpeFE1NGpy?=
 =?utf-8?B?Zmp5SDRZUVpSWVBRd1VRc0Vkcit6cElVUXQvdGFaMjcwVFBsNmkreTU2NDcw?=
 =?utf-8?B?RXhUckNUNXJPK3hMQk9na1lGblh0MERBK21LRk93UFh5TkE5T3JUL2RTYXVQ?=
 =?utf-8?B?bTJPN2tIMlk1bXhWdDhob1Y0RWZTNWlSaWNmWW9TRndIeVEzcmZiZUwrTmNG?=
 =?utf-8?B?OXBoZ1FQREhLNk5lNFd3Qkt4VXhFcFZmNDJoK3FZWk5FTlhsUy9iYnBLWkFJ?=
 =?utf-8?B?MVcxWlhkMkRuT2IvUUhKNk1mS2prMm9KZFBtWnNmSnA1c0VvSHU4YkdYVUFx?=
 =?utf-8?B?T0hIK1VxVXJEZENoMjVTVSsvdjY5RHkwUmlqdXdKMEV6QW9jWW14UUplb0Zo?=
 =?utf-8?B?My9aR2tya05ZTDd5dUxRakV5S1JicCtLbWF4RGxDVXEvTGlvTzJBYlV5amJp?=
 =?utf-8?B?MkcvYmc0UWFIbU82bUVOUVpKazAzdE82bitKOXVhS2VoSTdYWnJxTUVpMTN5?=
 =?utf-8?B?Z1lKKys4M285bGNCNXlCQmFqZVlrajdXcm9VTWJqVHY4bWluZmhOM0pQa1or?=
 =?utf-8?B?WnZQS0k5U1lFckN6Uk9MK2NzekNEcXlxTC9aeDVvV2wwYjg5dkZ4WUZ3Rkpy?=
 =?utf-8?B?ZmxVRjd6VUp6NlZBUHNiUlpnZklSM1YxY1ZaR1NybGpMUnR5UmZNRlZLWEJs?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CF4G2E1j21xIdkK5L1OIG2pIr86bLdfMmffTSCRUY4LAi7WOsDi7MAhWC4nP7T9yFHLPUNeglfEcjcOnVyrHvWcxplUmS05unvGB01DBr2tEDqk9nHiaObZaH991cpODUuPiMzKhhEMxGxGUTsaoQQIlWvL38riT0z1en8QobRvkYdhfm+qOsz6FDva6eeHCNh2220n8mDBVXZMYuiTiJBdYzh4G01DLZK94Qf6HnSeP8AfIWb0rGF5kjG1CHGCIayv/Voa16TiLUwHbeuxD9Czyzg+fXRAM+1TLoAN6M4Oa2XjXNWTNHH12AlRiYVd4PcDU5WkEsqRyWW0Yy0/9QvvLnYIA8CIoueQ6SFx+ZuY+t5G7/Gnjhhwc+mkw9JxncaFaayR9T/Pcr00ZhcSDOArwS7okZpvh+ZXN6zYMeGsbvVa8tkK3YXt0NZr4fySYtGR8UHyu19LaX+LTDfGQeNZGTC7QkBLpLGwfS5nffrQnIHGt1RCikku3uzNQtyHAA1r1s0Eb1A046gUy6WH3wTlOCR/u2nabuTsJwPBekaz2619mFwQmd/r2p4Q5LRaf1Mr0Owvv1sOMF+3GBcKf88tsAXMjSeiLEJErYWqXlHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b392a98-5d17-414a-0676-08ddbd6403a9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:39:01.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2mHMW/svg+D4/WO79GRx3QrYfHhIi8/N+GEbVzxApiuzihrwBCQa1NC/iMP/Y23q3jN6ojdIjvQHRCiiLbo7ifF86L4/X1TYjBwgf0kjL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4NSBTYWx0ZWRfXxYy/MUb6bfnk
 2AckNmGc0NrmhoqS/g+KkyqqS5fZzu6tXVO4ORja//+skZGCxf5vyiyBFN5zr/Z6RBkSDFIsTQ3
 t/YIypY85sQhzO31MpAEg0pbUxW9k7ErOw/AUZ7X7Q2uaMsc/W/+wJokscuCasmXG8wf8Lyx6IX
 sJ2N5FdM8vJlr9kg+xAg11FGilwglMI52z8yWCbxqANpg0LuB+/QVA+XXSC6edLvL+PlDotv8CB
 GIZPndnaRNToMSAS8vZBBonAARlVPB/Ly8KvFHthio8CbVBWbQTulRzJituSNrc+0MHfP56TJCD
 ESTPSl+e0NtyAuruDTuXfeOo5dRq6mqrvDez1WwZeI2xkp21opozER+WguJQX+jBiL096ST5tgs
 MPm136eNNF8gKyWcAiCY+FI4nyCu1RX86VBMWSoo0g2nFuxVMPqWVoTXHlIq1k4OqysDp54r
X-Authority-Analysis: v=2.4 cv=Fs4F/3rq c=1 sm=1 tr=0 ts=686bdc0a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hreyuMDo69xhdS-INUgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1hluE8I0s0GwVd8VkrDB-mhVF0fkTTPj
X-Proofpoint-ORIG-GUID: 1hluE8I0s0GwVd8VkrDB-mhVF0fkTTPj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/4/2025 8:26 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Using qom-list and qom-get to get all the nodes and property values in a
>> QOM tree can take multiple seconds because it requires 1000's of individual
>> QOM requests.  Some managers fetch the entire tree or a large subset
>> of it when starting a new VM, and this cost is a substantial fraction of
>> start up time.
>>
>> To reduce this cost, consider QAPI calls that fetch more information in
>> each call:
>>    * qom-list-get: given a path, return a list of properties and values.
>>    * qom-list-getv: given a list of paths, return a list of properties and
>>      values for each path.
>>    * qom-tree-get: given a path, return all descendant nodes rooted at that
>>      path, with properties and values for each.
>>
>> In all cases, a returned property is represented by ObjectPropertyValue,
>> with fields name, type, and value.  If an error occurs when reading a value
>> the value field is omitted.  Thus an error for one property will not cause a
>> bulk fetch operation to fail.
>>
>> To evaluate each method, I modified scripts/qmp/qom-tree to use the method,
>> verified all methods produce the same output, and timed each using:
>>
>>    qemu-system-x86_64 -display none \
>>      -chardev socket,id=monitor0,path=/tmp/vm1.sock,server=on,wait=off \
>>      -mon monitor0,mode=control &
>>
>>    time qom-tree -s /tmp/vm1.sock > /dev/null
>>
>> I only measured once per method, but the variation is low after a warm up run.
>> The 'real - user - sys' column is a proxy for QEMU CPU time.
>>
>> method               real(s)   user(s)   sys(s)  (real - user - sys)(s)
>> qom-list / qom-get   2.048     0.932     0.057   1.059
>> qom-list-get         0.402     0.230     0.029   0.143
>> qom-list-getv        0.200     0.132     0.015   0.053
>> qom-tree-get         0.143     0.123     0.012   0.008
>>
>> qom-tree-get is the clear winner, reducing elapsed time by a factor of 14X,
>> and reducing QEMU CPU time by 132X.
>>
>> qom-list-getv is slower when fetching the entire tree, but can beat
>> qom-tree-get when only a subset of the tree needs to be fetched (not shown).
>> qom-list-get is shown for comparison only, and is not included in this series.
> 
> How badly do you need the additional performance qom-tree-get can give
> you in certain cases?
> 
> I'm asking because I find qom-list-getv *much* simpler.

I would be content with qom-list-getv, so I will drop qom-tree-get.
qom-list-getv needs ObjectPropertyValue and qom_list_add_property_value
from the qom-tree-get patch, so I will respond to those comments.

- Steve


