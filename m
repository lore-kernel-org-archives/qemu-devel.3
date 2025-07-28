Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE26C87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNuN-0007Nv-Eq; Mon, 28 Jul 2025 09:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugN0W-0003tu-1A
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:31:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugN0O-0002pr-Kk
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:31:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SC8FBc015511;
 Mon, 28 Jul 2025 12:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=zMnVrvm2HnElN2EOcjjN20ot7Kutd8lGItRBm9bCjis=; b=
 eSsyDLwUeptbKH61bZrzm9rGNnzqIGdb2wToburyZGNHd5Fw+Pu2potHWyFePfgf
 P7HKiSoRGMPQ3KNpDazAHJI6GHgHno4bPUCfgj/MuDQY+ePC3ly1BaejUJT2quw5
 w2aMXMnuporznYMAPiiyExdGsZRZCQlrbJom3Uuv/vjEPhM1yb4wzZfX/gZBZS1B
 nmZpYZml+cDVmI4Sq5LHA4PnaumtjDmMJ5iAdtJpgX5dmB3HFLS3DLXlnWLQbgaS
 sYvzIBSC2DZZW2X5lBI7Sdflc2G/HF0qM5cNyN44DktPxpuRRytljj49NniHZdVp
 elcP+NrbEQoMUE+CTashRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e361r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 12:30:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56SCHxG8010498; Mon, 28 Jul 2025 12:30:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 484nf880b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 12:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua+W88K/Qdg8A0ExYHzX3iThVpyHRw1p+eGLTR1H7V6xeRYFNFhSQ2ERIu7YWDCEk3oq5sllGAecIb2gJpVGfOhS/SngV0Xvc/3t6HrxKkREjPhyCh8W00CeLXwbw3uqdzePE72qbN8PaKmPzmoDyIQidejgq7DBHd6FWRSCQeHEAX9DQnziHnxiUNX32rnji7trf2DDtD1aQYTRRXMRpm9JH0fg7j5N4lhUpgOila6/UifU8mSIwOnS8gY/uHxX0qOAEe1zmkUcy8bohLOAHmUkDe8G6RxVpgbqQpivSOULmc5QoFlt3RJeMKUpeX+q2MHbEhvSjhfwX/scwoGDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMnVrvm2HnElN2EOcjjN20ot7Kutd8lGItRBm9bCjis=;
 b=EIqIRRJxGL6mQknEQnr6ij1+BxGuD5WsXRmcgZfBjDgg/IFRme7TUsWKZoH1btSqCOcI2kJe522OlIx/evxT1T2cpzDFqEeJLRaRb8VJgZBdzs5rlUwbhDeauKeaT/6Umb/Onnj7F2hNOi4jKuPOTdtroBBHi0N19gIE4ZhiIuLT1KPmBkpVjBM5EiVBlKhDYaox3xkHf1nGyOvUPAqObRBcSfaOCZwIRaRbppKmsaZQ4ONWHv297rtAn0ZyBw6tPKhr1VcgVTqion+09cwZwKyuwxBIDfj8YxpIs46e+19J4pp5B8H141ae3zzeVZsjg3t1CTho4G9w0FFqggM+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMnVrvm2HnElN2EOcjjN20ot7Kutd8lGItRBm9bCjis=;
 b=MSVxh1EKV+JR+6VHk/fgOfyhtruL1nE/JYUfUxXbnYtobNqluHz1C0nWdJGxS0dhVoPpQlxTGTa7r9+qwPqnV99eEUvziYUyCA9F0bbSm+MnjcnmNzvgHRjz7+6ozFcyEBkTE05D3FJD9oWu9070ghR7nn2GRtNoYL+N5eeOXiI=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SJ0PR10MB5567.namprd10.prod.outlook.com (2603:10b6:a03:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:30:43 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 12:30:43 +0000
Message-ID: <7bbd8c23-6b20-4a13-b3b2-4398283f37a8@oracle.com>
Date: Mon, 28 Jul 2025 08:30:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/6] virtio-net: iter live migration - migrate vmstate
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-5-jonah.palmer@oracle.com>
 <20250723024406-mutt-send-email-mst@kernel.org>
 <e6ab2cdc-5f5f-454b-9795-e8016ce16248@oracle.com>
 <20250725052825-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20250725052825-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::15) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SJ0PR10MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ac0e90-8eed-4bb7-d56a-08ddcdd291c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3NmK05XdmFWUmVscUVBYzVKbFhpVnFnbXNOcmxGUlFLYTB5ZWQ0d1lBRkZZ?=
 =?utf-8?B?bEpoTTQyYlNjR3lCWS9KWG9hU2UzTUpOcmVvZEk1bWNUS0ZwRTVUREVaSTI4?=
 =?utf-8?B?cGJIYzU3TWFJM3VhQjFteTkyYzVjWE0wRE1lOWVkeFEzYldRZEV3QzYydkV6?=
 =?utf-8?B?WHhPVnF1bUtFZ3Q1VlNtN2x6NkVVRmxBZ0JYVnJuQ04waEpVNTFZWlBLMVlU?=
 =?utf-8?B?RFRMQnFZU0VmUWVOQUZVYzZxcTNSL0lrbVdtbmR0OGlyWnVBdmZxYytOQ2x0?=
 =?utf-8?B?QXR1NTZkeHNRWXAvV0xwM2lvazZSOUI3VE9OeWNVcUREeUc5NVNBT0pkM3lh?=
 =?utf-8?B?RVRhbmUwcitFRVNCdFQrNkZtRjJCSGlJZGM5Vkl5WGZYeWY0N2ZEbTBhTVYx?=
 =?utf-8?B?S2hJbExrL0RzeHJncXd6NGtQdlZpZFJETVE5YWd1ODVEWVRSTlVOWTNCQ2Np?=
 =?utf-8?B?aEpYam5icll2YWhxK3N5QW9mQ2Z6REFjYnNJSzFqSHZjZlFwSmJYa3JkNm4r?=
 =?utf-8?B?OG84S2hTZkRrR3JIOXJOVTZBQkdtbnp0NGJIdmVodzd4Sk90bU5lbituaDVE?=
 =?utf-8?B?MThpRGZnc3MrcTNKdVlPUXBiTXBxMFAveTY3YWRGQmI2ODVDRndIRGthZnY1?=
 =?utf-8?B?VkxuazFPWGJHcnVUQnpkd1NvcEhLUnZjK1A0ZDRQV0ZsWHZNOGtRUnIxS0Jj?=
 =?utf-8?B?SWF3c3ozOUlHTVY5ZDBRT0ZkTEgzUFBjSXB5VDlFZmt5OTdFdVVFTXVpcWRr?=
 =?utf-8?B?aVJuNjdVNjZIakIyS0JxakJiVkVQNy85SytlbVNVUkxjVWVMUE55NVlKNWE3?=
 =?utf-8?B?S1NwZGM3SllGcmN0aGZGVGVQU2RqK2xFWjU5c3NwN3pnR3RlUks4V21XOTNW?=
 =?utf-8?B?dmtuamVYaUh0Vy92NEVqOFNBZGdGaDIzRzRLOTRoUG15aFZZSEdYR0hWek1H?=
 =?utf-8?B?Sll4S3VXYWhRNlV1UGQ2RUJyT05zVXI1Z21NckpkMGx2SjZ6b1RMVVR6Nldn?=
 =?utf-8?B?aXVTNWgvY21GTWlwTVpGZ2l6WDdpNTRqQThSeUxpd1RlekFlY256ZlU0WE9C?=
 =?utf-8?B?VGg1aGYxa2ZVQ2ExL1kyVUpxTjd6d0w4OXJyZ2hUVFhUYWFuKzhwSlRQbjNC?=
 =?utf-8?B?Z1FQc2tzaE5rMnZBbVFVTEgzUkY1UnBOd1ZKaFVrV1dBMzJlWXhDQS9aS1pM?=
 =?utf-8?B?Qkp1anNkdWY0TUNSSHRINWl0a0VzQXNVOWtMdS9BTmxyVnAvSFB1NmQ5YkZE?=
 =?utf-8?B?andQc0RhcTh4TmJTUlhuQTlxZW1BVVZtbURxQmVjdFNQQnRNUEx1R295c2pJ?=
 =?utf-8?B?QjNOQlBaSi9Ja1c1VzRMeHlZbFdqMVNGNEFsVkpWRmk0cStob2U1SUJ6L0FR?=
 =?utf-8?B?R1BtUmUraXloSFdHOTljd1IyTHpCV1dnWEQrZENidFdVV2lDRnhLNGJNck9J?=
 =?utf-8?B?bzlLbFpXaUx5eGJRWVpEYXdjUDlLR2t3S1B6VXhwcjh2bHpnMUswdS9PMzlP?=
 =?utf-8?B?RXp4VDF4bTZIVVQwWGRPMVhReFUrS2RVZE5vZEdaWFhHMUQva2MwR0ZteTVC?=
 =?utf-8?B?YUdOeUdTRWl6anhkSUkySHBrVjZzc0M2Z0lrSGtxQ2RBeFVPN3F3b2dyTjVP?=
 =?utf-8?B?TjlVOFpRZUFpZ0lER2xoTCs3WkZCcWdZQVBEZmNNMVVsRmRYcEFldytjK3l0?=
 =?utf-8?B?NS9ycC9DRXYwS2xIZy90UDNJeGtOc3EwSkR0ajdkWEE1cW43VlJqY0FpbStn?=
 =?utf-8?B?RGpHREJ3WUt6aVZWODJLMisxODJPOTQrMk81aDV2TXJYdDRxcVJFL1hZQ1o5?=
 =?utf-8?B?cTdiT0lUUnJwTFk5ZlNOak5uMzZYb0Z6MTlCWEYvaTJRTURqbGRhaTZLbWho?=
 =?utf-8?B?UktyTlRwMmozSTlNTW50MFVHRFhWMmdCdmRERjRxbzNFaXdRai9RdnMxTXB6?=
 =?utf-8?Q?dfXj7HkR0N4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2F5Rk02KzRmT21VZFAxRjB4NmZxKzRBTHVWQ3lLS0pLSHNqQU42b2NTUzdL?=
 =?utf-8?B?ZzFhak4wMStldCtFQ01kM0ZSeEdiTUdKNEgrYjhUMmlScnN2NTFiUFZXeU5V?=
 =?utf-8?B?V1pJU2l3aEtOZnhrRFBhUTZTSjJsdXlnMjlyWW1MYWh2R1lRaTFFK016bzY4?=
 =?utf-8?B?UGdHSFhoM0tsTnBub3V0YWlYNmVzUUZQcEZ1K3RZQjd3clJZTXdhVS9aM1ZT?=
 =?utf-8?B?MXkxZXg0cW5wbEtnaUdQQ0FHQ0kzWEM1TDFYSWIyb0pDMDFkdmNCYmxwZ2dI?=
 =?utf-8?B?d1Q3RTdoZmowZll2SHlIT3VSUWJqTVptV04wenVHcDQ0M3h2OCtkcGZsS0tZ?=
 =?utf-8?B?dTdUeU56V3UreHlGeUVWZktqR1RMNlFuWWwzMXhSYVcrWC8wTkRKQWd4ZzF4?=
 =?utf-8?B?cjlEQ29aMFBoS3RwbWJKT25aOC9HOHF4SlBFR0czbmt1cnVzUy9YTnQrMks1?=
 =?utf-8?B?TWU5MTB0dkFOR0puTFRYaGRUNU1Qd3JqNmlRbVV0ZXdtRGtXRHNaam5OeUlv?=
 =?utf-8?B?eDk0aWVtVCt1SjVLN2U5bjZkd1M1MU00RnhsYWxjc04yUkdTcytIeTV4VnRi?=
 =?utf-8?B?eExNem9EbUlOK1FkdEx5SjJqUkMxMkNvYkxVQnAxVFN4b09rQW13RzNqa0l5?=
 =?utf-8?B?cEtZYkxSY3dicUFNSjgydHVEWmxQOUpibVNIV1lXMDNDdlNrYlJLbVM0R24y?=
 =?utf-8?B?WDRHalN2WEsyOTMyT291UENqRVpqb3J2T29zdnBjRm9HOXpES1FRenZGM2JD?=
 =?utf-8?B?R1NXMktSY2NyN2cxc3pWODJzNWhxSytxamlrai9qQm02MXBJRU9JT0VVcjl0?=
 =?utf-8?B?eFhDZmNDTzA2ODMrQTFld2pMMThPN1h3OHpGVEV1RVlVMCtlc1pFZXdtT21U?=
 =?utf-8?B?QmFINFJhQ1NUaHliUHNpVlRQYWZEWWw1WEJQWS9KWk9kLzJMbHNyZmhwbTdh?=
 =?utf-8?B?c01RUmtzam5WNzFLQyttdzlkNW5RWExFalVJWSt4Szd6SWF5aUkrbE9ZaTd0?=
 =?utf-8?B?dXQybHBBYWxubmZSVUlQYzA4RFVVN2twMGZKY1dZNGhUV2VrY0twVjhvV3dr?=
 =?utf-8?B?L004YnlIYzFnU2NtS3VpcW8vdjQyaDZQaytlcHBIM0lnMW8vOG9Fc3BiY0I4?=
 =?utf-8?B?VEZpSG15NWc5N2xhNDhBdFZjR2MzVlQ5bVFZU2VMdVZJaFI4Z1FEMFZlcjlM?=
 =?utf-8?B?OUE2UHNxdDAzTyt1eExFTlZpUkk0RWxwNGVJQldIbWg2QThESEtway9aTmhP?=
 =?utf-8?B?LzRrZVF5MzNOVVEvYkxjSDlUdHh6YU1kTkErNXBlWkJhS0ovZ2tLd3RFVGJI?=
 =?utf-8?B?dGg5RnplQyttUUlTODJMUms1QThudUhXQmZEY29FZWtwNjIrVHpzbk1xUmQr?=
 =?utf-8?B?YzdjeFlTOWtLelFTdVdlLzlDaVVTMFVvVzIrcjlVTy9hQ1RWSFNITU1BQVI0?=
 =?utf-8?B?K2tnczNLZHI4Nk91NGpNalZVaDFaNVNFNUZhVzlGUVo5b0dJQ0hQRVc5aGVl?=
 =?utf-8?B?OXFLRkQ1U2gxdWhUZ2ZzVTQ0alFsUTFyS3AvYW1kVktEL0s1UFlxNGlIOXMx?=
 =?utf-8?B?V2xNNFZUa3JzRmJXMVhKREVCbmxEOUp6RWFmMlBUOEVMaFlsbkhxd0lIV0Rr?=
 =?utf-8?B?WHJyMHMveGNMbTVKczZsMnBLeXd5cTU1bEFnd3pVQzVMUWsxSnR1d3d2MThp?=
 =?utf-8?B?NTNabVZYaG9majZESFk2MmhGZDFWdCtmbXBGUXpOU3RkYWNRNno5VE5sRTVT?=
 =?utf-8?B?eFVEbUhzdkh0dURRS2tBMGFaUjZveXhCbHJoK2tnWlVDcXZibGVWR2MwVERq?=
 =?utf-8?B?TkNxU3ltMElKc1lkdHNHaEZCZWJrbzNwelQvV3RmaHlVVnJnaHRJSC9uR25W?=
 =?utf-8?B?M3pXYkZhZmVCWDEwM2R1OUkwOTc4aG9UKzkwSkZERHgxemFpQWFXZmpxdUNw?=
 =?utf-8?B?SGV3b1VJNDZ3T2xac3ZXcGl1Q1k0WDZGRVljc0ZoMFVPbUdIalArVGo2djVl?=
 =?utf-8?B?WVE0QTlrSngzb1Q3YUs3b0xWNFFNMjlDVUs0SGtrYmVIVE9pTTF0MjB4U1V2?=
 =?utf-8?B?Y2NrRW5UL0NzTjd1OE5IT1hJU2l4dVQ3cEZ4NUx6b2tMZVpNVkUveENZY1Qx?=
 =?utf-8?Q?uCmnCBIMPz9wQYMicc5N/EKxO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hhBQ+146y5xCVyWS3BdUKPUXQLUeyk7hfPoSxJQ7VJ/NALmrW/oSg4GXV9F9KVPhKlZKAJ5FXtdg8YXtgs7OTAd4nNPs0khRCQVi4bQnJgbdNN2zpP6sdLLzl903f4NcLF8CF2ZJ8qlYeZH1fPkdGEklaSFThNHi0TlgLeYIzDsHwPr9aXmlSt3xO/zvNLGvxZ/X0WWIVKt7/b3UyMpbcusM1cih83Mrq81INru0I0R8Ox5ndkvounQUFpXHmJ022ED1cw0FKLqs6yZQL7CpqioN/gcPRfcQck6wGjRi8DZ+HoycP/4CbpamyEit4FCs68fFRFuNlNVAYSUSgOw1NB/EUoItJaWJpzzgNKdxo03vo43UzX7yVqfUyOCmAnRqDpxm4bXz04CpX6Ry/+/Fedje1rcBvHwQUTL2jpSyC6KzuYW7V953hdZB1LMgrnZFOH9R7CSDBBICCUZmo6iipQ4+fJssw4nMv2mbEF6D5SLGQks7OW5sspFN3bHSBWjocneHf6eTIaR1i/uTBfdm/SX44fteiKH0G30l+Zof5DlveT6wuMixddH5YICw/rdijS4wzFlLWip+GBBNckK+2GT3hjKEFyFcwkjj2exSHk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ac0e90-8eed-4bb7-d56a-08ddcdd291c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:30:43.0889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHDENjecYBfRmlg+5NcMLclSvcxUXsF3/SMrgrdxoepTD3pYBKuK7TXLZR9yhWfJRFVjkvKCCOQ3eHoYoT7IIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280092
X-Proofpoint-ORIG-GUID: FM0s-c5C-7BNW9sQjAGHt4uEyXTNPCy2
X-Proofpoint-GUID: FM0s-c5C-7BNW9sQjAGHt4uEyXTNPCy2
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=68876d7d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PWHo14iyb7zYE1-F_U4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MSBTYWx0ZWRfX7rYhlz0/wqP9
 7KBLd2f2tcBVE6CyBHLFXHhSJV3iFir6tHhzROv9DRIRYdj1Sugt9Ri8SfnxBL/3eOHzv4TC/uK
 oZcLe4CotgZBXKBZGWnMfn+rqJR7G1p1vKCS/OZdBo7ZldG/waJHKuUhOPJdVYRsG82hH+zxUa2
 jzwuNRrpXR/hL8YgkhOWTSe8TWFxsLaLWfc5e3DYc31VPoz35FcA6+L9GbOYf3d2SPoH+0OOzE2
 rfeDuUcZdWoIzBDTCNeGm55LRjp7RKrkqLsZdAKBDm0VkxdsCQQ+Ja/rs++Qj3WroI3ySgLvaib
 vtMw4J5BOAjPNKhasYmwWjcHg/eREA3QCSK3ni3t8XsA42mS3DheFR0FXVrWLSdXlAE1J6yi+/V
 +BEZeWAY9nFFusFEY0gZjx0I33Bex5QOLn/08PreXpzhzbLQCQ25LWAaUUUIgAxtZU8CT3Ge
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



On 7/25/25 5:31 AM, Michael S. Tsirkin wrote:
> On Thu, Jul 24, 2025 at 10:45:34AM -0400, Jonah Palmer wrote:
>>
>>
>> On 7/23/25 2:51 AM, Michael S. Tsirkin wrote:
>>> On Tue, Jul 22, 2025 at 12:41:25PM +0000, Jonah Palmer wrote:
>>>> Lays out the initial groundwork for iteratively migrating the state of a
>>>> virtio-net device, starting with its vmstate (via vmstate_save_state &
>>>> vmstate_load_state).
>>>>
>>>> The original non-iterative vmstate framework still runs during the
>>>> stop-and-copy phase when the guest is paused, which is still necessary
>>>> to migrate over the final state of the virtqueues once the sourced has
>>>> been paused.
>>>>
>>>> Although the vmstate framework is used twice (once during the iterative
>>>> portion and once during the stop-and-copy phase), it appears that
>>>> there's some modest improvement in guest-visible downtime when using a
>>>> virtio-net device.
>>>>
>>>> When tracing the vmstate_downtime_save and vmstate_downtime_load
>>>> tracepoints, for a virtio-net device using iterative live migration, the
>>>> non-iterative downtime portion improved modestly, going from ~3.2ms to
>>>> ~1.4ms:
>>>>
>>>> Before:
>>>> -------
>>>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>>>     instance_id=0 downtime=3594
>>>>
>>>> After:
>>>> ------
>>>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>>>     instance_id=0 downtime=1607
>>>>
>>>> This improvement is likely due to the initial vmstate_load_state call
>>>> (while the guest is still running) "warming up" all related pages and
>>>> structures on the destination. In other words, by the time the final
>>>> stop-and-copy phase starts, the heavy allocations and page-fault
>>>> latencies are reduced, making the device re-loads slightly faster and
>>>> the guest-visible downtime window slightly smaller.
>>>
>>> did I get it right it's just the vmstate load for this single device?
>>> If the theory is right, is it not possible that while the
>>> tracepoints are now closer together, you have pushed something
>>> else out of the cache, making the effect on guest visible downtime
>>> unpredictable? how about the total vmstate load time?
>>>
>>
>> Correct, the data above is just from the virtio-net device's downtime
>> contribution (specifically during the stop-and-copy phase).
>>
>> Theoretically, yes I believe so. To try and get a feel on this, I ran some
>> slightly heavier testing for the virtio-net device: vhost-net + 4 queue
>> pairs (the one above was just a virtio-net device with 1 queue pair).
>>
>> I traced the reported downtimes of the devices that come right before and
>> after virtio-net's vmstate_load_state call with and without iterative
>> migration on the virtio-net device.
>>
>> The downtimes below are all from the vmstate_load_state calls that happen
>> while the source has been stopped:
>>
>> With iterative migration for virtio-net:
>> ----------------------------------------
>> vga:             1.50ms |  1.39ms |  1.37ms |  1.50ms |  1.63ms |
>> virtio-console: 13.78ms | 14.24ms | 13.74ms | 13.89ms | 13.60ms |
>> virtio-net:	13.91ms | 13.52ms | 13.09ms | 13.59ms | 13.37ms |
>> virtio-scsi:	18.71ms | 13.96ms | 14.05ms | 16.55ms | 14.30ms |
>>
>> vga:		Avg.  1.47ms | Var: 0.0109ms² | Std. Dev (σ): 0.104ms
>> virtio-console: Avg. 13.85ms | Var: 0.0583ms² | Std. Dev (σ): 0.241ms
>> virtio-net:	Avg. 13.49ms | Var: 0.0904ms² | Std. Dev (σ): 0.301ms
>> virtio-scsi:	Avg. 15.51ms | Var: 4.3299ms² | Std. Dev (σ): 2.081ms
>>
>> Without iterative migration for virtio-net:
>> -------------------------------------------
>> vga:		 1.47ms |  1.28ms |  1.55ms |  1.36ms |  1.22ms |
>> virtio-console: 13.39ms | 13.40ms | 14.37ms | 13.93ms | 13.36ms |
>> virtio-net:	18.52ms | 17.77ms | 17.52ms | 15.52ms | 17.32ms |
>> virtio-scsi:	13.35ms | 13.94ms | 15.17ms | 16.01ms | 14.08ms |
>>
>> vga:		Avg.  1.37ms | Var: 0.0182ms² | Std. Dev (σ): 0.135ms
>> virtio-console: Avg. 13.69ms | Var: 0.2007ms² | Std. Dev (σ): 0.448ms
>> virtio-net:	Avg. 17.33ms | Var: 1.2305ms² | Std. Dev (σ): 1.109ms
>> virtio-scsi:	Avg. 14.51ms | Var: 1.1352ms² | Std. Dev (σ): 1.065ms
>>
>> The most notable difference here is the standard deviation of virtio-scsi's
>> migration downtime, which comes after virtio-net's migration: virtio-scsi's
>> σ rises from ~1.07ms to ~2.08ms when virtio-net is iteratively migrated.
>>
>> However, since I only got 5 samples per device, the trend is indicative but
>> not definitive.
>>
>> Total vmstate load time per device ≈ downtimes reported above, unless you're
>> referring to overall downtime across all devices?
> 
> Indeed.
> 
> I also wonder, if preheating cache is a big gain, why don't we just
> do it for all devices? there is nothing special in virtio: just
> call save for all devices, send the state, call load on destination
> then call reset to discard the state.
> 

So with a relatively simple guest with vhost-net (4x queue pairs), 
virtio-scsi, and virtio-serial (virtio-console), total downtime across 
all devices came out to ~66.29ms. This was with iterative live migration 
for the virtio-net device.

The 5 largest contributors to downtime was virtio-scsi, virtio-serial, 
virtio-net, RAM, and CPU:

virtio-scsi:    13.994ms
virtio-console: 13.796ms
virtio-net:     13.495ms
RAM:             9.994ms
CPU:             4.125ms
...

-----------

Perhaps we could do it for all devices, but it would probably be much 
more efficient to not discard the state after the iterative portion and 
just send the deltas at the end. This will probably be the next goal for 
this series.

> 
> 
>> ----------
>>
>> Having said all this, this RFC is just an initial, first-step for iterative
>> migration of a virtio-net device. This second vmstate_load_state call during
>> the stop-and-copy phase isn't optimal. A future version of this series could
>> do away with this second call and only send the deltas instead of the entire
>> state again.
> 
> I see how this could be a win, in theory, if the state is big.
> 
> 
>>>> Future patches could improve upon this by skipping the second
>>>> vmstate_save/load_state calls (during the stop-and-copy phase) and
>>>> instead only send deltas right before/after the source is stopped.
>>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/net/virtio-net.c            | 37 ++++++++++++++++++++++++++++++++++
>>>>    include/hw/virtio/virtio-net.h |  8 ++++++++
>>>>    2 files changed, 45 insertions(+)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 19aa5b5936..86a6fe5b91 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -3808,16 +3808,31 @@ static bool virtio_net_is_active(void *opaque)
>>>>    static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>    {
>>>> +    VirtIONet *n = opaque;
>>>> +
>>>> +    qemu_put_be64(f, VNET_MIG_F_INIT_STATE);
>>>> +    vmstate_save_state(f, &vmstate_virtio_net, n, NULL);
>>>> +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
>>>> +
>>>>        return 0;
>>>>    }
>>>>    static int virtio_net_save_live_iterate(QEMUFile *f, void *opaque)
>>>>    {
>>>> +    bool new_data = false;
>>>> +
>>>> +    if (!new_data) {
>>>> +        qemu_put_be64(f, VNET_MIG_F_NO_DATA);
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
>>>>        return 1;
>>>>    }
>>>>    static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
>>>>    {
>>>> +    qemu_put_be64(f, VNET_MIG_F_NO_DATA);
>>>>        return 0;
>>>>    }
>>>> @@ -3833,6 +3848,28 @@ static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>    static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
>>>>    {
>>>> +    VirtIONet *n = opaque;
>>>> +    uint64_t flag;
>>>> +
>>>> +    flag = qemu_get_be64(f);
>>>> +    if (flag == VNET_MIG_F_NO_DATA) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    while (flag != VNET_MIG_F_END_DATA) {
>>>> +        switch (flag) {
>>>> +        case VNET_MIG_F_INIT_STATE:
>>>> +        {
>>>> +            vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
>>>> +            break;
>>>> +        }
>>>> +        default:
>>>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Uknown flag 0x%"PRIx64, __func__, flag);
>>>> +            return -EINVAL;
>>>> +        }
>>>> +
>>>> +        flag = qemu_get_be64(f);
>>>> +    }
>>>>        return 0;
>>>>    }
>>>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>>>> index b9ea9e824e..d6c7619053 100644
>>>> --- a/include/hw/virtio/virtio-net.h
>>>> +++ b/include/hw/virtio/virtio-net.h
>>>> @@ -163,6 +163,14 @@ typedef struct VirtIONetQueue {
>>>>        struct VirtIONet *n;
>>>>    } VirtIONetQueue;
>>>> +/*
>>>> + * Flags to be used as unique delimiters for virtio-net devices in the
>>>> + * migration stream.
>>>> + */
>>>> +#define VNET_MIG_F_INIT_STATE          (0xffffffffef200000ULL)
>>>> +#define VNET_MIG_F_END_DATA            (0xffffffffef200001ULL)
>>>> +#define VNET_MIG_F_NO_DATA             (0xffffffffef200002ULL)
>>>> +
>>>>    struct VirtIONet {
>>>>        VirtIODevice parent_obj;
>>>>        uint8_t mac[ETH_ALEN];
>>>> -- 
>>>> 2.47.1
>>>
> 


