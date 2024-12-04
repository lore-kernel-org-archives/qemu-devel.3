Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D150EE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIryD-0005Y4-3n; Wed, 04 Dec 2024 11:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tIryA-0005Xv-H6
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:11:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tIry7-0003Lr-Rh
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:11:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4D0jcl021722;
 Wed, 4 Dec 2024 16:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=mI7E0NN2Lt2/a9GTYbuvI88P+Wqp7osHIh7k/HWqFrg=; b=
 gHJcKgTXDuzJEBG1eU1jDmGcsbJl+sVhqUP0wlCjlHmvTgLdZ9hNk6cLzjSiENj2
 lXnGY/pE1x+Acnn1AUPjvDvZR6XVOi3kAK7oQGoJstT6QbiC+9kdAy1RcoXespgb
 38WHoJKFso/1dQbFjeiOHXIc/EFzzEhwtzBRa2FUGCZhymB246f6T7jf/QNe8++G
 mnU/YqE03Lsu1XdQ49JvtWjDUoRNNpQLru8dYBPB35vKLrSMlRBXNyWQmfWwZVE9
 zDjxAVS2K2iWsZ5WMAQeKQ3qIECmi8K3QCHH4MYXNqYyHoD4LzrW7zO8wOcbPx0w
 QyBRkmjYcE+FF7nVQ6DEZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk90ppj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Dec 2024 16:11:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B4EgXGI037181; Wed, 4 Dec 2024 16:11:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 437s5a50uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Dec 2024 16:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF+El1DfG/g1TdutKYozTo+BrfIVUrUEnHKEM5VUSIXA09lhj1UAYpdfWdJyhb0rpyuAq1E5/BZxXCSL1FcYK5GgqvHdRe9StXDukRgUvIRyXYorHDG1wawV01LDpUYfbNYktatHjXRUl+JWNQ0fGdDHxwuRWTYiYjjBkQmpq6eQUGN7dLYuGgs/9ckonNcw1ZpUlEeSiitP8BY0r/hr+2sqAchbxcnpKQ/GfZhX0AgBdvhTlwVg1lLz1WkwcbpNndw/z711LUecZOgbZvqNXPEtb9j8OkpmbzvNzxAao8mO8bgsCEAsHYeYeZxHTM0qe1TKORsCpW5zNvmRaocFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI7E0NN2Lt2/a9GTYbuvI88P+Wqp7osHIh7k/HWqFrg=;
 b=DIP33FPfEfrjrgdeaI5FJEaALQz8NdgA1Inbg5nsCV6s8duRbSrnLHT2u5jtf+qM9epiAgmGkroMjTIbJGaEztjCpfYmcAibZ6Qgso41eCTk2AVYH/nXOhjjx1Nt+DOaIDZ11HC3xsV9qotLHE+Qdbh/sddLPnClOv3j2viLgSnazDm8er60qzFljf4xuMFYp9R4rc3BefIpfNUup61uGkjGwVU/eeJ4M/JFsLk7TMAEdqcHXrrX0ZlbR8UqAd6DYDU+gzNg7AXuQbLVAcyjlpPEHYjXNkR9hSaXnZ44dTng7O1RFoil2bcfkiYPRo8fMW0hJWqyGXsMMwb7oOLGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI7E0NN2Lt2/a9GTYbuvI88P+Wqp7osHIh7k/HWqFrg=;
 b=hYpCZmtO/WftosmC63uJmKXxSuTgW1OwXlhewLtnfgDRigg2ZicWfas6YGHvwGol3Tut8CB2PCZ0MDHzSdEdHWQaUULuuX67vPZAwPy1T5hpIXQ3rxbJzeNYeC6+Y9OARnHmRkAUBPFQXiX/H/aqWlLKm83znuPerHo1sRqk7y4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Wed, 4 Dec
 2024 16:10:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:10:55 +0000
Message-ID: <a618c3cc-7a2a-4f0b-aced-ef198e3f7ae9@oracle.com>
Date: Wed, 4 Dec 2024 11:10:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/19] migration: cpr-transfer mode
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-15-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1733145611-62315-15-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbab6c8-6c2f-430a-c0d1-08dd147e3ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3FDTVRjRHFnbzRLLzBvemtQTzJoajlZK25wV000SktyekRidnRHUkY0OU1E?=
 =?utf-8?B?S0Qvby9WaHFwVjhuc1k4ZGJxV0J3YTF0NjZFT2trL2ZHaEt0bnVYQk03aUVa?=
 =?utf-8?B?dXVkcVJzSWhlZnhpcVJPZWpQV3M1SGdVNUxhamdNOGZwa3VrTXIrOERlZmht?=
 =?utf-8?B?bUxKc1Ryc2VVRGoxVFFQazMxdlFzYkx1Q1BObFZ3WkgzaFVZS2dZZlp5ZjN5?=
 =?utf-8?B?d3oxVEZKNndubWRzeGczdTQ0MHY3MVRqdDNlME55TnhlRTF4SGZmdUJwL0Y3?=
 =?utf-8?B?ZGJoZEs0TWJwYXJKY1FWMERib0JyUjZwSDUrQldrWk1yTG1UQmN2Q3N1WS9o?=
 =?utf-8?B?Rjc4OWNUeDN4dTMrK0M2Wm0wcExsakJ1M1ZVM0NUQ2E5SGNIdjBJbUVIVzdR?=
 =?utf-8?B?OStNdlFaallEeEhWNEphczIvQ1NMSGlGZThmZ1JubzdiQ2F5YjAvdFhGL014?=
 =?utf-8?B?eEthN29yWjB1NHViN01HMzdLcHd1MURVVGpMakdqNHovbHRKVHQ1WVJmY2Z2?=
 =?utf-8?B?N3p0VWRmOTFoR1l0Z2c0eUtNamowUWxTK1pXT2gxOTd6OWdtNHVkZ29tbG83?=
 =?utf-8?B?SUhuUDFqSWNHcUdWNFRmWk9aMk9SZlZpRFNqQjVxMlFaeUJuUUI1by9KLzlV?=
 =?utf-8?B?bkQvMG9VSTAxR2haY2paQ3gvRU4yOFRMdDJTVDY3eGo2bGM2UHRRcm9GMzBx?=
 =?utf-8?B?TmJVckhxQ3JRMklHeHRsY29aeWU5Q2FXcEtNY25MZnhRQmR0ZENxaXFZc1NY?=
 =?utf-8?B?SS9lc2hxOCtzRHZvNmVGTXA2RjBlTm8rQU5ZRXM1d21hMnBwZ3pvOFZ4Tndj?=
 =?utf-8?B?NktBV1piT29sblkrYjBGbnV5N3M3Zms5aGZ4WW1GSGcyUFAwYnU3M3JkTTIy?=
 =?utf-8?B?QzJTV1BQNE1uS3ZPVjZ0Z1YwTmk1RmlEZjRwQ05GUStDdUk5RVJpT1lZNGY4?=
 =?utf-8?B?ZTg1VVJKL09GV2ZMUXpmZVczb0FDMDVyZ1J0b1VTMUEwYVhkSy9ramhRdVVq?=
 =?utf-8?B?dmNCbFFWUDdZL3hBa1orM1l2Sm1JK2tlOFhXejlzT2Nwd3hkZXp5MmEwZ0tj?=
 =?utf-8?B?T00zYWZYN3kyaUtERUNESlVSQzZkblYrWDhyTXlQNDE1UlVLQWhxWFpBbDgw?=
 =?utf-8?B?N1g5N2ZMMTNDRHJLWmpSUTUrdmltejFsMzUvYkNtMDloSFY0WXdKTmh6bHBW?=
 =?utf-8?B?ZHdZR3hIai9pbEZrK3Y4NzB0OWVyc2d2NjVualY3YTFiTitqQVhscm4wVUpR?=
 =?utf-8?B?clJEaUJpN3F2ZWoyYi9nVERwMXdoSWNhLy9LRG9SR0ZDTjBnREJIbzVCV3dp?=
 =?utf-8?B?bysrUklDZWJRbURDcUl5eGJBekNyU2Y1TU9VcFV1THpBK3dLaXhDME1kMTdz?=
 =?utf-8?B?dXpzbWNqcGZRd0J5Q1VFbnhkdmpXR3I1MEFNcVJWbU5qNUdmdTBQZE9iUWRv?=
 =?utf-8?B?cjNzKzNKeVFMZlhCZ3J1aHkrMkk5ajdRZzRpeEIwbFFDM0RGaUkybTFVZHZl?=
 =?utf-8?B?WXk3ZHhSSUtwVXFDaVBBb21udUw3dmpGc2JwUFJSR3JMWHlGNVlhUXRWZ3k3?=
 =?utf-8?B?YkpkUzlyQ1BVYXZHRVpYNGJFTjR6b0VzWkUrdXBBOXNmN1RRek1SS0ZQR1U3?=
 =?utf-8?B?cU1EMEpzTmQxYyszYTFPL1NpQzdZYnNCdkp4ZllxL0pRR3NFM2YwZkluWlRw?=
 =?utf-8?B?VW9GeHhINlp0OWJSTE9nQzZnYk91eDZ6UmRxZHg4eEpEUVJMN0NjLzAvMDRP?=
 =?utf-8?Q?iu7v1NE0JLBv2ZmElA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWpmTHpSSHpmaHprdkZDSVJwK3JPK25XaVAwUm5BeHowYWIyaGNzT2pqOHN3?=
 =?utf-8?B?S3d6QW44KzhtZXkzN3ZCbWp4MDM2NGRMNm5DQUxPdm0vWDlUYVp5OWNYcVgy?=
 =?utf-8?B?VE9LM2pBM1BkcEtYYk5maisvSFBjWVdRZ3BseXdQTkNGTkQ0Y3FsNXZMcWp4?=
 =?utf-8?B?TlFzYmpkL1NtdThjUGZveDFHNjlKN1hOZ1ptWG0xR1U2cEY0YU5TdUJNM21p?=
 =?utf-8?B?VVMrVFFTeFZ0TU9zTnU1WS8vVUhjVFNHOWs2UVJUQU5obnU3STB6WVFEQTdW?=
 =?utf-8?B?b1pjZy8vUlgyUTNuRVRHUXVrb1h3Mlo2ayswMnVMbEhnbTFSMUFNcGhjT3g0?=
 =?utf-8?B?dXN6MVYwNHpsZmQvREZFemNzNURaTVhmOXJBalcyZzNxbUp4c2hqb2s3N2Z4?=
 =?utf-8?B?OWJGQ1pLQ3MwRUFqSzBtZjd2L3VDem9PblUwbnhiTDFKcXdEUzRmV3g0ZHhE?=
 =?utf-8?B?Qk9UTHZvMzJyL1dBeWNTZktxa2NqNk1mUnYwWEdLeWxmSFY5bmp1QXpHMmFp?=
 =?utf-8?B?MmZLZDRUL3hCSXR6aGNsMmpxc21aQ1ltU3pHUzZXRDd4SUlneVl3MUFSbStD?=
 =?utf-8?B?a2F5SzduNkswL1gzajlUTjRGNXNybUE2SnNTNDdFQmZaOWtTbGtMZVlla3hh?=
 =?utf-8?B?VzBQVEZjRnphZDNaL0dNUlVlSXdaVjFvMmorSlFQSjYvQS84ejIxalIyZFR6?=
 =?utf-8?B?YXJtODFUUFBEZVBucGpTblczUnE2Wk51YzBDbzYwMlhQZGNiNWgyZWk0VzVh?=
 =?utf-8?B?azd2Rzh6WUdxZmpyc0lYaTY0Mm8yK1J0N3I1cGJWblN2RzFYdWlwYyt5Q3hj?=
 =?utf-8?B?SzZwcVJjRVpFOTJjMGs5dURQNE52VjhYSm5BVXk5czB0MzNTZWdBTXdnelpo?=
 =?utf-8?B?RHBpNGlIQzgwWDZIa2xJekVXSjIrMFdaL0Y4dkRuL1dIenFDWXV0dXlFSEpx?=
 =?utf-8?B?RjByY283UVhiOXB1eUt4ZGRKRlozSHlITEFEWERhV3JZV1A4NnBZTEVtYXRl?=
 =?utf-8?B?WnBzVVVEN3FyUVVVKzNnMTBrNG0rb3RqRnhrQXRsZWhwMzJ4eGdJMk9OK1Zu?=
 =?utf-8?B?STJxNVdSeWNEd0ZhNVdJMW1UTmNwT3R6bjYzVkRKQUVqL09rcm9Oc3NOZ3pm?=
 =?utf-8?B?MnZXZ3FrRjhvM2N1V2dBYjByYUU0ZWFNS0t5czNQWmg0Zkh4YUhjbnZwbzhV?=
 =?utf-8?B?SDRtdzF3QWxua1p0d0VFYkJJQ3d4WkhVWklpak5BUXJYV0V5d1RBMUdsU2VB?=
 =?utf-8?B?ekp2K09UNURwejdNNjZ6VGMreGpzWm5NMFh3NlJ0dUhjZ1VIUEtINXl4Umo4?=
 =?utf-8?B?MWZtY21vd2lnSHU2VUZoaUFEdFpjNThsSlNmT2F3aC9xUWlFeStkVDZvcWEx?=
 =?utf-8?B?WjhSQUZsQ3ZXd2lqZFVoYXUyaEwvYmZ0ZWNFZ0ZaMXVoK0FjcXN6WDlIVWtK?=
 =?utf-8?B?VXg0WjR3K2lIMTF4VnNhTG1SRG90L29temtVVEpTWlBNUG1CY0w2eUN5Y2J0?=
 =?utf-8?B?Y1Fib3JvbG85Q1pwMHZndFBzKytOeFF1NE5zWUQ0QkNjeGcyZmZuUzJXYU8v?=
 =?utf-8?B?YjVtS3B6WTJnM3ExR1dEa2xtQWo4N2piaUlRL3FRU0dVQm14aFM3bStwMlFa?=
 =?utf-8?B?L28xTWhQdS85TlpTOGI4ZHVnRlFVTnFLSk9MU2hyQnVBK3dkM29ocEpmb1Jw?=
 =?utf-8?B?TGZITEhtVlA0b09XWWx1NzRiMEZMYjEydDdRVGlRSDBMc2lXSDM4ZE5sTldP?=
 =?utf-8?B?dkpRTm5acW5ZMjBSYUphYkJwN2ZkcGRHalFhb2hFZUJ1UjloSjZoS0tlRVh2?=
 =?utf-8?B?SFN3ek5JTG1IbXZnTGZXdk85ODlPZjV6TlhpVFFHVjFOSm8xNkJ0V0d3KzE3?=
 =?utf-8?B?SHBXcFVaWFphc1VuY2pnbE9ka0puOWlVbTVrTWt5Ty90V2N3R3EvYm9mcFdR?=
 =?utf-8?B?c01UTmR0ZmNoUTBNQ1JDMnVvQld0V1A5WHhHMjlLeFBWMERJSjZNakRFczRm?=
 =?utf-8?B?b2RweDJ3UU0velNVTlJ1azFYSHUybmZySGNaSGdvSTUrNk1yZG9TZ2JZVU5y?=
 =?utf-8?B?bFlkWmVGSGRsUjBnSFdpSHgxTGRLaWRoVHZ0OGI5QjFkWXdQd2FZNER4VDh0?=
 =?utf-8?B?QnNzcnhLaUxLeVJNTjc1NXZnR1ZYbU41MDIxUWFUTWlzRTJFSDJJRFZSbEo5?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5SADtg8DOh+CPIlo5v0uKs1mbmytGbF9fjmGWbu5Ry9a+ZsIbNRjwOpc8SAy5lRyEEliQIvgdbBDcM1+sgevy/PYb7xvYQlkzSQwTcAR4KhZyozkRIjEIWKuO8IsO9xfhkAKru462QklGfn1tufiCsh3naH8tZz+awy/OIxjC5ILrSntMSvje3MNCwAkmbpD220+ZaGhZKWM+8o0z73uYXeFDjBHHzE6C2fPzDqxPs+Mu/oW3XL45A+U33VL2qR+sdxH4Abk+EdKViXwGw2qgOv93JfVPWvIqn5cwOj1Jl3ZtZ+4ZwdOxsw1vUqMIdmXkarM+fx17F0mmgN8huvCgvoZEhpIOIkeS4xdLBBBE0EJhoYpsne1XhHCQ+x3HIte8JCa2Xc6JWhaIMYvFJEhVRPhDkqz6MWFPqnSZOD+r/ylMitJddFIWNlE4XJMYVIL7HPe6tl4JRGbm9g1ZCBH/Hcutgxh3jH1KnAqlH5C187GRcWlJylICefhNFh19cAwC30TssMOKOcso1N0qMiBKZVwDFQBb8JOK8X1e/hFUmRq8wksc6XjoxGHS9fowF50mDQhlde0C0SIzsgawecWawDuAfO1lMa7QOGpnVixVgY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbab6c8-6c2f-430a-c0d1-08dd147e3ba2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:10:55.8058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPN0LwRETwNdOpmcrrcSZWopyh0CmgM4cLpOy196A2gigfZs1j+YNWzQqg+24CE/W+VuIJjcz8cUyDuwYOcWBxi9DmO29sbBo/DyGZoQOak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_13,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=981 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040123
X-Proofpoint-ORIG-GUID: uyZtUKWtafq-_YcMZW1OrCqvcUVlEEZ-
X-Proofpoint-GUID: uyZtUKWtafq-_YcMZW1OrCqvcUVlEEZ-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/2/2024 8:20 AM, Steve Sistare wrote:
[...]
> +
> +    /*
> +     * If qmp_migrate_finish has not been called, then there is no path that
> +     * will complete the cancellation.  Do it now.
> +     */
> +    if (setup && !s->to_dst_file) {
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_CANCELLED);
> +        cpr_state_close();
> +        migrate_hup_delete(s);
> +        vm_resume(s->vm_old_state);
> +    }

I forgot to make changes here as we discussed in
   https://lore.kernel.org/qemu-devel/2dc614cb-8754-423f-8c31-e5425075af92@oracle.com/

I will move vm_resume to the patch "stop vm earlier for cpr" in a later series, and
verify the current state:

+    if (setup && !s->to_dst_file) {
+        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING, MIGRATION_STATUS_CANCELLED);
+        cpr_state_close();
+        migrate_hup_delete(s);
+    }

- Steve


