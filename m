Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8BBC02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKc3-0007Nm-Ra; Tue, 04 Feb 2025 10:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfKc1-0007NX-P6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:13:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfKbw-00070q-Oz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:13:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DRiMI027951;
 Tue, 4 Feb 2025 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=I+S3rHwX+D1fZIUmpDJveH1HvFWPlLGJvOwmgwT8UuI=; b=
 Wefxajydk+qLk+aQHzOg4zgGxci01jWEDXlieoKjAy/42i0R/Zmg+6KMbAZJe5Te
 jt+WWXT9EXhgLbHNaCbKEWZgW9OjmjsUnzJoXNQWuz8zkHdwCTVMYM4LaXze0UaV
 HNJdImfAP8607h7trXkRJFqby+larnk4Ywamf0KxKCxBKkHZHP0tEtKCyQgA0PKJ
 Tl9CLiqwgNjy4iE/EvI2Yf7vEDOmTq1Lp/mttK+0XJRwAnz6NpKcpKcL3XTLCp2l
 SuudcX5O841aKnMksaVjcDAA3HuarWXXoy7KaPv3KkWhnGDohv5kub4WgMRsAJ2W
 I2uRg7FDwt6FuL6uaCA+cA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtw03q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 15:13:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514Df3t5037964; Tue, 4 Feb 2025 15:13:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8gh2k2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 15:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy88T84xDGmFpmpZZhkuNSMELfMHE4XinLpYx9cALBfEDdYwsyONd4D0dLFG4sqj+mPY8Zur+r3YpOfo+R00IhIzM3DdF937yExsFxFXdrBCKhY1thyhRGTawpOHQCF4IkmGPDcziRIxPBfA12WbLgM0DJzrfV4e9DUmnqJwlD1w0DYG2DGYEI72mF1YFE9ZsdFgnEdH/aa7SCOyW3VVoRypeK4qINfvwJZ8gnxUm0UYvJvT0V4TAJUTQwEPl192ExGVyJq16TSpcN7L6q9KLNKl24xn9U6dWLxL2F2L2cjfXOSM+s22qMGpptJk8Cbk8acGAQ3iOwUi9mhSHqYQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+S3rHwX+D1fZIUmpDJveH1HvFWPlLGJvOwmgwT8UuI=;
 b=bdLOok9O3y7nhTL+FVnkTBDAW7Hkwc9kHwH/ikfz2ogK/E00xLAH+VKZKABxBX+qkCYVu+va5Mw7v4QCunkFKmKgnWKhjmRx093eTgS7g4s3Eq9vgMU5Nvb/ZmYtCOxZ2bog3oYL5l24CKE29JbtJiJU0fCnwbZt1+XrLwkMXuZUi28FNeZXMfTdwf1oMsUKxmv6E6iXpxSnR09dXggnLn3nfyBtn1iWXw3+BOg7z2QNC3WaadFDLXN69ATJIoLLn7XBP+TXcE6Vzg3JTYRALEvupX4k+N72B2gvuRw2haXC1n24XL/+1bDcXwkNdD0BumYy59oBkNuhjrQK/fUC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+S3rHwX+D1fZIUmpDJveH1HvFWPlLGJvOwmgwT8UuI=;
 b=n0MdUeRr5nJHOrbkBmrGxu8NjLm6BI9su9ehAbSUg3HnzXOVS19jtcKt88WUu8JnyMm5nS1slQ8XCMgR0KjoOGxQptmDyNZox5he6qahzRcLJbzKdM0PW60NnX80c4UFUN0rVn4bRoRAJxsghGwV3MuC3rOjac+bcO6e4xyTB/4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 15:13:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 15:13:03 +0000
Message-ID: <e311dddc-b321-4126-8968-f032b6219804@oracle.com>
Date: Tue, 4 Feb 2025 10:12:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250204082859.846886-1-clg@redhat.com>
 <71b208c1-c61a-4498-8200-0850548f4d74@redhat.com>
 <a72c6e98-38be-4af6-bc21-43071d8e98dc@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <a72c6e98-38be-4af6-bc21-43071d8e98dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 6381e505-60da-4d03-219b-08dd452e6bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGVXWmY1Y1gxZWNtbFNUNzlaMit3ZUQvUVVUQjBjdkdEL3lSVVVHQ3doVlUy?=
 =?utf-8?B?WHc3OVhod0ZoZ2V2VXNIUjRkRzBmb0hxWVpxNUNGTE5kOHJMTFhIYzdrQnNu?=
 =?utf-8?B?N2c5NmQ3TkF6NEdvaFNSOERhVkIrSHhvdnF4RStHSEtLMDIyamFQaTBrcFFH?=
 =?utf-8?B?N3FDaGlCTk9BQ0FrZ2cyZ3hkelUrVStwMkhpSFF5S0hHcytXT0Z4YXAyRnYw?=
 =?utf-8?B?dnhpenRQeWpON3BVTUlCQk0rTDZtUyt3RGVLdXJ0QlVVNXd4WnNYS0N6RDVS?=
 =?utf-8?B?bGhPUlhFVXlHY3o2RWlBWFozOHNMN1VNc0Ewc2MrOVdRQWlLRlkwdkVsdmdW?=
 =?utf-8?B?WkI4ZDNGbTcyQmdMRkhOMWVwN2F2ZW1iK2NFNjFEdmZYY0dONGNjRXJBZVRq?=
 =?utf-8?B?Q2J3cDlaRE0xZ2svZFByQ2szSVBKTVlZZUcwb2pJU3lMYWJUZjhqZTErMmkz?=
 =?utf-8?B?dy9ST0loMStWRDJ6NEYrOVNVWnlZQU1NK0FtaDdYOFFjK1pmR04wVERNb0lj?=
 =?utf-8?B?a21IWDZzaHpZZ3l1d1NHTS9RQ0dLZHVRaXAzRTEyYXdhYXJlNThYdnN2ekFC?=
 =?utf-8?B?VHZ3YU1aMmV2N1kyaEQ5NlY0VDQyUVdZRXdWbFhMQ3VCQkN3am42T3MvSlVz?=
 =?utf-8?B?MWhvWkcwNURTekZQYm13dDdqdzJETDVuWjh6VnVuWGp1alp0d0hYOUtGU1lZ?=
 =?utf-8?B?MXRuZG9vZnFsb3ltYUlqZlJKbHlsUWZYT3RsL01qcUUwczlzWnQ5c1RVcjlv?=
 =?utf-8?B?ZmhqMWRZSk9EUEw4Z2RJSStmeHp2dzZZQitHd0pXOFNWSjR1amtIQWVPSVFP?=
 =?utf-8?B?VmhLMEhnTGVNRHJ6RG9CVC9pa0Fta0Y3RG1HR2krTUFQSFNJcFYvazVQTERq?=
 =?utf-8?B?YlUyaTVDMkh0KzNPdWpuVE1paGlkT0ZHa05tZUxrbHBUUU9zbDhHdXBGdG01?=
 =?utf-8?B?dVM1WXM3alZaakRsMjdJMjZVa2V2YVJvd295MkhWVmxGUjhHVklKME1LMUVv?=
 =?utf-8?B?YUdrNzlWVVliNGV2MEVzWkhhSHQyQWtnS3VpcHB6eXE4REtZOVZVVkJ2aklO?=
 =?utf-8?B?S0hsMllsRHpSbEFlWFpmbSsvb2d2Um9QOEhEUTloQm5zT3ZudldQVXlTWEZQ?=
 =?utf-8?B?UTlHVHB5cTd5SVVXT05EOTVIbXQwOGlqalNqa2Z3NWdyWlRLL1JBWEFSY0FK?=
 =?utf-8?B?bUExVlZydzg5QVR6K1k0NVJEbFltMGt6NWtydGFIOXNZQjIzZ0RIeTZnYjFF?=
 =?utf-8?B?VFZLM2o4V2JOK01ERUE1Si9PSGVaaWVyVDVKcHQ0QU5QVVNheU43NVF6MzVu?=
 =?utf-8?B?c1JmRjhLWklYMUJaZ3pjczhWeVREL3lXM0thWmFleTlNR3FFMzRZMll3UTF4?=
 =?utf-8?B?UFBTNElrRjVlRDdqRGREQ1hWbDhUQndVblc4ZlJoTVhMd1lZakgzUEJPTDcx?=
 =?utf-8?B?alUyZjR0SlJWNXY3TWpTNjRVeHlYSTBOUGlOMExsWG5aOWxIMkxOS1dleUV6?=
 =?utf-8?B?K3FNY1ZTc2duM0duNm1iMzZVOUdxamFtdUJuYmhSV3dZandhZktnblJBQ0ww?=
 =?utf-8?B?NGZ6NDFPS0czRExWTmNjS0l6MmRuNzBFdS9EWXdyL2JRRmhaVTUvWjBFc2I2?=
 =?utf-8?B?TlI0SVlPdk8vTDN1a2tCa01ka25NRWVLdTJWN3Vqc2JqQjZoOW9UdWp5bWJW?=
 =?utf-8?B?enZrTzFONExPbGtnMUxBVlRyaW5NbytXTUdVNFduUFJZN0svVUNmNjNoTUpF?=
 =?utf-8?B?UThvbk8xZ3JESEViTkZrbGtCT25lcU5DVHNENnNhUStmcDRDSDJ4Qmp5T2Zl?=
 =?utf-8?B?QnorTWtSdjJVNThQMEJmUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHU5S09vaGYwRDFodmc2NFRZQnVJUk80S2RJbm5DTS9kR3o4WXBscGNGKzdx?=
 =?utf-8?B?eWhOeFBXTThwOTcrTWw4ck51YUNsRHJvOHVETGk4b3FxZHZIajFsSllpZVQz?=
 =?utf-8?B?MEdhczNwRU5yYkhuQTBHengzRHNHM1F1RFZjclFYOXRnbnVtZXpCSmRScjBh?=
 =?utf-8?B?b1BSY2J2V2hWYTZzb2w1QXkyUkx4WG4vS2RTNkFnR0FYV1QvRG5NSXNCNFBT?=
 =?utf-8?B?bkh4K2JHZjdnZjBMUUFTYlFBMTd3WkZlZlRPWnMreDdUd0w3N09JQjhHY2h1?=
 =?utf-8?B?UkxBR3U2bWx2VjlYWFoyWWhzOFRQVjdEeXYyYzhrek0raEU0WFE2Z3l6dFFD?=
 =?utf-8?B?TjVQYStPTW5XZTRPY0YyUm5EV0J5Mi85Z1pJTkVtWDZmK0pWdStBZlRPaU93?=
 =?utf-8?B?SExzMEV3UDQ2THpJU2E3d0RLZ0ttR3VRcW5jYzNJTEVtMytaWjE2Ykw1Z0pY?=
 =?utf-8?B?MURsUGRPSVA5clc0WHNSWm4wMTlZTk1BUDFYWDZIVWptMTEyLzhaTEkzWmJz?=
 =?utf-8?B?NExaOU50ckFNdTBtRXNvdlNWSThUNmx1dUdibWRoMmdJeGhPODRFWVREUzNp?=
 =?utf-8?B?VmQ0elpRY2U3azhyYUVUanUwRk5mQk9JTkwzeUZmNnZ6djlDMzl3SUNkejdo?=
 =?utf-8?B?ZUlXWlFxcnBwQzI3UFo2dmVkM093Vmg0bUVpTURrd0picFdhMGx4bzZBcGI4?=
 =?utf-8?B?SW5XdVp5OW93MGFoZ01YM2IxWmlqWHBJMW5EWE1KeGNDUDlDSy9Wd3phWDRM?=
 =?utf-8?B?VHBNTmNROW9USFNNcTY5QjJKOWFzZDRURzltSGx0Tk9MSHdsZldsOC9CSDVl?=
 =?utf-8?B?eWNSRHZKRWExbnBrbjE5RU44T215NUFSZkZxOGtOTGQyK2MybUppL3doL3Vi?=
 =?utf-8?B?ZEdUSDg4aUQzUXdmVW5tV0FpZk5wOTA3cFl2bmNSU2locGNVcWh0ZTFwL0or?=
 =?utf-8?B?bFZwL1RWQ1hUZU9UL0V3aFVxYUZYQTRudXZKNG1BZFAzTVcxYmRwS2RVNWRv?=
 =?utf-8?B?NzFkejNjUnh6ZWQwcTZPaEdHOEVrWUQ2bnRKeFpTUWJKdXgvdER2OVM3NGY5?=
 =?utf-8?B?MnpwbGp5SFh5cHg1QmlDQ0I0dXdlbjBQaXY2dTRmcmI0MUJtRW0xTHZ1dE5a?=
 =?utf-8?B?dkpHVkt5cmVkVnlKNGdDRzNRaVQxTVBBWDBuaFVXdFlGSFlhbWZLL3NSQkRq?=
 =?utf-8?B?ZHorb01ZMXpGVS84dURiTFE3VDJaZGh4S2dqT1hPeS9KbjFwZGhrSnhKK2FP?=
 =?utf-8?B?VmkvbTlJNzREMDlLQTd0eDhLajEzdUVNR0hOYVQ3azVTNWN0Tm02WGUrbDNk?=
 =?utf-8?B?WjRxQ0FxWVRRNmRiRUxSdEhGeVRxaG1xMTdtd0d2SDZSWkhJZlE0RnZXak9i?=
 =?utf-8?B?OU5VUkwrM0RXYk15MFRmQlhSbW15azNBTWVPZUdKYXByN2tZcXhTbHNpWm5C?=
 =?utf-8?B?cmw5cEx3WTNYVDA0VUJLd0didElFUy9Eek45SFJMRW9oWUJJOXgvYUdkNzRB?=
 =?utf-8?B?UENMdCtETUlMY3V5K3RYU1ptRkVtZm9GV1d0NGJwYWpMU2hkUG8vVEY0Z1NK?=
 =?utf-8?B?M3dCejdVWWZub3ZmZkQya0huM3phNXY2RE1yeUV3R1R3bCtlSmJiZTBzTkxO?=
 =?utf-8?B?eDIrbVN4QWUxcCtVRVBUd0tkMlhXNVJ2WExzQ3d2K3NHSy9HblNVU2lON0tF?=
 =?utf-8?B?eS9kZDVzZUFPZXhtSUNyWHhPa1VlNGZuY3htVExKQVZIQjdlc1l1QjdQbFQy?=
 =?utf-8?B?Rm9Qbnd3c3krTDhjUFhwTnhqYWZtaDJxejh5M29rVDdUc3EzL1p1NUFkY25G?=
 =?utf-8?B?TS9zUDhSWFdlaXIva0lpd1hwZnJEczNrSzdHVHFhUml6NW5CUTRsSW9qNGxM?=
 =?utf-8?B?RkkvVEFtK3U3M2dmYys4UzczSlNHYWszOEFBMkkvV1B5ZWVVdng5ajBHZVpx?=
 =?utf-8?B?MnFIRUdVaDV6UzRCdHBCbzJPK09vZEFMa3JSeXc1U1gwTHpRWHEranJHM1U2?=
 =?utf-8?B?NHZGcW5zNTlzTUxhRVJJam81dWJBL1hKNFpPMFFKa2xTM0Y0eHo5TmQ3M2Mv?=
 =?utf-8?B?b0JOTlUrNmdqdE1JdnVsdXV2Rk8vL3RQaFFzbXE1TU9FOUl2MTVtYWJSSXpm?=
 =?utf-8?B?NnRLcXVSa1k1N0FNbXQ0U1o5ZCtUNkk3ZXIzaWNySE1OYzZoM0p3S2tSeWlx?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zEMFk3rmWkrqiybRd5JI38dVBKp/t3H4MhSjFiYzSJOqsc5ZKXG6ykbe8QKZb412lF5IFG3qaaNTohk1/k3QdHzomODw3SBVjZrpN0ybShLPtUR7rLgs+cG+kzMlFVGPmIrpGTQK+T1qJgAKLjtNZI1YJIrxBeaea/Yq1P+3X31Wcm4pXwUB/iKjI1Q4DI9fT2WTLqte22ifTWbPy9CPqAzEq+S+CeRA9YFkDYU+g5jSgXhD8BBezlC1JLhu9TUINVb/1eIcD6u7i8kvQYtJID1VCnE9qYABNjrcQqc9I1Ov47OChdWg7Vsa1d4XijXrQmfJM6LyL/2Xj3RbeKAvKfrOs105lI4ULdNj2i1+74SprSeFTKjXEjIMYQ29ItksmrC4v/fr13Vf0/7J4b84oGQycDvLvpyfoZ+KPdEH0SoM/FkR0Q2DiXLV3BHV31pNPUzm69bDNDYaJVeZh8ucKW9X2jiVU+4UK8ZkUuXK8ySLgkYNcFw+NJmXxTlAIFDv7lTNpfz9dkc95/wUsOddqKPk5hoG6NJWzdPXZ83K6apt5OiprT16NdHbCD2ocbcz8tTw+iMvNROtuLN1rs6kiss7QzA7zD8mLqp0dsuMfGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6381e505-60da-4d03-219b-08dd452e6bc7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:13:03.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE/vjYNmTLIUHyg9/eTXT+f18bM/WCmpOVFIYnDknAKR8gkLZMpw+MkJ/9LULDHloGvqPXM89KIh74vfsGTVtVdcRhEpyTgOMpW1PGLFrVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040118
X-Proofpoint-GUID: 4gSlG7YaYknosUwVr2YSuQFRAAWhFdX4
X-Proofpoint-ORIG-GUID: 4gSlG7YaYknosUwVr2YSuQFRAAWhFdX4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/4/2025 10:02 AM, Philippe Mathieu-Daudé wrote:
> On 4/2/25 14:29, Paolo Bonzini wrote:
>> On 2/4/25 09:28, Cédric Le Goater wrote:
>>> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
>>> Propose the main contributor to become one.
>>
>> Why can't changes go through the migration tree?  The only addition seems to be hw/vfio/cpr*.
> 
> This patch isn't about removing these files from migration/ maintenance,
> as no X: tag are added, but to add an extra pair of eyes reviewing the
> particular CPR changes.
> 
> As I welcome having more designated reviewers, as long as Steve is OK:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

It makes sense to list me as a reviewer for the cpr subset of migration.

- Steve

>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   MAINTAINERS | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index db8c41fbe0f9..efb9da02f142 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>>>   T: git https://gitlab.com/jsnow/qemu.git jobs
>>>   T: git https://gitlab.com/vsementsov/qemu.git block
>>> +CheckPoint and Restart (CPR)
>>> +M: Steve Sistare <steven.sistare@oracle.com>
>>> +S: Supported
>>> +F: hw/vfio/cpr*
>>> +F: include/migration/cpr.h
>>> +F: migration/cpr*
>>> +F: tests/qtest/migration/cpr*
>>> +F: docs/devel/migration/CPR.rst
>>> +
>>>   Compute Express Link
>>>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>   R: Fan Ni <fan.ni@samsung.com>
>>
>>
> 


