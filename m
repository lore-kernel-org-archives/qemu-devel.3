Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDE3E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIjF-0006Kr-0W; Thu, 05 Dec 2024 15:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJIjD-0006K9-65
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:45:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tJIjA-0007Ej-4Y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:45:38 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5KMqUo026747;
 Thu, 5 Dec 2024 20:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=F/Nx13D/s1dADSd9e6TzJ544GIVptB+tmLQhOq0BGHs=; b=
 GudkVuUMx8flA9rzzlhoWEtNvx7HvDmlO+zoO3bN4TIZW+kzPAa0YKOHy6KWR9Bf
 7qzybIsL9e1ydvY713bfXFCm40PfDUadO1D1U4tBxodF9v/F7xnEQHIue20+5yBN
 aPfaL4xHmPIwWL6dKzAWgsNCJOHri64XYtlGqabhQrnXcnrWBwO25rDynjhLdaH0
 m+aMHKAZ6oic6IBl/I7y+i7bFoPG7dK6ktYTnSOFMBq6robE5QjFaUtNtGkqXZV1
 be1Wg1/VPBagz/aLv399vxgWk77CQXCjxVJfllJRcrKa3TJvhgfPeAoUwEH9J+wN
 ouw9utdVEEepFg8AHkoBbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tasbxkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 20:45:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B5K0hhj040353; Thu, 5 Dec 2024 20:45:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43836xchvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Dec 2024 20:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSZNp0CVBUvp/icAOQD7C7XA1EcM+UzQaazQAQW59TKOqnhtB/HXyukfGzghAo9TQZCp0ftZtmkFeF4Uhs0zfkFlvw0rjp7hkQSfPcPMg16Y7xf3lGQNZYZIbtzzDLSLPqmKrKwrpQIxe3WX37uKn2CJaakXoEcfJmDx3ehJbpXhPFR5bSgyGMKNMh3Jg7HR6O7fwSJiCUmZ54xUHdrSvQaxbZtoFNzc9AooHR3kA1GvGbQKg3aL9+NvFiyPRCjSOxNNzLHn7p3mWMCvAaR4V7ZiCtlaehQ6N6ntUTTouvgv/SAp/LWrh0aE9LpknzfuFuVHts58KDTgu2OVJHJJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Nx13D/s1dADSd9e6TzJ544GIVptB+tmLQhOq0BGHs=;
 b=rKmfHb1vkTOFUD+NRzXtAW8iFDb24d9+d5OlYcskRYtKZD94kzYV8UvaZnmN+yK8IUfGxNAMmdab2qyZJirRT6GYlAIc7iPjsfb2qnjMLPPsbHuOmYMXjgGqfrovqQBuAPrrt79761WyamsJbb+vHfMd4W9613ZlJFf077hkTALaAYY2zqk1BJa245ITwz/UQM5GCViI6jv4sve8WshpzmNsoY1Lp/qjErpvELBcFjhern9AoYXShEsP4QCsv/l+29JEhs/XT0lZ2A9iVbbZjavlXc07nxx9XcrRiq075RlEEi2lbFzzBI21iwXNIVY5UYYdbKIKI6RjdIFp2ArFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Nx13D/s1dADSd9e6TzJ544GIVptB+tmLQhOq0BGHs=;
 b=iQnIZgx6EBU174wexuUJ/PJFvb4crtbUoVBC6xgPI+H19+QbzIoavtmvD59qM5QKBkl5/misILk5VTCzRl8O6j7Hvf79R85aIzGmxqbyFyzsRuvH9f0br1QmhOVKYOo3Zk2UdHwujha09mmukjUypnm5Qp2iIAy88Df3YWJd2kE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 20:45:21 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 20:45:21 +0000
Message-ID: <a7eaff5d-0030-445c-a31c-ce645666ecf3@oracle.com>
Date: Thu, 5 Dec 2024 15:45:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/19] migration: incoming channel
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
 <87ser2cfw6.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ser2cfw6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c83908-30c6-4dc0-049c-08dd156dbc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVkvRHFmYStkRG5uQzVGR1E3djdCKzVlSzVleEpzaUFqbk5ScnltdGNHaXpI?=
 =?utf-8?B?SnhSdjlGYVpZNTM1VG9leGd2SXFIWWE4RnpQMmhxVTVUOHVrZEF2bVk3QWRU?=
 =?utf-8?B?clVJbTJ3Yms5L29ZUGtTWlA2NlowVmpzbU12ZlRlQlBoS0dlSG5LdkxxQW0r?=
 =?utf-8?B?WHI5bDA1UnFkVzBFU2VQM2s2Vm5TSW0wNDZ5MGFEcVlNMG92Y1N2RFFkT3Jy?=
 =?utf-8?B?d09RWHZzWVJOUThjL0VjaVRMOVNyK3lVcUdxR1pPY1JZbjdJNnJkTmRZek0w?=
 =?utf-8?B?R2ttdHpqUGJ4RUMxU2VqRXIwU0ZSZ2hQVGRySkgxNVNKL3BwTkVVR2R5K2Rt?=
 =?utf-8?B?TUQvdnB4RUQvb3NWYkNJakxiZDZ6VzJtSXQ4WFk2TDNyTEFwOHkwbUpTakhn?=
 =?utf-8?B?eDh2dXNZQ1ZTQVllWnR0Y1lOU3ZDaldrRitrYi9teSt6Q29COWZMTy9VbXlY?=
 =?utf-8?B?RlVYQmRUUGhTSnltRmZ0NUdYTmRCd2NVdVprNEQ3aCthQ2FYcmNmOUdPb3NN?=
 =?utf-8?B?K0YwdkJVRE9tMUEvamRmNFV2TDFwbkZ4QTNsZHM1cDRkdFN5NXpmczM4QjVk?=
 =?utf-8?B?RTFVRGJ3VnYyMUp3QmF4VXAzRDd6MDRybEs1ZEU0dnBBV3FERWR2MXJ0NmlU?=
 =?utf-8?B?MG4wd1RZQlZDRTd1bU82UGs2UGhIc3BydjQ0SXpyNkxnTkhYT1BTQzhlNzZR?=
 =?utf-8?B?R2V1TnE2SE1nUmtVcm42d21hcC92SDdjSXBuZ3dXRW0xZnQ0Qy9pdXdFQkZa?=
 =?utf-8?B?SU91SXF0NklvVHc2ZFlvcTZCTHRwUTd2ZHJta2VTSDFlalE1VEp0eEI2RG9x?=
 =?utf-8?B?djd5VEM0RVM0NG1xT3ZTSit4SUxhZkJ6cE9MWDJGTEhuQ2MzTlQ0b3BHd1Zv?=
 =?utf-8?B?Mi9iRzlSMVEzcGQ3bGJXOVNNaEVwZ3dsZGZjTFgyRzRLV2tVNHNGSTE3Qmx1?=
 =?utf-8?B?TmYzcmZHWEpFZjVQOVVVd3lCL2dONVV5cC9sL3pvU3ZXcFIwalFIU3czNFMr?=
 =?utf-8?B?WE82dmFldlozUUdpZE9XbTdTTVFBOTRBcmNEMS9zU1ZCZXp1ODNRRXc0N3Vp?=
 =?utf-8?B?bTRSbU5rRmdkaW1TZmxpVEpQc0tTeWtIbUJMMzZZYnpkOGJ6OW5OVjdIaXZs?=
 =?utf-8?B?MzZzcW44c1dBclc3VlkxTW1rUXlSVCtSMVMyL2FFQlpzL2J4K2tpYUMwYlg0?=
 =?utf-8?B?M3I0R0liL1RYWEo5b3NXckd3cWdocnZWNUFrUzE0WDRNTXdLVWUzZ1RtUmZH?=
 =?utf-8?B?TGhvNEZNTW51em9xRXJPVTI2SUc0OWk2R2xzR3N0aWdnSXZrSWRxZnBDaHBQ?=
 =?utf-8?B?VkZlQ1dWQ3VkZG5SRlFGZUp2a0Z0NlJDaXVwRXNWOU5sc3c3UHl2VUE5MFd1?=
 =?utf-8?B?T0V6MEs4dS95YmQ3ZGQ4dXkrdjcyL0VZQmpCWDVyd2NDVUZvTWhKRFNVZndX?=
 =?utf-8?B?aXdsK1ljVGx2UVpQSUhjTVluWmdsV1FGczJpTE9WcC80ZmZ1U1lSZlUyazc5?=
 =?utf-8?B?VlJENFVuT1A0UmpkTENYTmR6YWVSTWh1N1ZvNk1MSTBqU0ZQNk5TMTRBblpG?=
 =?utf-8?B?YnpYMnRiV3RpQnNOWDZZb2lFM2xJRm4yOFdIYTZETlNvbkJvTDFyTndjTFN0?=
 =?utf-8?B?TkcwMWJYR0wxTC9pK1Iyc0YyUnZ3dnZKVXpOd096NkM2TUNsMWw3bXJrTHYx?=
 =?utf-8?B?R0dGK016SGtzZElZNXZPejRUZHExL215NGFCSGZ5dTVIU3VMaU5UbTkwbUoz?=
 =?utf-8?B?MlN6K2Nranh6UjkyK0tVdDdTeTcxS0p3bWI2cmhOU1J2MlRreEk3azlFeFMz?=
 =?utf-8?B?Y1FFNDIzUVBCbnFlMjBSZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9DZ2ZzV1d3QndZTGU5V0NrRWZvSC9ROEVTYklGdjF4M3VhTmJXN0JhRGRw?=
 =?utf-8?B?YTN4UXNyRHNHYk1JS2dKRlhJdTBNakRGQi8zcXJ6TVhYak8zL3IzZ2ppck5D?=
 =?utf-8?B?cmlRbEU1VGJleDQrZnBuVUdGcW5PN0ZPTEVpUzBjcDRDMGJSaXkxa28zNksr?=
 =?utf-8?B?UGthN1hwSWZ2WEJXQTZhQ0I4aTBUWVA3STBCQjhBajU1NnZCNCtLZmtCeHYx?=
 =?utf-8?B?OXkxb21hTXJETk1CK2xob2lpUDhBMVo5aHdmVUVYWkxLZTJMYTZqNEhyaUF3?=
 =?utf-8?B?SkFvOENXd0NjcTFEcUViZmYzTXVya0d6cVUyaXlnejVJU0JlNzBXc1pZaUZu?=
 =?utf-8?B?Zm0zVUVKQTBnd1pPaFArQVZveGxVakNSQXgwdHNPSHZQTjlxWHpxVWRvRzho?=
 =?utf-8?B?RXdtVm1GTnltbk1TellyRjJlT2RGbEplbVpIc2JmRUdjS1dheWVrSHRibmlu?=
 =?utf-8?B?T0ZoVFc0YjJZOTd1eU1HcVpvVHQwYzBRQmhYTjVodkJmWEgzSnZ1LzVlT0JS?=
 =?utf-8?B?d1MrY1VZMnJEZzVLTDBkaTFrS0NpQVdPMkdhaXluNGQ0YTY3eVpFZWF4YXRE?=
 =?utf-8?B?MTdNQmd0cDdjWHlnaFRURWxnVnpnWFFHTTNGVEQrTWhZdTdoeTdaVEtGVHJX?=
 =?utf-8?B?M29GK3BnWlpJc2Q5L0wvM1A2MGFYa1R1VEYvYWk0RjZQeWlqaUdvUVI0YjVC?=
 =?utf-8?B?U2ZnY0VGMHFSL3A4Q0JIV3FnWm9temVDM1hYWnBlRkNLdW9lZ2htWlhROGFL?=
 =?utf-8?B?Q0FPbjFVMzhSRXFOb0xycHNxWHdRbTV3MEIzN3IyalJib05SeHR4UVZMc1lN?=
 =?utf-8?B?dGhCY29YaFV4azFhVDhpNk4wMEk3L0s3SEthK1lLOEZOT1E5dnRFeW12SFZ2?=
 =?utf-8?B?aDNzYVR5UmpXSUxsRTFRRmQwelZzSDE0cFduWmR6TWk2WXFKSUFPTGkyaVRG?=
 =?utf-8?B?TkNmOFlZcFJ0eXVWaldWVncyN2FWWUsrcWNDdHFwMU5CY2tHVzNvM0VJOWRi?=
 =?utf-8?B?VUZBMUE4dGJKOXgwcWZMS053RHFKa0lkTXdGbTNpdUlVeGxzRks4Z2dOeThm?=
 =?utf-8?B?OUQvdlNQNW5nL3BQUTgvQUw2WHRHdFZTdGxhZnNKVm5FRHRsZjRHMnEwQ290?=
 =?utf-8?B?TTF3bEtEUzZhUEJ1Mlh4UVNEUm55M2tuOXpVcldoR2ZKSGwzWVM4MElxM1dm?=
 =?utf-8?B?NUNvWDVmTDRLUCtBRjFVa050eW5LNXlVb2pNdTJvUnp2UmREVmdJV2pDSHhM?=
 =?utf-8?B?VlRqTDFkWExJa0lJcDBKcHkvYzBmaHZjaHhtbmt2dGUvUGhDWHFFWW10OHBH?=
 =?utf-8?B?UWh3VDFPME10TnNYaHU5aVNtNHlVL1llUnhsVmY1WmEzYkJ1b09rdk9nVUh3?=
 =?utf-8?B?bStJb08weU5HMEpXL0RpU1Vla3JGTXpLK2NHa1NrKzROUnBVTERuYlhQRkoy?=
 =?utf-8?B?Y0VLdFhIQ2hzLzY2TUtsNGVGR29DY2tmMmM5U05Ob0pJNlgzN01sYjhWZ3pV?=
 =?utf-8?B?SmJjcXREc1RWcEt5Yzhlbkx1UUpuY3VGSlh1T1hMS2k1MzNIeEpoVk9MTXFZ?=
 =?utf-8?B?b01xU2U5TDQ4ZTBsTTh5VjBJWm1xeGdVWGhGNStCVThYeFJXOGtiTkdrTGNj?=
 =?utf-8?B?QUNaWnREeElMUy9mUlZkSStJMnU1OHBIQ2ZlKzhIVlpSWGhaY3ZjM2VzNU4x?=
 =?utf-8?B?azV1VHQwMzdhdDFHVDFnM1BRa1BEQnQ0TGhiZ3lqVDc4MkxNT2RUUVZ3K3pB?=
 =?utf-8?B?TjB2QmljUWZRaGhGeWVmOTZMdWliWUpQWjRvc2c0VnM5V1ZzOHhkRWlpZDFZ?=
 =?utf-8?B?eG85emNXZEtTajN6eHUwdzdQaEtJUnNIYWE2c01NYVNDKzNyQ2pKajNycmlK?=
 =?utf-8?B?SFQvcHJFcHhWY05iVXdrRnh2RVYwb2Rwc25xbXVuaEQxNWRBVEU0OWFFTFNW?=
 =?utf-8?B?MVdZcVg3eFloUWtTTm9vSmRwZ212ZVltUDkvSGtEWmo3b2VhcHVnbklhcnBz?=
 =?utf-8?B?VCtSbXFGMUFKVzNqZjZtMWZtWno3SnNWRFkzM3R2WmF4TVB0aTNNNXRWWURr?=
 =?utf-8?B?NmJleHpGSDdqN0I2WUVHVEpaU0hwRkI3UXpKUVBxMWpHMlJ0cGtaZHJPc3Zh?=
 =?utf-8?B?UlJCVHNveFp0TjQ1QkdHZ2xrZTZpdDArMlBJUlNmbURjazdQMDNPZHlDOER0?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4/F+NhGobRV/arwGvwHkji4EP/FmeEWMjduoNZk3bm5Dak6KEHSGfI1v7n+24IEQ/fMj2nHcUkK5NwKePSm6tocPk/tyXYENpnx8UcYh+XQeyHpQ4kF5MG1fZM0oMAwJ2Yo3Aze6WQeUXTbAN9X91qhRsag29KdsQoMYDxhg4TysVvl3wiA57Bk3CGjJbIA53L8NM70eW7OTQJKr9XxirpuoruFqTQK/cA2QUO8sysAVA51tsnLTpODefMTNqL3Qwie4Gm+8738peUQwkRIGKcX6JK0a2jJB0pI+2J/HEeOgdHP2bXuHA4/dlUyhFS6ahRLgMfzhdM50ZaVnmPAUXk78Utuo7KcfkDysE1fT+mEIFemibi0L/OVKwSdPwh+0iyJCd2q0fcF704cvGAHAjnok7PoPo6aU2/X1TDuMznk9QWRw3QjWgmqPcuAm0GNEl+bmb1bZxtwuykx25clTQUfjcLuvyjOP6bBV58Z3lXjNgucOoqLaEOdEnffbzc5TDD+CWVKH3/mDjvzvVpvEXydZKTrvMTMBvyjC62ayea8LNc541L23AHnST1VJwv5cV/5i/dFbRCut+qj9f7NNYbAvXR0V3SLO8Dw0qORVYH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c83908-30c6-4dc0-049c-08dd156dbc71
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:45:21.5945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nn8mjZ4Hf++7dQK0lqoskDr/RbSw9ThQDWH82sLVAHJtwXG81J575f3Sm49M2kDgQ2SJEsDwVX8EIX2luNQ9HuSXmBIY4Ys62cqLoIyFGcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_15,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050155
X-Proofpoint-GUID: C2OP017eBuzyOK9GM8Rkix_RFu19senF
X-Proofpoint-ORIG-GUID: C2OP017eBuzyOK9GM8Rkix_RFu19senF
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/5/2024 10:23 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Extend the -incoming option to allow an @MigrationChannel to be specified.
>> This allows channels other than 'main' to be described on the command
>> line, which will be needed for CPR.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 02b9118..fab50ce 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4937,10 +4937,17 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>>       "-incoming exec:cmdline\n" \
>>       "                accept incoming migration on given file descriptor\n" \
>>       "                or from given external command\n" \
>> +    "-incoming @MigrationChannel\n" \
>> +    "                accept incoming migration on the channel\n" \
>>       "-incoming defer\n" \
>>       "                wait for the URI to be specified via migrate_incoming\n",
>>       QEMU_ARCH_ALL)
>>   SRST
>> +The -incoming option specifies the migration channel for an incoming
>> +migration.  It may be used multiple times to specify multiple
>> +migration channel types.
> 
> Really?  If I understand the code below correctly, the last -incoming
> wins, and any previous ones are silently ignored.

See patch "cpr-channel", where the cpr channel is saved separately.
Last wins, per channel type.
I did this to preserve the current behavior of -incoming in which last wins.

qemu_start_incoming_migration will need modification if more types are added.

>>                             The channel type is specified in @MigrationChannel,
>> +and is 'main' for all other forms of -incoming.
>> +
>>   ``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
>>     \
>>   ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
>> @@ -4960,6 +4967,16 @@ SRST
>>       Accept incoming migration as an output from specified external
>>       command.
>>   
>> +``-incoming @MigrationChannel``
>> +    Accept incoming migration on the channel.  See the QAPI documentation
>> +    for the syntax of the @MigrationChannel data element.  For example:
>> +    ::
> 
> I get what you're trying to express, but there's no precedence for
> referring to QAPI types like @TypeName in option documentation.  But
> let's ignore this until after we nailed down the actual interface, on
> which I have questions below.

Ack.

>> +
>> +        -incoming '{"channel-type": "main",
>> +                    "addr": { "transport": "socket",
>> +                              "type": "unix",
>> +                              "path": "my.sock" }}'
>> +
>>   ``-incoming defer``
>>       Wait for the URI to be specified via migrate\_incoming. The monitor
>>       can be used to change settings (such as migration parameters) prior
>> diff --git a/system/vl.c b/system/vl.c
>> index 4151a79..2c24c60 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -123,6 +123,7 @@
>>   #include "qapi/qapi-visit-block-core.h"
>>   #include "qapi/qapi-visit-compat.h"
>>   #include "qapi/qapi-visit-machine.h"
>> +#include "qapi/qapi-visit-migration.h"
>>   #include "qapi/qapi-visit-ui.h"
>>   #include "qapi/qapi-commands-block-core.h"
>>   #include "qapi/qapi-commands-migration.h"
>> @@ -159,6 +160,7 @@ typedef struct DeviceOption {
>>   static const char *cpu_option;
>>   static const char *mem_path;
>>   static const char *incoming;
>> +static MigrationChannelList *incoming_channels;
>>   static const char *loadvm;
>>   static const char *accelerators;
>>   static bool have_custom_ram_size;
>> @@ -1821,6 +1823,35 @@ static void object_option_add_visitor(Visitor *v)
>>       QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>>   }
>>   
>> +static void incoming_option_parse(const char *str)
>> +{
>> +    MigrationChannel *channel;
>> +
>> +    if (str[0] == '{') {
>> +        QObject *obj = qobject_from_json(str, &error_fatal);
>> +        Visitor *v = qobject_input_visitor_new(obj);
>> +
>> +        qobject_unref(obj);
>> +        visit_type_MigrationChannel(v, "channel", &channel, &error_fatal);
>> +        visit_free(v);
>> +    } else if (!strcmp(str, "defer")) {
>> +        channel = NULL;
>> +    } else {
>> +        migrate_uri_parse(str, &channel, &error_fatal);
>> +    }
>> +
>> +    /* New incoming spec replaces the previous */
>> +
>> +    if (incoming_channels) {
>> +        qapi_free_MigrationChannelList(incoming_channels);
>> +    }
>> +    if (channel) {
>> +        incoming_channels = g_new0(MigrationChannelList, 1);
>> +        incoming_channels->value = channel;
>> +    }
>> +    incoming = str;
>> +}
> 
> @incoming is set to @optarg.
> 
> @incoming_channels is set to a MigrationChannelList of exactly one
> element, parsed from @incoming.  Except when @incoming is "defer", then
> @incoming_channels is set to null.
> 
> @incoming is only ever used as a flag.  Turn it into a bool?

The remembered incoming specifier is also used in an error message in
qmp_x_exit_preconfig:
     error_reportf_err(local_err, "-incoming %s: ", incoming);

> Oh, wait...  see my comment on the next hunk.
> 
> Option -incoming resembles QMP command migrate-incoming.  Differences:
> 
> * migrate-incoming keeps legacy URI and modern argument separate: there
>    are two named arguments, and exactly one of them must be passed.
>    -incoming overloads them: if @optarg starts with '{', it's modern,
>    else legacy URI.
> 
>    Because of that, -incoming *only* supports JSON syntax for modern, not
>    dotted keys.  Other JSON-capable arguments support both.

Not sure I follow.
Could you give me a dotted key example for a JSON-capable argument?
Do we care about dotted key for incoming, given the user can specify
a simple legacy URI?

>    How can a management application detect that -incoming supports
>    modern?

How does mgmt detect when other arguments support JSON?

The presence of cpr-transfer mode implies -incoming JSON support, though
that is indirect.

We could add a feature to the migrate-incoming command, like json-cli
for device_add.  Seems like overkill though.  'feature' is little used,
except for unstable and deprecated.

>    Sure overloading -incoming this way is a good idea?
> 
> * migrate-incoming takes a list of channels, currently restricted to a
>    single channel.  -incoming takes a channel.  If we lift the
>    restriction, -incoming syntax will become even messier: we'll have to
>    additionally overload list of channel.
> 
>    Should -incoming take a list from the start, like migrate-incoming
>    does?

That was my first try.  However, to support the equivalent of '-incoming deferred',
we need to add an 'defer' key to the channel, and when defer is true, the other
keys that are currently mandatory must be omitted.  The tweaks to the implementation
and specification seemed not worth worth it.

If we want -incoming to also support a channel list in the future, we can simply
check for an initial '[' token.

>> +
>>   static void object_option_parse(const char *str)
>>   {
>>       QemuOpts *opts;
>> @@ -2730,7 +2761,7 @@ void qmp_x_exit_preconfig(Error **errp)
>>       if (incoming) {
>>           Error *local_err = NULL;
>>           if (strcmp(incoming, "defer") != 0) {
>> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
>> +            qmp_migrate_incoming(NULL, true, incoming_channels, true, true,
>>                                    &local_err);
> 
> You move the parsing of legacy URI from within qmp_migrate_incoming()
> into incoming_option_parse().
> 
> The alternative is not to parse it in incoming_option_parse(), but pass
> it to qmp_migrate_incoming() like this:
> 
>                 qmp_migrate_incoming(incoming, !incoming, incoming_channels,
>                                      true, true, &local_err);

Sure, I can tweak that, but I need to define an additional incoming_uri variable:
     qmp_migrate_incoming(incoming_uri, !!incoming_channels, incoming_channels, ...

Only one of incoming_uri and incoming_channels can be non-NULL (checked in
qemu_start_incoming_migration).

Would you prefer I continue down this path, or revert to the previous -cpr-uri
option?  I made this change to make the incoming interface look more like the
V4 outgoing interface, in which the user adds a cpr channel to the migrate command
channels.

- Steve



