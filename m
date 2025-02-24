Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8247FC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmeFS-00051X-5k; Mon, 24 Feb 2025 14:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmeFP-00051G-49
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:36:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmeFI-0002ta-8b
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:36:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OJXhcC014327;
 Mon, 24 Feb 2025 19:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=jYK9Tx7dTJkLIdrmXOZScV8IURC07zdjFvCiJQkV4Eo=; b=
 cntJrQgpTeY0dqST4LSwNm3MZWwo/YLkuvNNG4ygCzMnzlDYToCP2SX1zHmuukrL
 7aRfiknfYBnYgAdvkJ/XBW04Dr/3N7s5yrRwq+mZReiwUHJu4407zy98Fgp6XLJS
 uedyP+2oWsTYaRn9wuKcA5Bbj/2uewGRIsdo6oonQNkKIe2SdDfTMTMa2lUVgOLL
 RFx/arz7u6Pu3+HJfcEx3kHZnpw/d6RS/R7/+BcLyzXXJdGu1bkczuQfWf40ZT/7
 VRcREwlAWZxLlg3Q0t5eEc5vNggL7/FaN159F2ibHr/PFvE9Fu7MG/gqP3lLm/hV
 /eLjv/ulUJeoX5D48Xx5pg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2bfp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 19:35:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51OJ7UHG010085; Mon, 24 Feb 2025 19:35:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44y517vwy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 19:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTvRS+UObJjXmVh2wTViy5XjP+Wd3T4Ipnb9VxIpfPS62zWhWHkqjCnn/0cZlw1vOIv5VliPNO0AWQEswFV7VnQa5H7QWMzznSs+SJy6jMcltZsz9lZo+J8Ih0rerpcMDh5gr5xFkiD+r4R4wSgtRzo8A8pXupRJpJ84QGI+5260UNw8h8+0m0aw7+/WTtZ2ztIRhLtE6ub7GBgAE3mzsXuK19mQ9PsSbsNwfY8deMB8s4j/5poe+W+tSjz/W01ngzoI01+Tdz0pCPoVrvhjC6zTe/FmL7ZCxb4tk5rZH3A93dFcpRiEeJgXDjGfLeKoxdoR+jZ0VoFLMF9UI/cRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYK9Tx7dTJkLIdrmXOZScV8IURC07zdjFvCiJQkV4Eo=;
 b=vWZl0v61nnYyCLZUKd37kPeicoKIJ70MXH1QzIwndEGF/RUnxsYiI1QNbZf+KyBOd1FgzcODKBf0sdvpwGywp1HzuBuho/G7UwNgg+X8JrjdLEuotpGj2QYDcZscJqG2VXSZOSR6tyUJ01LctjqEySQJ3LOf9r99ijZI7oopxjZtvENDYcQLOfuQMSK1hL+EkSr5AbZfu2kIJAv1bAdlcutQRQXUuay5YHCC7+1VCRi9N4fxPLPWV7M5sOSVJGroLzWD11ab/Sj0+NOPzx+Mh1CnrW5m0tKGt2AVz891ekj1sVKqV7DHSmpz2Wv+NomgP/UvOJA9MeZMqw9VnKeGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYK9Tx7dTJkLIdrmXOZScV8IURC07zdjFvCiJQkV4Eo=;
 b=Wm+gDjRpS+DdPdQLpoue+8T/Np7Mlt+iu+JOtvkafYtoOUGu8tQO0zMC4hiZUGYDVFzTRahjv1w3FxEC5h3ldvEmPxUsCSUGaJ61TvydOqIRioceR8c1zcUuLYRcEIwx2RMg6/mc2L1QzPUbetdzmrDOUGn4IQYqtw90jMPuTZA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7789.namprd10.prod.outlook.com (2603:10b6:806:3ab::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 19:35:50 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:35:50 +0000
Message-ID: <3a93c9e3-caa3-4700-8d9f-363e444bf8e4@oracle.com>
Date: Mon, 24 Feb 2025 14:35:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
 <Z69z6oTtaGOC287O@x1.local> <b6e19df6-cb38-4576-bdd0-6278997e402e@oracle.com>
 <Z6_G1rF7x2Nbzpl4@x1.local> <4f6ac09b-7a58-418f-9212-da12b8412b6e@oracle.com>
 <Z7zGim2fayueJQRd@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z7zGim2fayueJQRd@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:408:f5::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8296bf-390f-4ad0-e4d9-08dd550a71c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFFWSUZ4M2twTldJOVFRejcwWkgwTFNMSVkwMUgvZjQ0TW1GSDZ1MHJDWlh2?=
 =?utf-8?B?bEJ2dnZhcnBkZnBTUE40ZzlWbE82TnA1TzUvanFiRVJ6blF3WXI1RGZmVTl2?=
 =?utf-8?B?YlVaYjRFVW5wR3liL1BicHdxbnFHUG1xc0xEVW5qSE1CejdGQXpscXBldkpM?=
 =?utf-8?B?aXpCbUtBeWRlUW1hK3NCU1JWZUpoZ29KbVJXdnZkUWwzRjNheFNzY2RRS1dz?=
 =?utf-8?B?RUtWWnEybTgwMXJhc1ViUzVmYXBuVmNHWHJNQWdQdUlqTHZNbVRmeVhpUzlR?=
 =?utf-8?B?cEdZdlhmT2dGUGR1M1NCVFhURVBUS2ExY1p5eFA3Z2NjZXJzaVJZeWZHMmUv?=
 =?utf-8?B?TjlQVVduZFhyTERkVC9XV1Jlb2FrenN3WlZnMjB4N2VhUy8zbWpzZUtyaGkr?=
 =?utf-8?B?QUxCK0F6YjR5ZTBsR3NXS1JvSlhQS0JvR0lBcTNxOXVmU2dBRi9sT2hVMEE5?=
 =?utf-8?B?azVWN0hZcENPcUpBeDJ6bkdJQmthOWNxNmp2WGxoWVVZVDhnMVhBK25HU3ZN?=
 =?utf-8?B?aUZqdFVJQmdaMDExNlFLRjBMLzlhRGRYcVMySElrQjRXMzk0dURCMG1EVzRT?=
 =?utf-8?B?Qk0xNXVuNExLOVA4QlVNdDByOEJoaHlYcEQ4R2hndlFGNDhYc1oyS2lxbmtv?=
 =?utf-8?B?VUR4cE1PTFpqRGRnRzYyQklhRjhhZXJ6RXlZSWY3c2Q4N2lOTWZ4NUZrT3hn?=
 =?utf-8?B?VWx5QUhveEtRQWFjbTR6THRlOEk2Wi81YkxPVldPdm0vTkVrM0xoOFY5dWRH?=
 =?utf-8?B?TTFUdWx4K0IwSTlnSXpMZ2VWWFlyNVVlQ2J2UGF2R2Rwc2t3VGRSNURNVzdO?=
 =?utf-8?B?SWlrRG5ZQW81NXppa0dWcWZOaUl1Lzlmanl1MHVqSDFqdEZENWtQQUtNU0pm?=
 =?utf-8?B?R296WnFIWDNOV0RnLy81aHFzckFoYUlrcVkwbEZqVVN1VTFEVENjR21Jb2lk?=
 =?utf-8?B?a2hQbytFQmovZVBXZFA0aENkNHhEazFVK05nNG9GeTdDb0lSUWZ3MkR5YkN5?=
 =?utf-8?B?bVZrR0pFTEtnNWN0emxUazFFWi9zK3YzT0R4WkhxQjlKSkFtM0RiOGpKS0hQ?=
 =?utf-8?B?ckdyZUR0QzZwOEs2Wk5MWThyK1hEWjFON1ErZFdraUVETmxPRkNkOGt5dHVm?=
 =?utf-8?B?UHNkWmNSMlU3c01oMURKbG9CTmtvbXdWQkd2NEYxS1kvbC9ZZjE2NWdaUGd6?=
 =?utf-8?B?TGIvWEh2YUl0WlduRVZCb25wYm9vbElONENJSEFPVlB1T3kwQ2RkejAycnB0?=
 =?utf-8?B?YktOTkRJMmFYN2R1eFp5cURpRG1mbGFrYUVQZXJINERlWEpvMjJqWHRuZlg4?=
 =?utf-8?B?Qm1HcWRQQjZGY1F0UVVxc0FHeDVGamhOUmJMMmdSQkRiRGpWVTIrR0VtTVNX?=
 =?utf-8?B?dHl6Z2hvTitmeDEzbm9TREUyWXkxL3FtZzFQUXYveXFaVkpSVjllalU4VlZY?=
 =?utf-8?B?Vms0T3lYaURUcnUyRWJvcUVZYm9hdnRxZ2I2ZXBUNW4wWExrS1dKUEFmNmN4?=
 =?utf-8?B?UWN3YU14TzludXY0NDQ3UkhXa2FXeXJCM1BGbFBwVkQ0SUpaTWc1c1o2SzQy?=
 =?utf-8?B?cnkveHNpbm9zd0dUanpId0kwUzB6Qm80QXdwQmw4eXJVQXVxT3RKbkw1QURt?=
 =?utf-8?B?YmlHems0d09LQkpiZzJPQUZ6cGVLOXhWVjcrY3dYb3NoRW4xQ2FtT0R5VW5R?=
 =?utf-8?B?ODFqdEQ5RGFXWjE1MlpSYTJJdldhdk5MdjFpTmE3cThHdE1MQVJNeGh3bFlX?=
 =?utf-8?B?SThmQVQ1OE8yTVpjRXM5b1lZVWpwQTdXOFB6ejZoOE9WR1hJZTJya2RPSjRU?=
 =?utf-8?B?YkFaLzlLUGJQbkxiSERQdWoxdk44YlJsV1pnM2pROEdYQjV0bmZpU2thdm11?=
 =?utf-8?Q?YaahpS1QEOY4o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2V6d0ViZEpxUVNGTVRGRXBDRUlvZXUrYnVOaHdSa1NhN1ZPQWR0V2JrZFRR?=
 =?utf-8?B?ZHRBY0hJL2txKzdtcUczZDBqZHMvNitPVVRKTTZFNjFybTBtaTV0YmhENXNr?=
 =?utf-8?B?OFI3MWg5aFNRbmsvVDh0UElMdDlLVG1oNXhVWmNlaHl0MkJXYWs3UzdoZ1h3?=
 =?utf-8?B?djlXQ0JHYWdOZXRETGNjem90RGNYcWVVWWxTNkxoMW1RME9jeE1CYnBlbnl2?=
 =?utf-8?B?R3FxTUI5eitsMk13OG5naWhKQk03a05nOVFYMm5jUEVMOE5obmJLWGRCVUJp?=
 =?utf-8?B?N2Q5M2dEWXcwZ1NpdUxvc2JMczBrVVBsbXpId0FoRGl3azhzVDUyV1J5SHdY?=
 =?utf-8?B?WGVyeDNIQ010VStqcGZqeW9zajVtSk9USFU2Rm1aRWVQZW5kMVNGRUsxRjZN?=
 =?utf-8?B?NEUwRmJqNCtHbUxJRmJVa0xKazFDMVBYUUtwSlRTVm9UWDRzWWJmSnZQazFQ?=
 =?utf-8?B?bEtOZDhhdmFkMVJaT0xDSURIcU5YOHdXL0RHSW5iZ2xzb1c4TTY3MWNWRCtp?=
 =?utf-8?B?SUlKMVRCTFR6NzlsL0dEd2tKbVFhODdMQVBIYVZQT0lpd1lGN1krVmkzTUwv?=
 =?utf-8?B?VEM5SjhUcTl0VmYyR2xsTGQzNXVOZjVqb3k4Tm5PNENrWHRNWVZid2hIcGEw?=
 =?utf-8?B?QWdoVWhoSGMzWkV6RUlENjdKWFEvaUs2bmlUWi94ekJvMUwwelUySFVqdU0r?=
 =?utf-8?B?MVNyZzRJRzlFM284TWZzQ2xzNWRBZDNiWHFrQys3Z1k2dHExZ0RpcE9pd1hI?=
 =?utf-8?B?NklGcks1K3p4NEh5ek9Ta1ZxZE1PM3RET0RWaDhYNHEvcWlIRm94Z2JLQzJx?=
 =?utf-8?B?M0dYREhBWlUvME5mbzN1ZVdYYVJxZzBmSmc1bWFlZXJkK3N0RGZTTE55UzV6?=
 =?utf-8?B?cDErSHJld003N1pCUjFoLzlnNm5wZEFYeUlETEVrV1RYdEFid2F1QmhWNWhr?=
 =?utf-8?B?aEp2ME5Nb2tHN256OGJmcXpkYTBQL1ByeTVoRHNHQk1iY2ovanRaek9Sdzhv?=
 =?utf-8?B?aCtlVmQ5MzBYQ2pjdVZJN3hYd2FoTkZjSTJ4eUtmSjdFNWpXWjZmdGNrS29P?=
 =?utf-8?B?V3ZiR0hWV2p1MG5lY3RVMEdUVUJibnV3OWJqTmhTeHZBNG9nRUthYmRPK01k?=
 =?utf-8?B?d0daVE9aNnA1TXJpWGlBRVlrQUxtQkI2THMvY3llUFJTaGJZNUNjdE9pa2tF?=
 =?utf-8?B?dkVwSkxhYWw0b0R3VDZhV0VoNnIxTXUvcFhGM2svM3c0RFQzcTdYQlRvcUdu?=
 =?utf-8?B?eGlqbEJhTWlWNEpRbFZpdUdHRE9ramdTY210UGhKZHZWVmVndXoyNEpjV3Mr?=
 =?utf-8?B?ejFNZ2ZRaHBtNmZyVzEwZ2xlTm81V0p1R0VwdlB5TUxYYjZrRGZ2MnRtYkJ3?=
 =?utf-8?B?b28rUDZBcVlyMFUydnh4M201ampuVStKNGljWmtJTC83dGFPdk9YVDNFMjFy?=
 =?utf-8?B?ZmFSS3NjbjB5dElLMEM3VWhnQm1FejhuVklJVlhvK2pUZzI3THNibGVLUlBt?=
 =?utf-8?B?SjVaS29oOC9FL1FQWWN1SVBDOWRqTHhKbUxkNU9rUm5KOVV6WDRVNTF4djZ3?=
 =?utf-8?B?NTQrQkdBb0VKWDNZTHFqRi9EVThYWGlNMDIrZ0ZPU3d2WmM5NjFldnlUUEZ6?=
 =?utf-8?B?QVVIeDBLUkZOSFhsbG9jRWNMQnViVUNFdWh6eDYzZlJVQURGY1ZGeHRIZE44?=
 =?utf-8?B?VDZFdEwwQ3pTUVcycld1WWlSM0llNVNmMzB6aFBtTllybmxlcHM3R3pBaXB5?=
 =?utf-8?B?dTlHK3RHQnZhM2VLVUtEZ2F2ZUJEbWJtZTcvcFlkdTdkcWNjN1JvdnJUVnJF?=
 =?utf-8?B?ekFscUhhdTVwNXJMeDdOQytRZGNUa2ZCUFBvcGQ5N1pYdHVuNG1KSDgyZXZk?=
 =?utf-8?B?bVpSNnFyWkwveEhuMGZnbVhROG0veUdtSnhwV282SnhxUjJ1a29PdmxiSjcr?=
 =?utf-8?B?dEt5cVhjZHBqbXA3N2ZodG5vajZmZ1NOYjZDRWxRdVNKcjY5K1czdUkzczg5?=
 =?utf-8?B?LzJBQW5yeHVRV3g4Y3pzVGJZUy85enEzOTJrRm1FWmRHSGY1UFRKNmRSblJ0?=
 =?utf-8?B?RHp1QXNLcHhjaVVwb0pTQmpuVWJ1TmVrbnczaVcwYUNjdm00Yzg0SWp2S2Rx?=
 =?utf-8?B?Sk5mcEQ1V01LYlpqNktncGlyeGtxQTN2K1hLMTFlNDdLdWV4YklUdkR4NURU?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U1q3pQ34AAg6ZsIyQ6/ctu1yE+l5Iha2ZfFcNXLCtYIZXQVDBUxI5NLvrzDGbCB7kxwzjH1Sb2+x4b86Kcn++vbtbLanv3mcH6reY0HqxA1F7qz3H9bfPmd5YChPz0+O0t3qSGLTxmKlnLNxAKsN5FM/Ll27MrndRLnd4hYBXWAfhPgGZeSOksmFNzNwsSGlKUlgr6LM5vBmijw2+3iub7eowiEO5Bm3hBSHposZEZahQkkPsT4D9i2BWK7DA1tQBzf7NwyP+3MBvzmbPNvBYx/fSRahDlUBawbVy1boFFU30bPY3IEEE9LpUuBVN6C6/NsJ4t+KRAwL2F8OhjE/6Y3z+QilN0MJ4c0q8dwkdH8HL7kppTeD2h0kkLUCLUcjvuwxTv56BoNV9qCbeh6a2ez8Vt4JgeBti/VKjTfOj3SKrbdNFWOQ0AEIHAhSMj03D+QSNpFyxzdj5T20sAYrD5zp+dn2+husKFsfvNnMdJOh8+F67umgjI40qeFpO6UViePhnieTaM8jOMJzCtptNC+nMqouPGDRaxdINBcZZvETqgTaY7e5sjLb9v+SdHWVZzgPqdJWPNKmkbcNBfoiMLVKL9GU9fPFVb8XigyH2MQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8296bf-390f-4ad0-e4d9-08dd550a71c8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:35:50.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1YTctAA9LeqnCxkwYkQ1BqYeIEoaAndm/npcJVDDODKI1AWkY5sRJtUSlhkG62BUCATj3itfQHTfMxuQcqTfxALiPZ/IwUHpCTX5prXwBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=815 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240126
X-Proofpoint-ORIG-GUID: 8gzLHoNP09XIkHphG-wiAMvjbMutlTky
X-Proofpoint-GUID: 8gzLHoNP09XIkHphG-wiAMvjbMutlTky
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/24/2025 2:20 PM, Peter Xu wrote:
> On Mon, Feb 24, 2025 at 11:50:50AM -0500, Steven Sistare wrote:
>>>> I can do that, but it would add cycles.  Is this considered a high performance
>>>> path that may be called frequently?
>>>
>>> AFAICT, any vIOMMU mapping isn't high perf path.  In this specific path,
>>> the refcount op should be buried in any dma map operations..
>>
>> memory_region_ref contains a comment that implies we should avoid taking a
>> ref if possible:
>>       * Memory regions without an owner are supposed to never go away;
>>       * we do not ref/unref them because it slows down DMA sensibly.
> 
> That's for internal / permanent MRs that don't have an owner to speed
> things up, and that should be orthogonal to this, as that'll automatically
> take effect even if we use memory_region_[un]ref() here.

Yes, I understand that is a different type of mr, but my point is that the
author claims that memory_region_[un]ref() can noticeably slow DMA.

> AFAIU we should always suggest using memory_region_[un]ref() in callers
> when there's MR references.
> 
> I'm also ok without the boosted refcount, but then please document the RCU
> implications on referencing the MR, and the MR reference must not be used
> after rcu_read_unlock(), in that case.

I'll do that, to avoid any possibility of performance regression.

- Steve

