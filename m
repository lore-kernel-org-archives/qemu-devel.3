Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD7C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7tw-00060D-A5; Mon, 03 Mar 2025 10:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1tp7tt-0005zI-OT; Mon, 03 Mar 2025 10:40:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1tp7tr-0007Mw-67; Mon, 03 Mar 2025 10:40:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tgNL031290;
 Mon, 3 Mar 2025 15:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UiFDIHegJjzOhAtbOMrBYZsF6VuY9MmtgxRTKQD6IzY=; b=
 g5uCGGCAskEp7Yu5r6UlNjJCsBblgAe0NTtQ6sHvhLDHLbEzbJ3EIPHZ+cURMvLE
 NfZmlNHXVLHjSEly70kH2QLbDgm5s3s3VcH7YRPs3jG6NqE/uPU4VMdKsjAJjgR9
 QGoe9okf9DU5FX4eu9vkiWUrW82EbY+s8xsorK/TqyevoDocNEO6Ed5l7IHMKr57
 WcP/267shOGw9c2m/S6qfvm9W+Dy0cHBIdX07HoxjPy9ZLdnRi0SPXx1cl+D8G27
 7oMnZ2j89D7AMsTJazX6Ea8HrI+ZhbztopZFlUAcyo5c1OLL5M7v/E66EiN4rQSb
 fh0wdTH0nvNb5k/TlomJYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81txee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 15:40:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 523EjgZu039130; Mon, 3 Mar 2025 15:39:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp8c9t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Mar 2025 15:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD9UAQnMB3G8kVmmuMGBOFfivHbDruqg5hvB6xLea0vrJhzYtRMnoo+YMuooeA/vFYQ+UD1fw7NwMzqgQGgr+Q6XRTz9v9oyagd1jg0TdcnF+KQ0pb9pgYBkevYoUcqrSoHz3iQlED3y6GLSC5YdfDduAP+rKDOjeD87qqB8BVd/OKFa3G7rgW3b31TvEthYAjqozNs+C2/YRZx8LC91Yu9BS9ojoLM6ThQKzRevG+WhXEs223EJRjRn5K6o/H4rW9imLhqOITndkPEHNpoUW8CiVNJWHqXGmzHWOotbeu7KRfVsmtNTVrszQdXI12KSAaAx6GQSZIFo0tOLF7EGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiFDIHegJjzOhAtbOMrBYZsF6VuY9MmtgxRTKQD6IzY=;
 b=yKS911tLKztjmaikcidbsbjcbcEU5qs7aTyI7uP42zclQR8gtCVwxoBXYRfFUkLoFuqtT9QbiqqkQo7GWiWD6J0UZ7eMbIy0yNhIXH0TsDDJS2m3b2pQyj8CapE10sf1nPHpghhLuyo38BvUxON2QTriqXCC2gt9vNud1bLH/Vd/anQV2jbGDc0cjzLTsULkCUq1GrMj1KjKVcezzPjszjkoUkihuZPgRTdsNTTlEuy4YKY3z/WJzcetepZuMVTY0MLbZ7K3Lf6ao8DkTrbrn6IepNEUxhDWTXPlY7+vB/LYiDdRtIvSKAMjVrXdhNRH6i48vA1wMn4gy31J4hFj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiFDIHegJjzOhAtbOMrBYZsF6VuY9MmtgxRTKQD6IzY=;
 b=ey2r3EXP9WnvVGQq3/HwilQQKXHrBGNwZCjNPjutUoVodihWl4SR5ZgAemTl9T4dX5G4gmtLpAgL5RXJJvDsaGZHxtIsgE5ioFMKs4zRpq30h/ZyZl1qlomDzadIQSXu+hCiekNC6wSxB5l0gIiKC+FHr1l89aYA8MgIX5Bp8I4=
Received: from DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19)
 by IA3PR10MB8089.namprd10.prod.outlook.com (2603:10b6:208:504::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 15:39:56 +0000
Received: from DS7PR10MB5008.namprd10.prod.outlook.com
 ([fe80::3190:3396:d0a1:a69]) by DS7PR10MB5008.namprd10.prod.outlook.com
 ([fe80::3190:3396:d0a1:a69%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:39:56 +0000
From: Jag Raman <jag.raman@oracle.com>
To: John Levon <john.levon@nutanix.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Herne
 <jjherne@linux.ibm.com>, Thanos Makatos <thanos.makatos@nutanix.com>, Halil
 Pasic <pasic@linux.ibm.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 00/28] vfio-user client
Thread-Topic: [PATCH v8 00/28] vfio-user client
Thread-Index: AQHbgt5sJDavtdYLtka7uQ8Ih/RY5LNdASGAgARVRYCAAEjYAA==
Date: Mon, 3 Mar 2025 15:39:56 +0000
Message-ID: <27BE312D-49C4-4832-B389-9E2106A551F2@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <C8153041-CC4A-4C3A-A11B-8F8F6401857E@oracle.com> <Z8WQJ3SlIui4aUdl@lent>
In-Reply-To: <Z8WQJ3SlIui4aUdl@lent>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB5008:EE_|IA3PR10MB8089:EE_
x-ms-office365-filtering-correlation-id: 2fffb60b-8256-4f0e-399d-08dd5a69a66f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NXplaTAzZHdFZWQvNmg1bXYraTRjd2FqdDZTeEMxTnc1RmE2Uy9pVWRrdk43?=
 =?utf-8?B?K1lUdW9IMUlzSlFaT2FBVEEvVzNNRXhBOW9CdCtmY2o2K293ZDRHNHpQTFQ4?=
 =?utf-8?B?aHhqM0VqVXh0SzVNcElZbUFTUitqanRqMldmOHhFTlB3bVMwK0hJamJFcFRN?=
 =?utf-8?B?SGZ4M3Iybks1eGVvUGpTY0lTWGNxeG9La3pKM1dFM0tSOXZqRWZ2V1pEaWhX?=
 =?utf-8?B?K1hDeWdqRmI1MUt3bFlsUkZFQ21FdWhWdlUyRTg3TEpqYXp6NXRvVnRMRC9K?=
 =?utf-8?B?MmYwcXNBUmpaUzdwTUVLem1EMFZmV3NXTDlYTUVaTjdDclc4OHMvQ0RhRkcw?=
 =?utf-8?B?clRzS1R2Q1RaTlNvczVmY2V2VkIzYXM2eGFVOVNlWWl3aFpKWDhCb3RqdzdS?=
 =?utf-8?B?clZyV3NqeFdnelFpbTZkZ0VDS1RMRTBJazFTVCsySjFQZDlyWnRRTllxcUVY?=
 =?utf-8?B?ZXVoRjdvbTRqZ296QWpmMXVxcXhVbVlvbUNVVnFPL3lzc0RKUXkvSmNiZHN1?=
 =?utf-8?B?NnJXWDU2aUZ1Rjl3OHc5WVYrZG1vb3dtamFOUHJvMjdMelNrbDJJckQvQjQx?=
 =?utf-8?B?ZGtzQXozZVpyc2lMYThiWXdZL0JjVzhlOWdUMjE5T0k1WE9QVi9lMjlFcGNt?=
 =?utf-8?B?bGdheW5KWU5SdVp6OXVYY2tqNkx6NzhHVmhrWGs2eGE1K1k3cHVMb3V2dDB0?=
 =?utf-8?B?YkxkZDcyZzhWL1lkLzJkeXRnQ3Y1WlJTN2RjeWUrS3Q3WC91c0NackFlVlcv?=
 =?utf-8?B?MDl6VlYzblVwb1gzek5LQVAvU0txaCtKa1g5K01pZ0xkdU1uY2xraVZQYVVP?=
 =?utf-8?B?a2lURHEwbVlQSGJINklubXlGUmFWTU12MFNVOHQ1ZjNKY2xlWDRlVFVVMjB3?=
 =?utf-8?B?L3RteURVSHFKRkdQZklvUjhZaXdUcU10dmQzZ3ZVN0daSFgvT3F4b25mNm5W?=
 =?utf-8?B?bERiOERqRlFCdFVaQysvRHc5WGU0NnRSSFVRa3lrUXZvNTNkZ3kvUnJ4NjlU?=
 =?utf-8?B?eFlpWUxLbW5meHBBS0MzK3MrYWM5dk9IWmU1KytPMnRSWjdWL3dES2p3V3Bl?=
 =?utf-8?B?d0JzNkxVUXA5ZGdJVkErT1QzSFhEOUVzR2hIbFRsamE0MUdObWozZ0hWaG12?=
 =?utf-8?B?VGxXUlQyRmFOUVZJNGNSaXBSSm5xM3dXQzE0QnFTL2RLSEQzL3ArNnViQ1BT?=
 =?utf-8?B?YU5SOUhsb0JnTzBaeVhWQytneXgra3UwZm5nNlUxZkpyUEpqSkg2NHM2TUda?=
 =?utf-8?B?RVI0VVdOMnZoN0Y1UW91VFowWUFUTFk3Qzd0SC9nVUpXOGgrZFRUV2NoWlZU?=
 =?utf-8?B?YzVzbSsrb1JSd0FEWW1kM3o4SXpFeHhzMGx4YTVzTEZJMDg4RS82eUkwNWtx?=
 =?utf-8?B?NGZNUHUwTnV4eG5HSGQ5aFJ6Nk9KY3BWRlRzbkkzM0hOYXdFV1MxSXREb2h1?=
 =?utf-8?B?bncwbXpwWFlBLzZBK1U3NmtOUXQ1SE1ya0haRHBoaTc3bzFEVHR0N0wwRVZO?=
 =?utf-8?B?RXZLNTRKZGJwcGxiRmV4eVYxb0Q1UGVIaUNUQzVRbi9pcWNKMU05U1NEMnJ6?=
 =?utf-8?B?WjBqUkxNM3RKdGxlMzFaSEp3OExjUThPeHUyM2xUaTlFSlNrQ2hFVE9ZcThj?=
 =?utf-8?B?cGZNekYrTVVieVlMcjkwVlpWZFMyeit5MjJvZWs4cmJLRzVPZ3BZV0pXY1ZP?=
 =?utf-8?B?clM1MDNkOGtuNWNDcTNmUllGVm1iSVpYQ3VWUWcybndweVpYTTJwd1VWVTJT?=
 =?utf-8?B?QkJVeVduZ3RCM1QzMEtqbUVPcEFhRFFKZ3IyS2pJajA5RWtkQ0RtcjFIazRL?=
 =?utf-8?B?NFQ1Rzl2bDhHOENJRzRiV0NOZk1mbHVJQnpjTFd3NGxlQTNsWGdlOHpONnhh?=
 =?utf-8?B?VjFkL2V1a3JRemlaRklYTUFJZkZIQTZHLzhJanliNTRMdVJhREtYKzVwUGRC?=
 =?utf-8?Q?Vz/mX0g4pWioopr34qTsLQ/X7KRGmRAf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5008.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KysyK1ZnRUJtbzJtNURFalJsUW05K3Q5SURLK1VaZzRHWlh4K283bzIyZ2JD?=
 =?utf-8?B?MkpXN25NWmRFL0NlUXlVT2dZVUR6bVNCYkk1bEJZYzFvcFErMkpRMTFCbExh?=
 =?utf-8?B?ZHBDME1YOFJUNVVjL0JRNHZ6TFh5b2FVUkVNc2o1NTBTNER4QUEyT1crc2Rk?=
 =?utf-8?B?UFdhQzZTWit6T2NGUXRzMFFzbnBxTHRvV2dTc1FqZkVOWG16cmZJcDlYSDRu?=
 =?utf-8?B?eW40NWp1UnJxR2Ntejdmd2FGYzVuZEp6ZnJPL0ZPWTBaN1pycDVKbnFLY2pZ?=
 =?utf-8?B?Q21WbytBc3EzUDY3REVyUGVWZFIwVGhtMDM0cVJYWUt4eFg5di9TcEFzUW94?=
 =?utf-8?B?TzdhODAzclpHOVdNNnVNNXA3VFNsblhvQzE2MGNPYk9wby9MV1NkK3pUUDJM?=
 =?utf-8?B?bTZ5L1Y0Mk5wZUVwMHFxRzMvdjZRd3kwL2xvNGZXWVVxQjZwVVMyT0s4ay8x?=
 =?utf-8?B?QkRQOG5yTTFEcE5scmtjZGJNam9sYkVDZjB6bTg4L3lURDZQTEw2UVVEUXFp?=
 =?utf-8?B?MmdoYjEzSFNUUHZhTTk2RzZkdkdjbzNCWldRaTJuZytDUWNlOGUwVVJmQ3E3?=
 =?utf-8?B?MEQwVzdrV0p3cmZyL1NYRDBSNTJJMGZGMHIrWGxZaFUvVzZHSE5acFNPRzdH?=
 =?utf-8?B?QVh4ZzFkeWVLNlNrNkZ5SDBzRTkvTk9pUkh4SjV1bnFYdHZ5anFaMWM1akxJ?=
 =?utf-8?B?TE9iMGxwSFhmalJYV21Ca1ZOWVZtSzBlRWw0MTYxUVFtcWhNTnhJQWJ3blhP?=
 =?utf-8?B?M3VmdjJkaW94UVN2Zi9MYzBrL3kyaGI2K2MvSjJpSlVxcHE3TU1xV3NYL3Y2?=
 =?utf-8?B?L1dsazM5UUcyNGp2SFY1YVpmMjMwQjhCOEh4QkNOQk96STdYWC81RlppUk5H?=
 =?utf-8?B?TVRyUlZWejYzajdFY3A4SVhpeGUwVlZQOFRRbU1nSFRCcE1MMUhqN016blgz?=
 =?utf-8?B?NkNkMHF2TmJWSWtGK3QxcVloUUk3VFl5SHZNeTc4YnhKbllJNG9ETjBkYmJa?=
 =?utf-8?B?QWM2UEl2dzZwZGRXbkdTTUt5ZkZUQ054RGhDZnhETXl2M2I0eU51WWc0OE9m?=
 =?utf-8?B?WXliNkRFWWFvNTAzRWdyRk92MlR0RDEwWXM3Wm9SODlHT3RnYlV0M1NQZkxJ?=
 =?utf-8?B?ZnNXTmJ1b3pibC9KSzFlcE91bnFBYUExdzJKMHdneXRFVC9CWXpaM211cHZw?=
 =?utf-8?B?U085VFpNSjFpVkIySXZGMDdkUkljL285TjEzZWZ6Z3l4ZHEvSnhxeDhVRmt3?=
 =?utf-8?B?azVNbG1xYXgvZ0NzdkZTTTQ0WlJ2OUUxN1AzUU5ZYk5iTXIvWThuR3JPeGpX?=
 =?utf-8?B?bFBCLzhHS25qQVRScVBnSlp0MVgyWWtOZnM1UHBncUxlelN1bXpWSGxpWVp1?=
 =?utf-8?B?bXF1QkRYNm5rK011c1pHUW95SEFxdHdxc3hlUkJzRmxMMjYwbTl5L0g1Y3RI?=
 =?utf-8?B?bUJ0UWhuNjByL0liUW9zUFc1ZXlBYUNKd2ZwcEliNkhPUnZQVVlvR3l5TmZ1?=
 =?utf-8?B?bGJNOExXbEZmZWxXRWs0WFliMm5GaHZ4ZUNFYVhrYVZYRTBHbVhhczNFUUtD?=
 =?utf-8?B?bS90YWxwbVVsUXRuc1VLUkRZT2tneXlad2pwQlcveFYyNVBjY1NqdnByOEdl?=
 =?utf-8?B?RU1vN2JVdTRIbEpwTU1jOEdYeE9zbkdUdUlaelBiYXBnamZsNDFPME1xQzkx?=
 =?utf-8?B?U2llb3RIWUdYeEIrOHk1VEkzY3E1L1ZrYzNDQnRXUk9aaHg2TUtsanlwTmZn?=
 =?utf-8?B?Zjl6WFgzVjVDaFRaNnY4TUhRemJraVdudkdvS0RXdytRbHhmOHZ4VmZOVGVa?=
 =?utf-8?B?ZVpWUzdoVDJaYW90NWZOZTRkUlRSQWJBVHdKcG1hWE5RKzZnUVh4VDVsWE9G?=
 =?utf-8?B?ak9TeG5rZ1BlZks4R3lFVWEreXdjeWNDbjhiMjAzOXpMVThSc0pWa0c5Nlhk?=
 =?utf-8?B?eGtrdnpvM01YL2Q1WWNjS1RTcHRUOGZqUitjV1IydW5GWGdpM2JZRWJpK3Fq?=
 =?utf-8?B?UENLbGhlVkVKYVBDWmcxWnhQT3dJYVVJL01IVGkrYUl2SGRlWmFjLzJqenBG?=
 =?utf-8?B?VndZTGlWem43RHREaVJWNlcwV2IrZTkyNlUzcUd4c2xKMFdEZ2p6TEhoOU9a?=
 =?utf-8?Q?tM4anESyb5AP9iVpMSRJy+cda?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE356821CEFADD4BA8DE9589FD76F25A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3pSGaWe5f0YfI5iXeLdSiRuWsoUVjLZLZcIvZjiTPzuDoxERfqeNv3hdHyOnjjMbNXxplmzcQNuJMhMaAFhC9NHZBluAeTQtRyPer6Q07TsWTjGBO9pV4/qMh11upVhtVj7djy1CpRbBUl3BiyZLSQe9I5pPql0VxgW2B1UzXdNte5BxlwXXA2/tLmT5P6I7Ug5hG3mf+tN6hFkFg6pvmHBoMquUiGGg/XYPs3F54EnRneSKwkTiD949x7Pbmm+KV3/kDGIAxCrvJ95PkVv+awWmLDNASrVazS62rcaAQGdwkOH6bIG5JK1RaZ5YcFKcqVjCKHDiqR9C6XoVyt9iYPpGeVTjlnYyY/BbRi4D5s5G2CtnvAwP2QG2Vg0QMs/msfJNunnoznmxNoHi4mOAuQVWrKTtpNLVV8S1bkY0h4/dJ+Kc+e0rVm3QzvnrLyWFSs1M8a0UkoEHx7Gtq4lxkEUG9bO2tZIDlsxBuhcv9DSfwLG0/DbiVIspjeLLeWE2wQCIMlvtD4WFbJ5RkXWhlYGwQ/+ESyUY4ChN+o7pdKSCwiC8OdoCv+ZGoiimasp20aibepgOcTd30qPPnMHULSmL2CUpOLf3e1EqRTvCaEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5008.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fffb60b-8256-4f0e-399d-08dd5a69a66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 15:39:56.6655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gO5e2CmCkDrMCDwLp5hI8cqqThwSE57tksSMftgG+Bi3HmDbMYRfjxgc0S8Y1jNHNIT0LEpg7Xl7gqXKIvLA0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030120
X-Proofpoint-GUID: GzhglOa8GStxZoKa3I8QKGuUH2LcBl2u
X-Proofpoint-ORIG-GUID: GzhglOa8GStxZoKa3I8QKGuUH2LcBl2u
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
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

DQoNCj4gT24gTWFyIDMsIDIwMjUsIGF0IDY6MTnigK9BTSwgSm9obiBMZXZvbiA8am9obi5sZXZv
bkBudXRhbml4LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEZlYiAyOCwgMjAyNSBhdCAwNTow
OTowMFBNICswMDAwLCBKYWcgUmFtYW4gd3JvdGU6DQo+IA0KPj4gSSBhcHByZWNpYXRlIHlvdSBw
b3N0aW5nIHRoZSBwYXRjaGVzLiBJIGRpZG4ndCBhdXRob3IgdGhlIHBhdGNoZXMsIGFjdHVhbGx5
Ow0KPj4gSm9obiBKb2huc29uIGRpZCBpdC4NCj4gDQo+IEknbGwgYWRqdXN0IHRoZSBBdXRob3Ig
ZmllbGQgYW5kIGZpeCB1cCB0aGUgIk9yaWdpbmFsbHktYnkiIHRhZ3MgZm9yIHRoZSBuZXh0DQo+
IHJvdW5kLCB0aGFua3MuDQo+IA0KPj4gWW91IGNvdWxkIHVzZSB5b3VyIG5hbWUgYXMgdGhlIGF1
dGhvciBzaW5jZSB5b3Ugc2hvdWxkIGJlIGZhbWlsaWFyIHdpdGggaXQNCj4+IG5vdywgYW5kIEkg
Y2FuIHJldmlldyB0aGUgcGF0Y2hlcy4NCj4gDQo+IFRoaXMgZG9lc24ndCBzb3VuZCBsaWtlIHRo
ZSByaWdodCB0aGluZyB0byBkbzogZm9yIG1vc3Qgb2YgdGhlc2UgcGF0Y2hlcywgSSd2ZQ0KPiBh
dCBiZXN0IG1hZGUgc21hbGwgY2hhbmdlcyBhbmQgSkogc2hvdWxkIHJlbWFpbiB0aGUgcHJpbWFy
eSBhdXRob3IsIEkgdGhpbms/DQo+IA0KPj4gUGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHRvIGVh
Y2ggcGF0Y2ggc28gaXQgcmVjb2duaXplcyBPcmFjbGUncyBjb250cmlidXRpb246DQo+PiBDby1h
dXRob3JlZC1ieTogSm9obiBKb2huc29uIDxqb2huLmcuam9obnNvbkBvcmFjbGUuY29tPg0KPiAN
Cj4gSSBjYW4gYWRkIHRoZXNlIGFzIHdlbGwgYXMgaGF2aW5nIEpKIGFzIGF1dGhvciBpZiB5b3Un
ZCBwcmVmZXIuDQoNClRoYXQgc291bmRzIGdvb2QgdG8gbWUuDQoNClRoYW5rcywNCkphZw0KDQo+
IA0KPiByZWdhcmRzDQo+IGpvaG4NCg0K

