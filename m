Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E65FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 18:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3f7C-0005d1-NX; Tue, 30 Sep 2025 14:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3f6z-0005Zo-Vn
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:30:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3f6t-0003yW-4M
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 14:30:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIJfhC021515;
 Tue, 30 Sep 2025 18:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3My6AjDYcTlLdrdkZtnsO9j2b22TL0hMwhp37HxfqNQ=; b=
 N/rkopwmK8hXD/PxElv7NyzAqRTNHRUb21OfBLrCFftnLb9QEtpdI+AW4CZ/ZaZN
 80IXUA994JQG7c7hRVgIpX0ineMYvBR5GvtBiIzLkXfxhRQFSuOrnakeunTywOxX
 TWmUVLvBRwzuqyQaGZ1HY4I8LfNIimIBWRWZ8fZy916WwzRyfzcHREfDfoBDmHfK
 TfWu5eyKUzIbuTjKEoovtyJNpkG+hjruXMSpEBgFL1ptbQ/taQ4Y52WdU2VPspWa
 zezjXP4wtpkke+2dWhxwFFpDxs4XjJXhG+FclekXsYice+wb9kFBjqH7b9dW9R0L
 ZYO2ut0YGNMGTJbJg59lxA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq00ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 18:29:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UHdBRJ027173; Tue, 30 Sep 2025 18:29:54 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c87kwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 18:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X12K4zCfJ7mFGj3DKlvHD5dnn7Bz4s+XlwS70YntJlv5fodaQq/usq9kj7sAWJLWIOkoWoQr9tiX9Upyt5TwinS6vo7NEgQnzzEf/mPObCOPB/hFh8e81fBy1UC6EajfUKRD6+41ZufEtcmL+M6BjC9b+Icepr+tH8F0jKuXEO63O1aDFPvpCMH32h1hgFM7Cti01J4F/xj4o5JGK4YEWasGaviOdn/6yq/yw6+vK3Y1Z4L6x+8/GKdTF3I9dhLyqWvGKnG3I3Ytv/hpApJrYGpecnWCFUZB4MlUJSqpPowOn+Q/N6V0nXD6jmmN/9u6ygGWDeE+phddW6ezskhblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3My6AjDYcTlLdrdkZtnsO9j2b22TL0hMwhp37HxfqNQ=;
 b=cVxIGkOBJQOSXqXwkgNsE6rtHIJuiroO70my98QoRELE/TWz+j1dk7CQmTal/Llv+5Yf4Yz0mMJ6hvcIov5O0E6eczIABWy2ASJGG/eUyif8d8FbSAnMPQfGlgLbi6ES51+DjnwMZNtapqCOMKh9VYe0SCV6mhZGJ7Xcb5+jZrXAWiBNH59/Xpcpt5XWjw6iioNnwQjgEpsme8wAeBfbrqhrtqntgcYI6O+WT1rUG1Gs4S1qoRaodXYKVG1gFPMQRs1A2LcHOhHi5vzpPENjU4r73KCdTOCDG1Winw/VRmpe1RYyS3TJYdEBariJItqKqlFPP0u7Poaercd+aRfPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3My6AjDYcTlLdrdkZtnsO9j2b22TL0hMwhp37HxfqNQ=;
 b=G7KqxHYHPrJjXtM4YrLMfrl6uD8bj0eS8fkXXQG39dqsoLjs9y5qRmVASmHRIQzIFqk7paLPqnKlkeC3GsNPj4lfHZPQavqQX2VQpI1p+3RZUp3h8Cjo3sExUIS8FK9ur13v4OCcq7cKhQ8qrqQug8xJiKRNCqcqS7ODL8/gItk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN4PR10MB5607.namprd10.prod.outlook.com (2603:10b6:806:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 18:29:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 18:29:41 +0000
Message-ID: <71126cc7-934a-4a68-a3c8-a8aa4f113151@oracle.com>
Date: Tue, 30 Sep 2025 14:29:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 6/8] migration: cpr-exec mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-7-git-send-email-steven.sistare@oracle.com>
 <aNwHz39FkYIq7DgX@x1.local> <56116ed1-a299-48b6-b6af-af36ddc9a16b@oracle.com>
 <aNwfakXJCoptr1p8@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwfakXJCoptr1p8@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN4PR10MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e15675-a421-41bc-2a3d-08de004f5234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhFM2h3dEh0VXBjSVNNczdGamV0bDNidVlYV2s2QjNZWk5JeHN1MlFrZGZW?=
 =?utf-8?B?WWI0aVFRZnptOVVBeUtIaWp0a1VQV3RqQ0JBOHl3Q2pQYXdNcUZXenFDZXdK?=
 =?utf-8?B?ak1OWlU5a3hGRTdsRkY3eDF4RVZmcVd2YnA1Q0FuY0FRQmpGUlpiLzVJMkdH?=
 =?utf-8?B?eDV1cjliWG8yMGllQnNRamlyNmVCVjhDbkFlN09yNXRtOU9OVWFZNkZkcC80?=
 =?utf-8?B?VFQxdFpGa0xLOHBrZWpQYXJXd0NDMGxiUzZ3a2lEREQvOHh2THprQ05qZjhR?=
 =?utf-8?B?dzRSbjBrWHlmbzFzT3N5Y3dDcVhIZVF4WVZzaVROcUk0SnRvWDN6MEZULy9L?=
 =?utf-8?B?RmQwMlZWYnhoVEVQMldrclNBbkVMTTNvdWxFaGNYTVlOTTBJakNrS0grdGxC?=
 =?utf-8?B?MkJKMXdzUmtQY0FsNEFmWExrV1VaK2hZN2QvZzlINnRvaGFGbnh0V3pFSmxy?=
 =?utf-8?B?QmV5bVhWRUkvaHlGdlNnTitVaE9UNDU0QzE5RWpvdHVDdkRmejVPS2hNcGpi?=
 =?utf-8?B?Q2dlUDdUVDVLU2pqUFJubHlOMmhoREcyN0E5RW9WdmNnUEc5RVBCSWFsMUNU?=
 =?utf-8?B?cmp3dUljaFpkQmpJbXkzQ296MnZzaEdPMHpWZ0IxZHZrZ2VrbHJVMEQ2QzBW?=
 =?utf-8?B?T0Rzc0pZUVoxNVhYck1NTVpKa2VxVGFzZGFXR0lEQW80d1hWTXJSUm5lZnBP?=
 =?utf-8?B?Q2hUUmJrdlVzbUZvYmxDdkpKRDBSK2s0em1BY0g5eWtpZ3MvSUszbExJLzZ5?=
 =?utf-8?B?MEMwN0RJZVR0bjNueFR6R25DUTRyL0pxNlhLRC9MS0c5eGVXSUllTVd0NzRL?=
 =?utf-8?B?aml4VXlaUUx1WXNVUkpWMFdrMG5MSVhCSnF4b1REdk1Pd3RKYWtZOEJOZjM2?=
 =?utf-8?B?aklzWmlyOEk0U3R0eWJrNklMcVpUamx3SVlJS2hMVTJIcFVwUGkvQktjUEo4?=
 =?utf-8?B?KytqZHJXdmlnZG5DRFYyNEQwY0pjOGVmb0ZDcXhja3Z4RFIzRkZIcFBLMldD?=
 =?utf-8?B?UDRoOHBDa1g5RlQwMDR5YXFqOG1hQjd6VFZmUzVyaWNHbHhRVTFHTnpoU2My?=
 =?utf-8?B?cnA4cEVPQVlNdFd0OTBOSGZocGlvUExxSWU2M2g4dVZEZmsxUjFBSjdUdzNL?=
 =?utf-8?B?ekRaYUhBSStROW44eXBaTy9jWVZlZURickIzbEx3VjJmSEZ1SmFmaCtOaHJY?=
 =?utf-8?B?SGppbm1IWTRkdlFVbElEWXQ0UGxmQ3NvaG1lMThXTGNrTnllN20rb2djQkRs?=
 =?utf-8?B?TUdwWStpWmlyNkFuVzFOdHkrNXdtblZRV0FiRU1DQXdzWG9yZndwZ09LNlNN?=
 =?utf-8?B?TUdOK1FXaFhiS2FheDZhVklWV1oyaHY4RGl6aGNqTHRTcXJtSU5aMTBWTjNP?=
 =?utf-8?B?eGVCVTlYQndYOFhmUmhvSzhqZHY0d2k0Z3lFb25uTDRxcVJRSDFLVXVIRmNv?=
 =?utf-8?B?bUNEOWwyK1d4WG9mdlQ2SkhJcXkwTjdtUDA3MkptVXhjTlRGaHNad2JpMklj?=
 =?utf-8?B?eXg2UjFpK1dQTWlBWGcyMGdSWWU4UU5RZHF4aU81QU01Mm9wTCtQTDZMRkdJ?=
 =?utf-8?B?YmNoUDNydlRqNys0SVF3dW5VVkRJaUZoWE0rdmEwU05sd21kRFRvWXBUOVlO?=
 =?utf-8?B?Z3hMOG5PZkc4cXVNV2xkVWo1ZHkwQTVVZTNoVHBiMVFNR3lySUE5b2JqNlQ4?=
 =?utf-8?B?aXdoYi92NWh1ald5Z28xMEttU2gwd3RGaGZXc21SNFBWdWhOVHowaWFhSUFO?=
 =?utf-8?B?RnlWS05GWjJmcmd2eU5jbVJoWHBnMGt4WWUwZmhzS3drQlNpZkprVDBHTGhR?=
 =?utf-8?B?cEJndHpQbFN1Q09sQk1uaHFKOWwxN0FhTEhqY0t0VGZhSWwvV1h0b05LbUdB?=
 =?utf-8?B?Y2JUM1M1M1B2a3FWQmoxK1NUYzFxQW5nRk9yZisxWTBpTTNUcm5FbTk1Y3E2?=
 =?utf-8?B?SXhDQjRTYUtQQnhkeDg1NjFhRHlqcHhuQmN6bm92Q0RGZTZJL1ptQm4yZWRP?=
 =?utf-8?B?b3BQaHVmZGR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVBZDNYbjhaOTZyQWJIYzdDRkZlUWRJbXJwaGxqYTAxbzFIM1FMSllVb1k1?=
 =?utf-8?B?YitYYVFPU0tkUjY4dkVtQ2h5bU1WamV6ZlBSMmZGSmw2dEFVSkJ5QWRab3h3?=
 =?utf-8?B?ODE2WkdDdlVDTkxFc09JL2xzRVVpRTNMcXB3UzFwbG02Z0xWbHJxNEJRTGZG?=
 =?utf-8?B?ZFR6bnAyb3R4UnAxcnhTRlhtb2ZvN1FnVkhqV0c1cXV5WWtGcmRlK0srU1ZL?=
 =?utf-8?B?ZDdsRjQ5QkU2S0UzUTNmWEg3VnFTcmFNanRQZUhxejFpa0doa3U1clptQzFK?=
 =?utf-8?B?N2R5S3h4NGh3VWJRYkdmdy8reStCSHBPNEwzTURUR1I4M0U3RjBMUHFzNzFr?=
 =?utf-8?B?Yy9JOHZhMCtqKzBYZFJ2S0JMTCtTSkJUeXNKbWJQTVhaWmM0dkhseXlIditC?=
 =?utf-8?B?OTlreFJybm9TQ3BiaUFqenVvcXRSWDV5Slloekl4QWI0cmpHQlI4aXVSQUg4?=
 =?utf-8?B?c2YwT2c5dUQrVlRoVU9UcXltMjZlRUFrNElEbW1wN1RuekhLYmpDMW9vcFA2?=
 =?utf-8?B?SWFwdjNPS2crOU1ITDBuYUVrRk1NL0szanQzVFpFR2hVZ3RIM1JhTmFoK29m?=
 =?utf-8?B?MWhQZnp6b3dRUStLWHNNVGl5ODdlMi9xZHJxVmg5K09zWkttRTNEYk5xMVJL?=
 =?utf-8?B?S3FNaFAvK2NxcnNId0lDRjdaNnB1SlREOWZVK0c5MlhNcEx0T3VuWGM4YUht?=
 =?utf-8?B?bXArZVFXL0FYN3pUTENRUWo2d2Uva0QwQ0gzQjR0WnZNYkNDL3JKNW1ndmJR?=
 =?utf-8?B?U0hPSlpJVDNIMEFPYUcvdVhaaklHVmhUMExsN1hsc2pZREszTzdVTTBaTjV3?=
 =?utf-8?B?SndrY3dxVENyQzRTa20vWElnT0gyakx4WHpiaFVkc0QrZ3BxVXlyMDd2WkJk?=
 =?utf-8?B?MmZGSS8xdk15QmlDdUZaYzVOejdPeitxWUwveWlkdVQ5eDkvdlVmMXQ1V0pp?=
 =?utf-8?B?RFcySUZOVmZ4UG4wOEljTGJiRnUyY3FtNTV5Y0pUdTJWNVFXNHZ5UmhqV3dG?=
 =?utf-8?B?UndKdXpBTFI2Nk1SQlQxK2orODVTWm5nVTdxdXhzaWVPa1dmQWh1ckcvSW1X?=
 =?utf-8?B?eHBYTEplbWF3clg4YjFUZjkwL2lHMDVTdDJ3aVU2MnNlVTFaOVV3bnVZcFpI?=
 =?utf-8?B?QzBXbExrTFh1Qy8ydm80aTNFSzBDZkVhdTU0RkZEVHhUVXBtazdhTlI5RUlS?=
 =?utf-8?B?L3RZcFZ1bXdwNkVGa0Facnc4a2doNURwR3RpL1dtOHhKa1JhM2dEU1J4Z24z?=
 =?utf-8?B?VGsrQllZL2JIRTlwaWorckp4ZzR3ejZRcUo0c01ERkxxMjdEUkxaS1Zob0V0?=
 =?utf-8?B?SjZnN2tnUUVXTnptMW5BTnQvY09mNTZtQ2t5Ti9QSm9RcWN3bEZNV0kzY3dO?=
 =?utf-8?B?eHVnMmtBN3ZqTnBwalFLTEZMYmNOU2xkeHRDT1gxQlltajc1bEFRMGoxOW5H?=
 =?utf-8?B?NU1raHgwYk5lRWttdC80MmIzQkpST2ZXazNLMEpTZXZHSWlzSjNyemVzVFpv?=
 =?utf-8?B?eUpURHA1akZtd3J6QTBzc3pWbk1VWFFQem04R1FvemVHVmJCZWFhOFdEV21t?=
 =?utf-8?B?akRSeXcrNVJtQWlZQ1k4K0xCS0VKQnVScE8xWmh5VTNXaWphaUwzVlJ3NnQ0?=
 =?utf-8?B?Zk14TkJGWUFIek1FeWQxUTFpQkt6Z2xOdjJHd1IxMlZsTGFyL29xQTh5RjZS?=
 =?utf-8?B?aHBDNGd6clcvRnArTVg5YlF0Z3RoNVRCNHVneFdZZGdFaXpNcTV3R2haTFBU?=
 =?utf-8?B?dS9EK1RseEtDS2JQbDJuNzNucFhrZkF4QVdyWnlEZzZhaU9IZENnNW9QMGJl?=
 =?utf-8?B?bklkK1V2ekQyaFR1MFM3akxwNnI2S3NhYktxTmV0OCthVUcwNUF5ZzdHaEFH?=
 =?utf-8?B?U3FReFRENEUwdTZZNzN3N0xNbUp2UEJKaHR2UHZBRjRTMzFpZzNJdlpqMURv?=
 =?utf-8?B?aU5wNjhLck5VYndvdSs2c1NSZE5uVTZKK1luekhrTk1BN3pLeC9aTFVpV0lN?=
 =?utf-8?B?OUlEaHFnSlhQRVd2ODFQMHVnZFg1bCt1WkRJWjRTTmtFNU96VmdYa1d2am5B?=
 =?utf-8?B?ZDhhWjA2bVI4L0xuYjN4RlloV1NjbzE5V0JIVmZwYThUS2swa3lpVXBqU1Zh?=
 =?utf-8?B?aW1IZUZ0NjBOS3pxemRVUDE1MUg3ZnlNeGQvNVdkc0MvZEI4RnZVWjRUSEdk?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cP/QcPPHoCZSAnkt0MCX6/6kUyGcdPpb2iuNvq1kPWnM6R55KNB4cfwUhhVNJYsXkrt9nxCVHuanMUVOuPHPSvjgErcNSxG0em4tkjvFMIEjB2m4s3eXGYG2yFWWex3UIepm/DW9x/tEzUwW/6cTx0pZoE7eRRikpRzWruaT2M6+eLGbMrJlVKB3SRBlJ9AiokDFjcgCH8+n6bNylbFy8nDYPqWD73s2MKFAmoHVHHT0mUXVmhG6ucrgHVWN02y+OXeM0LAs/nX26M7zqrr7Vx/I71fl7eOZzEv3AWg9AhvSghY+OxVhbm7i7bg9LNIYDO/i6so+LjMOtdqmERWtPBFZEn2P9iV3D5EZ1nck4bjzIqMu13TODJ7Y3eI7oQ0h6W7sZr7d0Ptkzdnzv19QbzSX8ZsYm5RFKeqQVNCD/X8Dq5YIyzN1wz4E93s4q8RYDUnh8EHhtPf9rqngvfoSu9tYFuQmXc0YFiDKJ97DOYIlXiy8L62oEFP6zMmUlB3Mq9WbAH1JebYZgYWbaQntmIu/pVXFswnplZ/awfkbCuTb/cYw9xXvOv8+yzYvp7+WHBTV+0Kp4VuwlEFDJIsWqkYbIvZqKiRWKhgIkrXj9/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e15675-a421-41bc-2a3d-08de004f5234
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 18:29:41.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKUnd6NG4uhCBg4qEeylg3faE8QTXw0kq6ryGFT+kHee6osXhFzJOsK5TvgSqH9WU3ug/c5AVqNKB8bE9KNfkDSpn1G2Algp53sA13pGZms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfXxDXzqPJdJdsg
 B4gwqrNhwnesJfC+FXvgGXeLyNdYZCPe3LaShXrkjNBtemUxefvTUMu6iYBi8ndqBZFbDbw7Ah5
 TA2wTROx9snVMNsr2Jqh+dFUzRW/erA39BL+4AA7L3cFaTeiYE6Qf38Lq7XyekRvRXeP5VHH/II
 tOTjkKpFDEhGN6l5Oam1zpXX35FavyourCVS8InFwz1AdAnRWIpzfYnRl+xd8FF5EnmwWIT5EBX
 0TbN8aWTNlLDu9xNU6fueSKsKTDjWnfREoc+BPOKtw5m/jt607HYlHwkS/DaIiyWcV+gKDsbSzt
 pTCwQ1PqMHteZyjCbSFoKP2RLGv9oaN7XLbufaaG6izewhXB8wW0iMLYqBYEup9s3HKTAn1gbNP
 XEY8DxeQXlP40+MedvXfp5wLtGy1eg==
X-Proofpoint-ORIG-GUID: pG2P7Zf0w67FT8OFdYN4If6R5i3RZO1m
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68dc21a2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=Z8hVs31sApu95MUa1EcA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: pG2P7Zf0w67FT8OFdYN4If6R5i3RZO1m
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 9/30/2025 2:20 PM, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 01:18:34PM -0400, Steven Sistare wrote:
>> On 9/30/2025 12:39 PM, Peter Xu wrote:
>>> On Mon, Sep 22, 2025 at 06:49:43AM -0700, Steve Sistare wrote:
>>>> Add the cpr-exec migration mode.  Usage:
>>>>     qemu-system-$arch -machine aux-ram-share=on ...
>>>>     migrate_set_parameter mode cpr-exec
>>>>     migrate_set_parameter cpr-exec-command \
>>>>       <arg1> <arg2> ... -incoming <uri-1> \
>>>>     migrate -d <uri-1>
>>>>
>>>> The migrate command stops the VM, saves state to uri-1,
>>>> directly exec's a new version of QEMU on the same host,
>>>> replacing the original process while retaining its PID, and
>>>> loads state from uri-1.  Guest RAM is preserved in place,
>>>> albeit with new virtual addresses.
>>>>
>>>> The new QEMU process is started by exec'ing the command
>>>> specified by the @cpr-exec-command parameter.  The first word of
>>>> the command is the binary, and the remaining words are its
>>>> arguments.  The command may be a direct invocation of new QEMU,
>>>> or may be a non-QEMU command that exec's the new QEMU binary.
>>>>
>>>> This mode creates a second migration channel that is not visible
>>>> to the user.  At the start of migration, old QEMU saves CPR state
>>>> to the second channel, and at the end of migration, it tells the
>>>> main loop to call cpr_exec.  New QEMU loads CPR state early, before
>>>> objects are created.
>>>>
>>>> Because old QEMU terminates when new QEMU starts, one cannot
>>>> stream data between the two, so uri-1 must be a type,
>>>> such as a file, that accepts all data before old QEMU exits.
>>>> Otherwise, old QEMU may quietly block writing to the channel.
>>>>
>>>> Memory-backend objects must have the share=on attribute, but
>>>> memory-backend-epc is not supported.  The VM must be started with
>>>> the '-machine aux-ram-share=on' option, which allows anonymous
>>>> memory to be transferred in place to the new process.  The memfds
>>>> are kept open across exec by clearing the close-on-exec flag, their
>>>> values are saved in CPR state, and they are mmap'd in new QEMU.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    qapi/migration.json       | 25 +++++++++++++-
>>>>    include/migration/cpr.h   |  1 +
>>>>    migration/cpr-exec.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>    migration/cpr.c           | 28 ++++++++++++++--
>>>>    migration/migration.c     | 10 +++++-
>>>>    migration/ram.c           |  1 +
>>>>    migration/vmstate-types.c |  8 +++++
>>>>    system/vl.c               |  4 ++-
>>>>    migration/trace-events    |  1 +
>>>>    9 files changed, 157 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 2be8fa1..be0f3fc 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -694,9 +694,32 @@
>>>>    #     until you issue the `migrate-incoming` command.
>>>>    #
>>>>    #     (since 10.0)
>>>> +#
>>>> +# @cpr-exec: The migrate command stops the VM, saves state to the
>>>> +#     migration channel, directly exec's a new version of QEMU on the
>>>> +#     same host, replacing the original process while retaining its
>>>> +#     PID, and loads state from the channel.  Guest RAM is preserved
>>>> +#     in place.  Devices and their pinned pages are also preserved for
>>>> +#     VFIO and IOMMUFD.
>>>> +#
>>>> +#     Old QEMU starts new QEMU by exec'ing the command specified by
>>>> +#     the @cpr-exec-command parameter.  The command may be a direct
>>>> +#     invocation of new QEMU, or may be a wrapper that exec's the new
>>>> +#     QEMU binary.
>>>> +#
>>>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>>>> +#     stream data between the two, so the channel must be a type,
>>>> +#     such as a file, that accepts all data before old QEMU exits.
>>>> +#     Otherwise, old QEMU may quietly block writing to the channel.
>>>> +#
>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>> +#     with the '-machine aux-ram-share=on' option.
>>>> +#
>>>> +#     (since 10.2)
>>>>    ##
>>>>    { 'enum': 'MigMode',
>>>> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>>>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>>>>    ##
>>>>    # @ZeroPageDetection:
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index b84389f..beed392 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -53,6 +53,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>>    QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>>> +void cpr_exec_init(void);
>>>>    QEMUFile *cpr_exec_output(Error **errp);
>>>>    QEMUFile *cpr_exec_input(Error **errp);
>>>>    void cpr_exec_persist_state(QEMUFile *f);
>>>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>>>> index 2c32e9c..8cf55a3 100644
>>>> --- a/migration/cpr-exec.c
>>>> +++ b/migration/cpr-exec.c
>>>> @@ -6,15 +6,21 @@
>>>>    #include "qemu/osdep.h"
>>>>    #include "qemu/cutils.h"
>>>> +#include "qemu/error-report.h"
>>>>    #include "qemu/memfd.h"
>>>>    #include "qapi/error.h"
>>>> +#include "qapi/type-helpers.h"
>>>>    #include "io/channel-file.h"
>>>>    #include "io/channel-socket.h"
>>>> +#include "block/block-global-state.h"
>>>> +#include "qemu/main-loop.h"
>>>>    #include "migration/cpr.h"
>>>>    #include "migration/qemu-file.h"
>>>> +#include "migration/migration.h"
>>>>    #include "migration/misc.h"
>>>>    #include "migration/vmstate.h"
>>>>    #include "system/runstate.h"
>>>> +#include "trace.h"
>>>>    #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>>>> @@ -92,3 +98,81 @@ QEMUFile *cpr_exec_input(Error **errp)
>>>>        lseek(mfd, 0, SEEK_SET);
>>>>        return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>>>    }
>>>> +
>>>> +static bool preserve_fd(int fd)
>>>> +{
>>>> +    qemu_clear_cloexec(fd);
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static bool unpreserve_fd(int fd)
>>>> +{
>>>> +    qemu_set_cloexec(fd);
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static void cpr_exec_cb(void *opaque)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
>>>> +    Error *err = NULL;
>>>> +
>>>> +    /*
>>>> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
>>>> +     * earlier because they should not persist across miscellaneous fork and
>>>> +     * exec calls that are performed during normal operation.
>>>> +     */
>>>> +    cpr_walk_fd(preserve_fd);
>>>> +
>>>> +    trace_cpr_exec();
>>>> +    execvp(argv[0], argv);
>>>> +
>>>> +    /*
>>>> +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
>>>> +     * or the system is very short on resources.
>>>> +     */
>>>> +    g_strfreev(argv);
>>>> +    cpr_walk_fd(unpreserve_fd);
>>>> +
>>>> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
>>>> +    error_report_err(error_copy(err));
>>>> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>>>
>>> I believe this is the only place we can have the state machine from
>>> COMPLETED->FAILED.  It's pretty hacky.  Maybe add a quick comment?
>>
>> OK.
>>>> +    migrate_set_error(s, err);
>>>> +
>>>> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
>>>> +
>>>> +    err = NULL;
>>>> +    if (!migration_block_activate(&err)) {
>>>> +        /* error was already reported */
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (runstate_is_live(s->vm_old_state)) {
>>>> +        vm_start();
>>>> +    }
>>>
>>> We have rollback logic in migration_iteration_finish().  Make a small
>>> helper and reuse the code?
>> Hmm.  There is some overlap, but also subtle differences.  For so littlecode, it does not feel worth any risk of regression (or worth the time to
>> test and verify all conditions).
> 
> We have a fix not yet landed but should likely land soon one way or
> another:
> 
> https://lore.kernel.org/all/20250915115918.3520735-2-jmarcin@redhat.com/
> 
> That should close one gap.
> 
> There's definitely reasons on sharing code, e.g. when we fix the path we
> fix all users, not one.  We also don't make mistake in one path but not in
> the other.  One solid example is, I feel like err is leaked above..
> 
> I'm fine if you prefer landing this first, but I'll still suggest a cleanup
> on top after above patch lands.

OK, let's do that.

>>>> +}
>>>> +
>>>> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>>>> +                             Error **errp)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +
>>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>>> +        QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
>>>> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
>>>> +        qemu_bh_schedule(cpr_exec_bh);
>>>> +        qemu_notify_event();
>>>> +
>>>
>>> Newline can be dropped.
>> OK.
>>
>>>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>>>> +        cpr_exec_unpersist_state();
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void cpr_exec_init(void)
>>>> +{
>>>> +    static NotifierWithReturn exec_notifier;
>>>> +
>>>> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
>>>> +                                MIG_MODE_CPR_EXEC);
>>>> +}
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index d3e370e..eea3773 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -185,6 +185,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>>        if (mode == MIG_MODE_CPR_TRANSFER) {
>>>>            g_assert(channel);
>>>>            f = cpr_transfer_output(channel, errp);
>>>> +    } else if (mode == MIG_MODE_CPR_EXEC) {
>>>> +        f = cpr_exec_output(errp);
>>>>        } else {
>>>>            return 0;
>>>>        }
>>>> @@ -202,6 +204,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>>            return ret;
>>>>        }
>>>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>>>> +        cpr_exec_persist_state(f);
>>>> +    }
>>>> +
>>>>        /*
>>>>         * Close the socket only partially so we can later detect when the other
>>>>         * end closes by getting a HUP event.
>>>> @@ -213,6 +219,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>>        return 0;
>>>>    }
>>>> +static bool unpreserve_fd(int fd)
>>>> +{
>>>> +    qemu_set_cloexec(fd);
>>>> +    return true;
>>>> +}
>>>
>>> Is this function defined twice?
>>
>> Yes, since it is tiny.  I judged that defining this small helper twice, near each
>> of its call sites, was better for the reader.
> 
> I still think we should avoid doing that.
> 
> Btw, I even think this helper should be removed on both places because
> they're almost only used for a cpr_walk_fd() context, so instead looks like
> we need cpr_unpreserve_fds(), which does:
> 
>          cpr_walk_fd(unpreserve_fd);
> 
> Then it can be defined in cpr.c once and export it in cpr.h.  Would that be
> better?

OK, I'll do that.

- Steve


