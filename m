Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96849C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPpoJ-0006Mg-E3; Thu, 12 Jun 2025 17:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uPpoG-0006La-UO
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:50:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uPpoE-0008P5-EX
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:50:08 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJhbh8003839;
 Thu, 12 Jun 2025 21:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=lUhOhbRX9aWdBqzM1Ox8XiMaXOBjNyNAMY+BLIhZXr0=; b=
 axOlnoEcniXs21e22zusJJ2k/wTOEAyvW316wdjeauriQvuK9XNAYVlwsY/Igx3E
 +W0CCbUJEdMBzCo5XAAfXuIo3TBZgi/HSpNvi9ISHgLPon2TdcSZ97JPFhIlb9+w
 WLVHQapSHfba+lBQJt4IC9qDCAuza1iccVjKV7Qw4jy3f5g12hzkbuxFiaC8uEdu
 yR/bJJTXzc4noya7qlwmdZyJEDHdZoaI+KhlKRa+RcqvM/9KOgvPRY4D6RUPqRXX
 rF43kU8mrrF6WiNoBnuTM4ma03zsFvMzAfQ2zEdmThrCka3s8lsVaxdh7jC+HRN8
 CVlKc2f6pm/GIZ/gbfwpZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbejksn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 21:49:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55CKEOle031992; Thu, 12 Jun 2025 21:49:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvc51tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 21:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2nT8/wnIf32s7D6Xjx5sJ7+Pwe7ufjdENov3NrTEUk3kMBO0gasxAyyJhEXsNMCSWg3L5RY12QwVicUpgilzOlxB7Xk2cKi7dXguEWaq1qXCiN2qFnyXQyXCO7sU+c4Lgv3WK8Z7ZN5QkCaYXPcMfAvKZfRBEJGOXuApHKwQz7BNXP1jBMIBhIskyp1s5tHTC28c8a82yTnJTU+wMoLnla/1lyARUw1wadnx7NZTsbOr1YRNVIDTsAGBGAO9b63VNTJ9br9Be0p/ZDMcUzhHUEokedv1vcnH7rN3clxVskOcYA8spreBJ2EmR/jgg9E21r48iG2Jfg/4/Zkq/JCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUhOhbRX9aWdBqzM1Ox8XiMaXOBjNyNAMY+BLIhZXr0=;
 b=hYC6JUU47CqlCVDcquG7duJPNEiw/QQOFP+tYVX66QPVts76a+s54TQBCEcRmAdAcokOflAh1DCXQMyabKcNYDLvIW0AB/6yI4PY2m0V6TIJgZavsQFWsRJwogvAsEYcPeuj/7HN5vFd0tgi9FkHjPmIsBsDWUQc0OfBX4V2jfTKrR/esIMpPaMLbFgTZMALBv9vj9bWu8FNwyaR9W4PXYRyKY/aYzvcgKPWTrutsfVJz0EDceYZenJZ2oBxHOrSMy+eWrAgtV//nl34exj/SDT1Oy7H84D/CwPH6CKbkxNWGVigifZvA73JEigzawo59LqRCIpiGYIjsyzxYyZypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUhOhbRX9aWdBqzM1Ox8XiMaXOBjNyNAMY+BLIhZXr0=;
 b=aU6UpN/oXKoMP2wUkdv5ALeN8j4zDow0efdlfx7H9k9jT9LkrvFpDG7eqK75BTwccscpV+Ph0V3ft+bEKjN5GNYu/5RITlD+R0k2qCDqoFJvePIYZlP3Xn1BFZ94D05KtNJv0S9fGK5VgMcTdbCQUElbGumxDVKhKzsQF5gk3Dc=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 21:49:29 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 21:49:29 +0000
Message-ID: <efb04388-d921-45a8-8a54-36b5bcc701e7@oracle.com>
Date: Thu, 12 Jun 2025 17:49:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] memory: Adjust event ranges to fit within
 notifier boundaries
To: Vasant Hegde <vasant.hegde@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, clement.mathieu--drif@eviden.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
 <883bdbc2-e6bc-4bfc-9dbf-effcce6197a0@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <883bdbc2-e6bc-4bfc-9dbf-effcce6197a0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:208:32a::6) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb3032a-da6b-4684-9da2-08dda9fb01f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUs2SjVoeGN0eTJuZ2lRb2tLWFljbTlBTnNEcGw2WnM3M0tiVUkrQXZpVDNl?=
 =?utf-8?B?Wk4zNCtDeFEyR050VmV0MG5IVmdUQzRnY1VjemVmRlJ2YXhuNDVPZ3l6a28r?=
 =?utf-8?B?dE1LYTl5NE04ZEZmcVVsNURWaVROTTJkV1J4cTl6K3JMZUhEOE9uM210YXMx?=
 =?utf-8?B?WGh4Z3QrT3c1RGJNRUZ2STNidDN6UzBCVkhUODZEcVNqS2JFWVZXbjA4NE9K?=
 =?utf-8?B?WkJQSHN0dWpwZ1h5eWtvZ0ROUVJNM01pUnNjcnhCMGs3bDhLbXd2ekEvVy9E?=
 =?utf-8?B?dXI3MW1VbGFXSFliODRqNDFCMm9JWnBsdnh1anRram9NbnFTZlZCT1MxWjVV?=
 =?utf-8?B?OXVXRkhyanE5UVcySFpGK3U3UmJaYncvOW83VEdoeW9ZRkQ1RDk5NzkrUHFz?=
 =?utf-8?B?enllR29jeHJ0ZDVlWFRxa3VOekVhWkthaTk1QzhqRFJMT2owRkg1YjRjVjJZ?=
 =?utf-8?B?NGg3cHhXTHAwUGl3cXYzNmZZbDVvQ2d1RUpxYWNHNXhnRllFWG5yVFVRS0ZY?=
 =?utf-8?B?NmR3ZDdEYXprUmJ6amJ1aFRua0JZWnZNWEhrelpQdDRMZGM5d2d4TzdnbTNy?=
 =?utf-8?B?YWRmOERFS3U2eFd5ZDQ4TXVxWUlyVWY1aElhMDFIQnNyVmV5NVA3NHgwcWFl?=
 =?utf-8?B?S2FOeVFWKzY3UFVoYTVWdXNiNzZpRXdRZ1BVRTd2QkZBdlIxSkllNDNjZm5F?=
 =?utf-8?B?MTU1Z1BEMzZ6cC9MWXJRZEV6UGRKM3dBcmJyU3JkY1had2JnbGJnd1hnaWNJ?=
 =?utf-8?B?ZUtxVGNLdVZ2K09melJjRGNzV1RsUk1PQXNTQzFuck1VVmpjak1ldlE1aWlt?=
 =?utf-8?B?cUx1ZVh0WEdWLzlwRTZHRndFY1dJZEdpVTFpMzNwbktZUjJ3YnB5V2dRYkZM?=
 =?utf-8?B?YjRic0tjNEx3M0xzN24xU042WVNUQUptM1h1RFNMSm9ZMkpDTjVlNTJJRkI5?=
 =?utf-8?B?d044R3lTbXRkUytIc0drTkZDcEdtM1Z1R05zeUZ0ZklDZm4reVlBZlNnbmY1?=
 =?utf-8?B?eUV2RW5UN1pCY2NUTXk3eE85S2NzbjUrUnloMVFPcG0wZklVb1BhTjZCbDky?=
 =?utf-8?B?a1hoVWgwWU5Ma3RvbnlQS283bkVNWDBKeTZOSDMwKzdsTnpwcW02OHFUVW9T?=
 =?utf-8?B?ZGJwOWJhNWo0MUVSQ2prVXpHWE4yWmo5MjhSRi9QcEI0WEFzT3NlUWdEUWZ3?=
 =?utf-8?B?cWRkTDQxcVE0ZmJ3NDBSOE8ra0doMGp1TVNwQ3dvNHloS2d2a2piYzBZMDBo?=
 =?utf-8?B?TmRWS0VFSmpUYy83L3IyckdoTVEzYTFuUGJkVDFkSnNxc1liQUhTWTZZbVhM?=
 =?utf-8?B?UHd1VU45S3gwa3ZyZTMyRUEzRnZaV3pSZ0hBUzlaMFh1dVUxczZiajhRZUY1?=
 =?utf-8?B?d1BIVFFGNDZ1aDVSa2Q5WkRtWG10c2wxODltOWErNkJtMHYyODVIMVplQ0lZ?=
 =?utf-8?B?OU5oSEx2UGcvb3NjeDJxclQ2RDl0V1V4cXZnUVlDYUdJa3BqMm1WZG5tbXNX?=
 =?utf-8?B?S1Y4SUpKaEtNdUpidzd0Nmt0elk5aG02eWxxS1RZMHhRbmw0MWZET2RReGdv?=
 =?utf-8?B?OEJMcHNrQnQ0ZHRLV0tWTElRZ1FEcVRIUk9rNjVnQ1E4YVVoQVVPTGxVR2tO?=
 =?utf-8?B?bW5EaC9nZC9SS2ZXVHFQc3pSSFdGMkwzOWttSzdrSk51MGIzOGNZdDVNMWhS?=
 =?utf-8?B?MXJYNjdJbEdxYTZodGtOQjhqa3FGcTh2UmlLdzZaamxkUmtkRWJtMmpRZm9n?=
 =?utf-8?B?VWlTb1BFdTJPdzF3anc4RlJZRFJQUjNOR2V2OEdLc05LOXpsR3lzc2R3L2Jq?=
 =?utf-8?B?eFphbzZVRjJQM200amw5clJtb1F6dHBlbnQ1T0FYR2YvSEJuOG1SajZQNnBa?=
 =?utf-8?B?N0VuajQ0WStWaVZMbU40S1NqMEVqY2JQWVFnRnFIZ0d1N3h1WXdLZW9hZVFy?=
 =?utf-8?Q?KD8cMm/LHe8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtvQmViMzhWZ2d5akE2QkxRVU9raVpmaE5ka2gwZHFDc1h2aExMODFwNTBk?=
 =?utf-8?B?ZlA5MFZHQkdUQlNtRjhEc3ZtRU9HdU1FdHNLRHJiUEZ2dHk2Sm5FbjRnYWND?=
 =?utf-8?B?d1FlRUhuQXRnc0YxSG5kZ2crVXZrUW1OQ1lxbjAyNjhvbi9Pb0J6enNEY0Q4?=
 =?utf-8?B?aVBwQXBHSERma2Q0TnJGWHhSUEtBaGRzM3NRakdSWGhXaVNJZXIvK2RxcE5y?=
 =?utf-8?B?RzNUdTJiTUZXWXNBVVR3TlBsUXZSSXJvYW54SjdIbnh1MWMvQ3pjU0JmOWR1?=
 =?utf-8?B?QU5KN05pb3ZWNWQzRGhHU0dndDRFMGFiclVDMmZNVmUrdHFocDJoRkUvaTFj?=
 =?utf-8?B?Q2JkMFFVdEhYR2hQeUFLWHBxY3Q4S0pjb2tCc3ErWWEweUJFYWphTkNKWWt4?=
 =?utf-8?B?a0hhdDgwZlJkbzlCb3hVOVNLb09NSGdYaFg3MzcydThDYXUvbmtiZjdUSHps?=
 =?utf-8?B?NjlSd09xalJISWtQeGFTK0Fmek95RE51NmRIMmw1NG0yamx4ZGsvWkJOd0VJ?=
 =?utf-8?B?dGFrclpxSDg1WGlGWFhmZVFVd05PU2ZsblhyWTJIS1YrMURCaGsxNjJ6bTNz?=
 =?utf-8?B?SlBXNXordnNsZ245NDM1L3l5Mjl1NUVpaFdHWTBhbjhsREVNQlo5eXFmU3lZ?=
 =?utf-8?B?QWxJQk5nbFluVmxoMWhNZkVSWEc4a3NQYTQrN24yWUVoWFNuTG9kc2swZThK?=
 =?utf-8?B?KzcyM0FackRFMUFEN2N6d0JaZVFIUnpkOGcva2RQalpHN25LbGMwRzF3dEJK?=
 =?utf-8?B?c3VIL1M1REhMRXlDN0pyN1h3cVlqb2g3bVRPOWpENmd4NW5qK2xyRVdYK3Jr?=
 =?utf-8?B?QXhsZ01BUTJBR28raWFmY2oxVXRPUGszM0R5dkxNY1FVdnFlNEhzOStiWDhK?=
 =?utf-8?B?N1BxUXZXZGZQVnlyTGRPMWJiVEV1MTR5d1RQSTAvSGNpNk1ObjVDMzR4bHM5?=
 =?utf-8?B?b2wxM05iZGFYRnp5bzlzbTkzRkVTcGVGa2U1SnNrSTFNSDJyWHJjbnRINHg5?=
 =?utf-8?B?cXZ3RXN0c3JWa2t3aG53bFpNZnN3YTVlQnUvT2dRQmZNb0hvcVZDZDdKc01H?=
 =?utf-8?B?YUl0RnA0cTNQMW41UjJaeU41M1JQajhyUHFjR1d1M3pDTzdrU2JIR213ZTVo?=
 =?utf-8?B?SThuZ1ZyL3F1bmxzMmQrS0hKdE1KSDVPeXpLc3lmeXowcXhOVXNWYmE3SXpw?=
 =?utf-8?B?a2Nma1NJeDd5UzNHeGh4d2ZsaUcyOFN6MlBtM0ZTQUh0bWR6V25lQzhIdFpP?=
 =?utf-8?B?TDJ1ZmtFSWJMU3hSTG1UbTdTaU44Tk1GRDU3ckhMVWN4bXVQdGdkaXJSS3F4?=
 =?utf-8?B?bXA3QkJsYnJMVUFRaDhDc0piemdVOW5wWndxSGRqVWQ3QWZmY2taL0R3OCtp?=
 =?utf-8?B?NzZneGFueEpHM2dCSkVibGtKWDQwZURqY3ZQREhRZnpKWjJ1SEp0YVBHcWFa?=
 =?utf-8?B?aUltRVFqWGRycDZKWExQL3JJK1d3SithNS83dTZ4cE5aMVJwMFdTYlhvd290?=
 =?utf-8?B?N1hYYkJyRUtpcWFRZE5WYlhQMGF1TjMreDU5b0pzTmdwbWtEWTJmeXJNR3Ay?=
 =?utf-8?B?ZFJ2THZyU0xEYXdPSTNtSWtjU1YzK256Y0VsNUZDaUV4ZGM1Mzh5OVJrT25v?=
 =?utf-8?B?VlFLZlNHdzhhaVg3eHRoUldWRzdzNlVPYUppZDBqa1VINUtpeVZETlZvakJT?=
 =?utf-8?B?RTdnR043djVubCtvSDZIanVvMG9rYUNIWlY4alczYzJmWENSVkZCcnZNdzll?=
 =?utf-8?B?a0R6d29FblJHMEdvTS80UkVRN1RHRVQrWWhTZ2pUTkloRnEyVkdPekRhV2I0?=
 =?utf-8?B?VGNGVXJzS2FzdnlwUnozeGt2ZjFacmx4MGd5K1JaelRGaXovOUszUmVQTU92?=
 =?utf-8?B?cWpNc05pbUFycUxvZlBqc2ZyUDB1YmY1eTZZRHFobGhEVU40MmdVVUZsMGZx?=
 =?utf-8?B?Mk1uYlBYMEJ3QW5tYmxtSnVlNlR5SktKSzZRUFo4MWFRUVhaS1YwR2dnQVRz?=
 =?utf-8?B?RStQR1I3MDBlQlprZDVTSnZCUWZjT1VYUUM5NVhWY1pBWjZPc3dDdlBnalNm?=
 =?utf-8?B?VVZQY3pCMUR1bmZ5Z2hoQ1ZDRlI2T0dLZXZLMXNzOGxVVkc5TzV3NHVaYzRI?=
 =?utf-8?B?NDkvcjZZZ2wwbm1Qc09xS0xWZTlxeFNscHU3NG1tdU1DamltWUdjRXVIRnQw?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FNafjwDZxRg8wlDrdLrQHSV0NVvhkl0PNREDBgjTQVZB95CHYQmmohDCknnLClv8RLDa4tWLF6K3ZUsBQyI7Ir7fyXB8zgOqp2x1EIK/cXfzf4szTNXIrRN//qe8uuiJXnK1RxAnj219EG1gH4/eI0I+jarHsHioLA/V6DF0lSD8LkCO2/8F28odJ8vK039Wrvk2JT+eU8wMiUeaKPYB1zRScnSPB7fhw/77ghCFeI1bE6CGvXibjQTCsQU7BuvnmdKSSfqrmltRydHKEQKoO5UoCs+ewarpZ2HfDTg/yc8Oz/SM9OlPIPK05NetnengFUid46D/xGMCplx1Q+mtZ6ubYqdjJDFPd8ZF4lrixIuGtTcukSuE4GL4/YRgQIb4uSxYZwEOgGMvFgHpMBfaf+sNNciVAKFKpQhga9GsBHePMI2zo+KagRD7QXqPXnDkXnkzk8D3tPbcdWXadkn4Ug9KwLg2IGCuxEqv0i3WcNXXRT2/wL44gH92H/QB/UQreccOXNfgCxIh6ooAJ0czjEI+qT2RPCFj81Dd8If0gushj6SMghZBSvKzUkOtG83koHMUxPYFIepAHZJLoNoYthIxlLlT9JDQas71G0DI/rw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb3032a-da6b-4684-9da2-08dda9fb01f0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 21:49:29.3880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPP9xDRolbOSjsNy966qV9EqWe1u1L31YVce3CVPugudkJF2vbQiez4b0oapFVFDEdVIBRfms/KDHrvt9Dlrz+UNhcRbNTz1dRvAqh+D+c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120167
X-Proofpoint-GUID: sbtiMu7wYQ6XcrokEsJsqATwlv3EsG1E
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684b4b84 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9osz3VO_oq6eEgScvYgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sbtiMu7wYQ6XcrokEsJsqATwlv3EsG1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDE2NyBTYWx0ZWRfXySMs8ZueqpI9
 Vl0ky1qocItGhEY8WomKanUtCV8cTCHLpE5MtEP5iqyKbPPNLUwluieIiIfdTbpNKPpM8+TZgPd
 sfkyMLERqpYeQzNZtql5LmS9o9MHBwt4KcYJyLxSitLjmIRIs7ABwuYPCGQeNYIr3FPc+VnIc2U
 +HthAjYQ4EbYLn79+ND6cT/SK2EVtu7aXufRyOZF1n/xBJ48BWDGlxWzc8ZlpF7L4DzWAbF5Ddh
 nb2dUasF+7bv2v1z1NW0ZC41IMmxHXtTdhQyIkyLupyhj9bNGo4bc1E61db9ECl4LJfPsoy+Ros
 xbimgDGkLxesa3XPKw6VNHNwEXhTvZMtBEAI8sQvz0ymx0j9sz50lYEnqTHrwLrwVGvhqAr5O8D
 yBFVZWUMODr4dMK4eCV4HcgbvdP2XsBkw8d/0lqAqVwiNeqNNjZoYr6EsEaoW511lNm6bdQT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/12/25 2:54 AM, Vasant Hegde wrote:
> Alejandro,
> 
> 
> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
>> Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
>> valid and required operation by vIOMMU implementations. However, such
>> invalidations currently trigger an assertion unless they originate from
>> device IOTLB invalidations.
>>
>> Although in recent Linux guests this case is not exercised by the VTD
>> implementation due to various optimizations, the assertion will be hit
>> by upcoming AMD vIOMMU changes to support DMA address translation. More
>> specifically, when running a Linux guest with VFIO passthrough device,
>> and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
>> Remove redundant domain flush from attach_device()").
> 
> FYI. Its easy to send invalidate all without above commit (as it does it in
> every attach), there are other paths where kernel will still send invalidate
> all.. Like detaching/attaching device, etc.
> 

ACK, thank you for the comment/confirmation. I just mentioned an easily 
reproducible case where it causes a crash during guest boot with just 
passing a VF to the guest in the QEMU cmdline, not hoptplug or other 
more complex scenarios required. Your argument above is part of why I 
chose to remove the assertion completely instead of special casing and 
breaking down this range on the amd_iommu.c code handling the invalidation.

Thank you,
Alejandro

> 
> -Vasant
> 
> 
> 
>>
>> Remove the assertion altogether and adjust the range to ensure it does
>> not cross notifier boundaries.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   system/memory.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 71434e7ad02c..7ad2fc098341 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2021,13 +2021,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>>           return;
>>       }
>>   
>> -    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
>> -        /* Crop (iova, addr_mask) to range */
>> -        tmp.iova = MAX(tmp.iova, notifier->start);
>> -        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
>> -    } else {
>> -        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
>> -    }
>> +    /* Crop (iova, addr_mask) to range */
>> +    tmp.iova = MAX(tmp.iova, notifier->start);
>> +    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
>>   
>>       if (event->type & notifier->notifier_flags) {
>>           notifier->notify(notifier, &tmp);
> 


