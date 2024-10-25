Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA782D0C61B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4LMc-0007YA-N1; Fri, 25 Oct 2024 10:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4LMa-0007Uj-MX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:32:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4LMY-0001y9-8Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:32:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDhUTU031605;
 Fri, 25 Oct 2024 14:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=XvpXZ2rd1qqJNMIfmfwv4/55tTkO58vhU+zrbZrOHzE=; b=
 Tdl+u+FlMZNJUtcmyv86eWt7i8gdhfnFe5qoRV4nrWI7HMPQC5qirimQMoC9MEcd
 8nrfd2OMM7kbnC3IwBW2rZhWtLscvK4JpKkJ+QLH5bK7CDeP0I80QFPT6X87ZTSg
 6rV+wDmsBt7KvCuHAa9vh79JFMzeAMF0R/wlkn2ofo6NNpQ2LkjMWFfNoC936Ao9
 bspGB/H72pyXn2L9Unf4sidn84fgUi+JG2m6gG6TqtnKms46fqkJMPh8E5we3P3w
 Fa+pI5Fgf+EL/p4ciNvS33L39culoPRgtky4BEvHYp7BKKKovBio8b8BTln94cnk
 s4fymY6a60evneJGFr/39Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr4awt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 14:32:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PDs9At020998; Fri, 25 Oct 2024 14:32:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emhneuqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 14:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ+RcAgJqPUuwJTNN82pyEHG8OQCCRp8YSOQNeCKxTrLO9jFyBrowk4kKqSksTL9NklrhU7aDOE91yNIQGone5IW+2nrc71ivYsrnOzYLBwBeGkL4bcdG82CJb8xw2JgfGmKJ/jhDvlV/vNGp0NLd7Mh5dCgSUuq5M8igG0PLlNAWGObeytMzAWwqRuty3SKDruNiWLCVqx34I/xSXKy3BgjUdgyW/JkPt+0Vjw3bUzB02mqr8gv6fpcnDvevrCbHZsiV4iiYkOMJuAndeIoD170dH9MniPacBu267WT0JdaqONbKTQHa464W051sLcRFO9PDcAD7pzs3gRFrHwdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvpXZ2rd1qqJNMIfmfwv4/55tTkO58vhU+zrbZrOHzE=;
 b=PbQkJ9KONEwApOjYuw6z5lqtmYzPd3/AB40CiQWjWuoPG3YITHOCJp3QUutGuY7oOlMkH/s+eJ3ejozrc6VYfKjTV3ono9kmkkLjYsB0VBokW+AGWbPmJiGJYZVITZt/xHpFyjYx11z+1OCKrXA29U2RDgVdx2xzYahQAp59A29AIP+DJUxy37iUJm7HBgSEMiyCQQ+mGu5PA5WRCAqm3fLlTXtUDwFP/vmCpo8rYoLnKhIiiSwLOGJC4egD8t6/ShZzms1Ej+FbR3/HYtD2HVssBlnj2ox0RNElKAQXOCKi4QJOnTMgSwlfLS/SRtuSQJdo3Z+q6EneVSBX3bG+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvpXZ2rd1qqJNMIfmfwv4/55tTkO58vhU+zrbZrOHzE=;
 b=SQWRZ196RlSff0gJ9W6ZmBlZ72DlN51vc0enDYgeTTVnTpH+WPeJhhRYIDV+JtIyrNzO4ffSp92WBn1mTcj/XSLFeJ65HLc0nL0f4KNv4zDzkCF0wabtntUyhXRvo3O186xdU0csgcz/u+wbdCza1mNF9epwToaiV8IerH6IvPc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB7005.namprd10.prod.outlook.com (2603:10b6:510:281::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 14:32:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:32:18 +0000
Message-ID: <380c6b5f-c888-4cc3-80ee-4f082037aa88@oracle.com>
Date: Fri, 25 Oct 2024 10:32:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/14] precreate phase
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
 <Zxta2w6iu2n_5YBa@redhat.com>
 <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
 <ZxugavgmHrawXPNQ@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxugavgmHrawXPNQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:207:3c::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ecfb4a-49e9-4d09-a8af-08dcf501d3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUpuYVhoT3hEM3RFY1NLTXFBNWRKdnMxbkNUVk5sandVZHdhcy8zb01sallB?=
 =?utf-8?B?Tll5RGhNVVJvT0lJWkprRGc5L2FndUppQVBXY0lhSjBUU0VlMEp6NWxzT1dr?=
 =?utf-8?B?N1RIMHJiZmtMVGZUTkIxYWsyUTFSbEpqYWt2aDF4UksxVW1NWWcyYm1JYlQw?=
 =?utf-8?B?OTBGZm9DWWpIYnJqWnFXdXhWRzZLREpQQ1VONmxTb3RjcEVUaE5hWWNvVUdq?=
 =?utf-8?B?UVhkVWhUS2VMUzB1QzdCaTNOTG9DNWhPa2lCejdwS2RlWm91NWpvSDdQMFQw?=
 =?utf-8?B?anY4TlN5T2lxNVVFcHZHUFhjai9Eb3lFTGdUb05rT1VWSzYvaHJGWW9CQWNU?=
 =?utf-8?B?TTZ2cFpsNVA3dkEyT1FreG0wdU0zVDhLTXcyYXJNMG12YW5waEZtRUdDNVpR?=
 =?utf-8?B?Tkk3b3BDN3pWWDRnd1JlUXZPMzRQWHpxZUhWREoyL21tUVk5ZC91UVFSM0hY?=
 =?utf-8?B?TXhlUnF1OUlkemliZHZweGpjbC9DUng3RVlibEpIb2FWTmZhZU45V2hmZVRh?=
 =?utf-8?B?Z0ZCMm9wTzVmRnhFSnRITEVrMUJGWTI4UTkyZFVkSmo1NGJnMU1mM0VaejBV?=
 =?utf-8?B?UXpvU1dUWXVESWhZWWo0ME13aEFkRkJDYzRxQ2UybG1KYXhTVGNsZ2VaekE5?=
 =?utf-8?B?bHJqbno2RUFvS3VBdjhSWm9jMldsc2Z6VnY0c3J1c2p6VVM0M1R5aTJzb1N2?=
 =?utf-8?B?WmNsQUwvb2Zvclc1VGRsazduS2xxV3RCSlQzVUdNeFVpeXJEK0pxLzZHQ1NL?=
 =?utf-8?B?MUZpYkllemRVMGp5bWJyOFNLQjNkMVVCdXd6d2FmOVdWT0IwYUxUdXVoVXlN?=
 =?utf-8?B?N284OTZxWWtFamt4WThXOHBFenJGek1KbzRwWGwzUDE2a2Q0MVJFM0IzbFhX?=
 =?utf-8?B?ZXNTeUMwV0QwcWs4U0xhc0hWd3dUdWxaN2lnRy9ta1oySHhjKzRmTDRCVG8r?=
 =?utf-8?B?bjQrMm93NmRIdDNFU3hsQWtCdTQ5K0F0Q2VjNFpvZ3MvcW95STJiWkt4RE5Y?=
 =?utf-8?B?WVVNd3M0S1ZXa3dXMGhxbVVqMGlJcjRxell0WmtyMzgwT2VySHZPUDVOR2RX?=
 =?utf-8?B?M1RScGNUSGhrOUtuMm8vNk1weTZaS2pOSC9xa2J4ZmJlOWU2U0d0bSszUi9t?=
 =?utf-8?B?cHY5WnpNWWpoV3Z1ekN1Z3NtNEtVSDAwdmwxVjYyQnRGdldvZ1p4eTU4OE5h?=
 =?utf-8?B?RWtVcWY1VnU1c2paZDB1RndzWW9xb0N0a1VySnMybWxvMUxIaTM0RC83TURz?=
 =?utf-8?B?VGttbjBvcXNiazVLc3Zkdjk0c0ZZSExDSmxnaUp3NkJ4TlhweHRqSkc0ZTlW?=
 =?utf-8?B?bCtVRFRpUmpQdDZ4MG5aVUR2aGRpUWtEMStjWi84ZGlxSkxBUkovWWxlUktV?=
 =?utf-8?B?Ulg3c3N2Y0Y2MVU0dVBFZFhKaERJUmU2bUV3Q0xwb3YyWk9kakh2MllKVVo1?=
 =?utf-8?B?NFVmeCtyUkI4RWszU2hVemFjWmRENWJEcGQxdkZ0TnN0ZlQ2TU13WER6VGpr?=
 =?utf-8?B?R1VaRCtvakVQZ0d6anNtSXBuNS8xdnMxTUhFTEZjNmdUcVBPeEorenVPQjdn?=
 =?utf-8?B?NHhOZWFhMU4zMmI5UXQybTdzTEVFQUpIKy84NCtBaDNWMkNKMlhrMk1SSHZt?=
 =?utf-8?B?YitFZ1FqNGFmeFBxZG9SMERVK1U5Q25LUVFUZmx0QWJ5blBlTTF1RU03QXFW?=
 =?utf-8?B?MGV3MEplUEw2aEVRNlNpU0JGL1pDbnZ0UWdYbkY4aUlranVoMSt6QUx3S3dJ?=
 =?utf-8?Q?T37odtOV/vVZidrPZjpCn/fKgOC/X8c+eJN65Z/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHV5QWxSSkhhRVBmZi8xcFpabXczQm1GT0s5U1Z2THpuV3lxSXZGM25ocEJB?=
 =?utf-8?B?RmsrbThHQkV1YnVOYWJ2eFNMK2lxNnR5eUlXUUxXTnR5dW1tN0szb0RXUjdl?=
 =?utf-8?B?RXN5alJVRVFTVnNnWFpobjRXQ0dNdDlvRXJKQnEzL1YvVWlvV0JKSDBzTkRa?=
 =?utf-8?B?SEFXRTMxeVdiN2owVnRIdnQ4My92aStkS3Z4SW80dmZZbTFqelZGM2NvMkJY?=
 =?utf-8?B?VlNPK3YwR0Z2UWt4WFdBSzk1TWRhSjZ1c2dZcUFUK3NQSGtlTlJselZwdjRJ?=
 =?utf-8?B?UkdHbDc4K0RMQzFJZlphMmNVUmdmeTNMR1QyU0kyVWtvZ0tJNzgzSFFOYy9w?=
 =?utf-8?B?N0QrVE90QzA5R2g1UVgwbVJoMzlWNWUzWTMzRjYwek1uK3B5TWFOYTBhL01H?=
 =?utf-8?B?ckN6R1l5YytTdUN3TFVuR2ZzK3k2NlVDTnFxYXdiRm0wdFBpaDNVdkk2eXdj?=
 =?utf-8?B?b2Zqb0M2MWdQUFhCRUFtOWQ0MzVHSWFxajEwTFpSTlpFSndRcDREUkVOZnBX?=
 =?utf-8?B?RHVPRzhGT1h4OEt0OGorVjJOUU11bEJTSFBsQkRwa1JTOU1NZUF3SWJCSXNa?=
 =?utf-8?B?TEU4dVJkU0FzT1lZNEY1ejJuZ2VwcjlYTjVhMDMyK01FTDlFa25nd0dSZ04z?=
 =?utf-8?B?djRiL2g1Y3RWcXJnOTFyZ2cxRjFyNDVRa0ZVTzdqSS9ueDJDWXh2ZlY1QjB3?=
 =?utf-8?B?czg2SmZWZG5PaWNEZ2hNazJPRVBrQ3M2WWZlVWN0MTQzZFZmVkVQc1lob2xs?=
 =?utf-8?B?OUhJd1JQbHpCOVVRaXRVbWl0ZTE2dkdlOVFISkdqcTRiRDN6ZlZLQjhYR2xZ?=
 =?utf-8?B?ZGE0MkJOdDIyald0WDZJM2k2VSs3czhnVlVFVWM4OWJFM0dsOHpkT3AxVVlu?=
 =?utf-8?B?bUc5cW0zbVBEZytyaEdZWmdWaEd6dXB4eU1ucW5aaW9oWDdBMDBPWDU0MU9N?=
 =?utf-8?B?T3VJVUJaMzVTZHVCSFp5emc2aUtKcFVYaytzMGs1MlJLdldOTEJUWjNla09T?=
 =?utf-8?B?dUxYOHpKZjI2ZGwyNFVqSUtWSHhmMlRwTFQ3L05nY1p1MTdvcmNQTWlObDRn?=
 =?utf-8?B?R0FPNUpweVhpY3phT2ZRMmkrZE9ScFBCb3RQa004OHhlVTBGVWpoY05SdTlJ?=
 =?utf-8?B?clZLT2RWLzcwMmJZZXRVU1Y0UnJ6dmljVEZTS0hTVkpuWVJ1UTMvRXB4ZDRN?=
 =?utf-8?B?eE5zeVhqdmZyamFBb0srcjJnTzN2OVlLRm1BMG0rWHlKbW83Y0UyTFR5NmdZ?=
 =?utf-8?B?ZHo5RDhnTGxFTllPSGhGMWlYcGpycGFVR0ZtVFlLSmdOZzJCdVRZbWQ3cEYx?=
 =?utf-8?B?cnJvcGJ1cGJaUUVpOGN1aXJXQUFCOWZnVVB3Ny9Fc0NiQlE1cVBIR2lRRjM0?=
 =?utf-8?B?djZsUVZYbGNvVWZpTFZwejV5SzB2UWJ4SGx1eHpYV1pUbGNXV2VjOXFCNk5q?=
 =?utf-8?B?SlhzRGNOdVcrWUtlRmZHKzcwMDUrVUZEZjlFQ010MmNTdWNoUzZyRmtuQ2s3?=
 =?utf-8?B?ZjEyMm44enc0bFZQc0NyR1Nzei9DOXR6QUFyTGhsVFJ3ZCs4VGYxbDhXdU9u?=
 =?utf-8?B?Z1Y3T3dKdGVacEZ0cGQ5QWZhWm5YLzNzT0RHNjZrSWVJSGs4YlEraGJ0VEdB?=
 =?utf-8?B?NjNtazBpL1lSNElxY3VpSC94am1EQVJTM0RsTE5YVnBaWkdOQm0yZ1kwOXFX?=
 =?utf-8?B?MzdzN3dhUDY1VTRmdWdYQU1FLzRLOGlCbmJOVmUxUHArbDRsQVpwNVFHaTJB?=
 =?utf-8?B?MHBpSXJlSFNFMWxXcGFKUlJ2NmZhUUFtbFRHby9XRDFnbi9zdGxKSGs4S0xm?=
 =?utf-8?B?K2FPSEVvSDVNcGxEQUovenRnZVo5NEtpbThONG90a1Mzb2x2eURBZjBqSjVZ?=
 =?utf-8?B?a1dLeHh4S1VlK1B4UlZIS3Rzd0s4V3FiSXNPbFVPK2tWR3FlZmVtQmFSZ0sv?=
 =?utf-8?B?QUZuQWhIZ2VuTitkdlhNdWFPUFA0LzhMYXpRUU1VWXhsRHhkN0xhNEJpNWRS?=
 =?utf-8?B?TTlMa2NKZjFBOHpDNkx3bTdsNEUyc0k2N3NOYUQ0OG1iUW5Dd1NYckNaM2wr?=
 =?utf-8?B?YmkyUGZwbkh4TlJLeFJPOEQ0UEF1S1pXanRtMDVKS213dmd4RTNBbFI3RlN1?=
 =?utf-8?B?c2YvQStNeGYrZ1lKWnhJaURwaG12K2ZSaUtYbUhSMTBKOVZsWTZIb2YrMGNj?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lh1xvuGHCwniX+fLYaqlK2qmrG0bcF3I/lyQIHr9ZC0RQa0CulE0ByOapV0pY19tokiIWzt54qcjBhIJCB34i86ZXE8TB9MBGbqFtg6kzz43ie1bYlCr0+K940v5qDDLP7fPG09FZOzbp3SW34c+L54QfsROUqbk87eRyxKbdB2pqy54u9Y4Awtp16QZcwdyWBqPka/KOuJGMbHgXeXNFd0JlbIpVCKjO1mDqjPIo4DjfAThOSgnQKdm7lrwteU0upZIRVwrP93BbvLX9rgaBE/B6wSNH9vDfGV5aezOyqm/dfKjmHq/G2ExyWhExyq/gDWI/ZHkLZaX7ePNjOiEWqc3WEgbxVJke3sun3/g1iSSp2EgDB5O5ODs9D9rDmAzZcIvFyZN3oBePwosVi3V/Hi7byISB4ae480aztmyqAi/55ql+sz6lA8S0UnYFi2uvpd8nilUjnFvQzaE+CUo0rDH7ZETc1HLsTEovr5L3uGsPgNh7kp74wwwfSUQRItyNs+BU7HyF+FmwJ2BUKt6ykfkelbrWzLFBJ+FSTIgIROX5TSJFeWkxkNEpSFC5psar5t9EfHERokZ1bDyG5BXb92T736iaM9X8bzQhmsGkfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ecfb4a-49e9-4d09-a8af-08dcf501d3e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:32:17.9718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yP+2UPDA+sNAJbgRBqS5r8/HmbfDkcfnYYHLTfAZrGVcA9kqiCjbVDjSG0lKxj8BhIrsHldoy71Km5/bebrjG1UkdwhMbWriciftwyoEUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_13,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250112
X-Proofpoint-GUID: FwtyjIglbgrPxY346AjNWJfQ2gVYl9cp
X-Proofpoint-ORIG-GUID: FwtyjIglbgrPxY346AjNWJfQ2gVYl9cp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/25/2024 9:43 AM, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 09:33:51AM -0400, Steven Sistare wrote:
>> On 10/25/2024 4:46 AM, Daniel P. Berrangé wrote:
>>> On Thu, Oct 24, 2024 at 05:16:14PM -0400, Steven Sistare wrote:
>>>>
>>>> Regarding: "what you want is effectively to execute monitor commands
>>>> from the migration stream"
>>>>
>>>> That is not the goal of this series.  It could be someone else's goal, when
>>>> fully developing a precreate phase, and in that context I understand and
>>>> agree with your comments.  I have a narrower immediate problem to solve,
>>>> however.
>>>>
>>>> For CPR, src qemu sends file descriptors to dst qemu using SCM_RIGHTS over
>>>> a dedicated channel, then src qemu sends migration state over the normal
>>>> migration channel.
>>>>
>>>> Dst qemu reads the fds early, then calls the backend and device creation
>>>> functions which use them.  Dst qemu then accepts and reads the migration
>>>> channel.
>>>>
>>>> We need a way to send monitor commands that set dst migration capabilities,
>>>> before src qemu starts the migration.  Hence the dst cannot proceed to
>>>> backend and device creation because the src has not sent fd's yet.  Hence
>>>> we need a dst monitor before device creation.  The precreate phase does that.
>>>
>>> Sigh, what we obviously need here, is what we've always talked about as our
>>> long term design goal:
>>>
>>> A way to launch QEMU with the CLI only specifying the QMP socket, and every
>>> other config aspect done by issuing QMP commands, which are processed in the
>>> order the mgmt app sends them, so QEMU hasn't have to hardcode processing
>>> of different pieces in different phases.
>>>
>>> Anything that isn't that, is piling more hacks on top of our existing
>>> mountain of hacks. That's OK if it does something useful as a side effect
>>> that moves us incrementally closer towards that desired end goal.
>>>
>>>> Regarding: "This series makes this much more complex."
>>>>
>>>> I could simplify it if I abandon CPR for chardevs.  Then qemu_create_early_backends
>>>> and other early dependencies can remain as is.  I would drop the notion of
>>>> a precreate phase, and instead leverage the preconfig phase.  I would move
>>>> qemu_create_late_backends, and a small part at the end of qemu_init, to
>>>> qmp_x_exit_preconfig.
>>>
>>> Is CPR still going to useful enough in the real world if you drop chardev
>>> support ? Every VM has at least one chardev for a serial device doesn't
>>> it, and often more since we wire chardevs into all kinds of places.
>>
>> CPR for chardev is not as useful for cpr-transfer mode because the mgmt layer already
>> knows how to create and manage new connections to dest qemu, as it would for normal
>> migration.
>>
>> CPR for chardev is very useful for cpr-exec mode.  And cpr-exec mode does not need any
>> of these monitor patches, because old qemu exec's new qemu, and they are never active
>> at the same time.  One must completely specify the migration using src qemu before
>> initiating the exec.  I mourn cpr-exec mode.
>>
>> Which begs the question, do we really need to allow migration parameters to be set
>> in the dest monitor when using cpr?  CPR is a very restricted mode of migration.
>> Let me discuss this with Peter.
> 
> The migration QAPI design has always felt rather odd to me, in that we
> have perfectly good commands "migrate" & "migrate-incoming" that are able
> to accept an arbitrary list of parameters when invoked. Instead of passing
> parameters to them though, we instead require apps use the separate
> migreate-set-parameters/capabiltiies commands many times over to set
> global variables which the later 'migrate' command then uses.
> 
> The reason for this is essentially a historical mistake - we copied the
> way we did it from HMP, which was this way because HMP was bad at supporting
> arbitrary customizable paramters to commands. I wish we hadn't copied this
> design over to QMP.
> 
> To bring it back on topic, we need QMP on the dest to set parameters,
> because -incoming  was limited to only take the URI.
> 
> If the "migrate-incoming" command accepted all parameters directly,
> then we could use QAPI visitor to usupport a "-incoming ..." command
> that took an arbitrary JSON document and turned it into a call to
> "migrate-incoming".
> 
> With that we would never need QMP on the target for cpr-exec, avoiding
> this ordering poblem you're facing....assuming we put processing of
> -incoming at the right point in the code flow
> 
> Can we fix this design and expose the full configurability on the
> CLI using QAPI schema & inline JSON, like we do for other QAPI-ified
> CLI args.
> 
> It seems entirely practical to me to add parameters to 'migrate-incoming'
> in a backwards compatible manner and deprecate set-parameters/capabilities

Hi Daniel, should we ever need to set caps or parameters for CPR, that sounds
like a good way forward.  And a good idea independently of CPR.  However, I
am hoping to proceed with CPR with the initial restriction that one cannot
set them. The case that motivated my exploration of precreate is artificial --
qtest wanting to enable migration events -- and I can fix that.  I know of no
real cases where caps must be set for CPR.

The other screw case which motivated this thread is a dynamically chosen TCP
port number for the migration listen socket.  One must query dest qemu to get it.
Your suggestions here for new incoming syntax would not help.  However, for CPR,
we always migrate to the same host, so a unix domain socket can be used.

- Steve

