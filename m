Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2FDCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4e6J-0002Yn-RR; Fri, 03 Oct 2025 07:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4e6H-0002Yf-9o
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:37:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4e63-0005vI-2Q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:37:22 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5939Z9bF021136;
 Fri, 3 Oct 2025 11:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=F0JZAWI5BMbaTos3t4pK+iCBY8AiTAtUROi0eR7Hh8w=; b=
 Ve7uDZXOBeTXoMMIAAVfkqFxw1vLoEU0Il615sIctqE845lSx5ObnKp6+zP/Q/Ja
 ODW9s/9WTSVog2MtuleP4yLOFDkaISAMl/cOVSbdIHQOl6MfUM04gQYoTBkAS/tI
 28w5cq0UEhAXjpQ+X3S6H7KHT9m9dTMoC+0pYAeLGLBD4Z981vvHJG95yPqivppa
 bhG5A3fBAYbmQbL3MHiicOi7TdB2KXgG6vFQ8XT1yDZjdkulTjVch0QbaNEetomv
 tfno8aBo0wYt1vLyFdMtvx0dyQ1R9en3/qgvoiVRyycRTamUrID/1Xxoa5wo2Cf7
 yefzxdqQWrldB2uZdRJnBA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jbykr5k0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Oct 2025 11:36:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 593AK4EV021500; Fri, 3 Oct 2025 11:36:57 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49hw105f16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Oct 2025 11:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAI3q4EF6EEOm05U4qqU2OBlWX8ale0mBwmZ5KHgvLh2FMc3pa3JfmFkCIAyC9fj9ZRn5OnZB6ZYAF9LJdMLVgF5ixFc8ujmjFZLzjXqE4K/LAe9+pnIF3wh6Y5ikWWetBovMzArG+jpgnxfz7iitTnI0zBlM2bKf583Et4M/AhVyAO23+I7iT0aES5aBDCZ7DMgmwmhmXSo0fa/x1uK6BbroDUjMIFEVQ0d9rxx5oIjSlNVFK6F0rwop1ymYUC4xuCece1KQC8p9a/pAgiXPVjlQR52Zqz/YoSfSWqCDPxpZCu4WmfNoMVwkUX6hI+A40SyVBJWj7c4ruydcvpr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0JZAWI5BMbaTos3t4pK+iCBY8AiTAtUROi0eR7Hh8w=;
 b=SjF8Csx5xXdinlharlkOs1b4uifXzKaB8GgERIKAVoegfOzfrLIVe+ggInFJjhcDmzUVNBcPlieHkTqg0MdTFldgjYYcTFBGDCKgRMhP9LbVIQwcwJxt0c6k4CuYKg6IK4UNL6ceu0DMB+GSi+YB4Fmi2RcsBwf+ElRw/sJ3PVKps32QTZuzE9gL1ripRto1TVfMV2Wnlv3ZZQVvSDoKCTkuPpuUJdUzeKJZ8BhvLMkvnymgdFJmntFgpaKyRTe1cpwBVGwM2CvAcePVVQQOiBvWrsXsJX6ycesgf+BNbCuzPCQoluV5IzEsrDCZlRhpdjyf4zGLi06GyiyNdzyO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0JZAWI5BMbaTos3t4pK+iCBY8AiTAtUROi0eR7Hh8w=;
 b=dMAnBt0PO9l5mmFOnpyacAF11/VwQxxP4gWYACZSWNNZm68EqHtk8zzaV1ZbHyhBZ83EaoNq+E6F4VY/ZG4yfQnMfKEjgrqcXJm9mCtaU2Vb8Hz5ZejP2LiJbE32Q92Os585ULas2W4KqUwqO7wtSRReXEPRr3cbrCislGYkfv8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6047.namprd10.prod.outlook.com (2603:10b6:930:3c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 11:36:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 11:36:54 +0000
Message-ID: <24c7cf7d-8b7f-4341-8a47-e157c16a7cf4@oracle.com>
Date: Fri, 3 Oct 2025 07:36:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <aN2JE0D44AdV-qK5@x1.local> <b01c7919-43ae-4bc6-97a3-6f739ec1ee34@oracle.com>
Content-Language: en-US
In-Reply-To: <b01c7919-43ae-4bc6-97a3-6f739ec1ee34@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e77cbfc-be2f-4a53-b2ea-08de02712712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFJtWkovOVVZZGpYUWNRTlVhZ0dWTE5CbEdqanF0azlmMjd6bmtaKzljbzVB?=
 =?utf-8?B?ODJaa3NpMHFpS3liM2pmTmZwa2JSWkJXdnFGY21IZy9CQm1OamdhVDQwQWRU?=
 =?utf-8?B?aXdQY2FIMUdRRjhaRHRRdmVONjBoSXNwQ05sLytIcFNEbnluVFdVSlBycExG?=
 =?utf-8?B?V2JMVDlZMlBzcThRb3VmMTczTFJwZzd2YlBUTjdvUkxqcGYraEQ5enlyTk1W?=
 =?utf-8?B?Z3BoUjVLRE4vM0hRWVNIdnhYTjRKbG41bjlabFRvTU9SdTR5djhqNjEvS21B?=
 =?utf-8?B?UnY3VmNMbTZpenUxbk1zODFUNW1LNUNTOG10VS82bzdLZER3TjBTQk1OaWI2?=
 =?utf-8?B?VzJRMm9lbzBwSk1OcjFHd0dQdVdMblhQNTBQekNnNktEQXUvb3R0Y0kwOVBu?=
 =?utf-8?B?WWxDY05IZVhwaVVsb2k0M3MyeHI2YlN4NHNNMXZTSUpJaWF1MEtOcFphbzlM?=
 =?utf-8?B?WFRHTElMN0Q0ditkcmlrZVVteWRQbFNkMlZPV0YzdXZtL1lnQ1NPNUd3dU1s?=
 =?utf-8?B?TEE3R3FFOFA4NFBKZ3JYeTRScmlsNXdERXNTSXpzSUpYNWRPOUJycWo0OVhh?=
 =?utf-8?B?QWZyMlg5SzRZM3A3VlBkeTRTbGlJYVJkNFQwd0NsYSsvU0Z4M0VpNHhscGZk?=
 =?utf-8?B?dlZydjZqaDJYbVhROHh1Q01XR21raWRrUkFBd1R2QWlsOWhENzJ4b2JIYUFr?=
 =?utf-8?B?OXFPMVIzZjhIemh4WGw0SmFkRHk1NC9yalBCK3poczdBcHIvN1Y3c3BPSDl1?=
 =?utf-8?B?ZDVCVTZYdG9tcWpGTUhrMkQyVlhodHYwNkxPWVlJeUoxRGIrek5CRk8waXdu?=
 =?utf-8?B?TVdKai9ZR1RNKzdSalBxRjkydTBJd0JOUGp2UmZxcEV2eFpUT1daY2M1cm5T?=
 =?utf-8?B?WFk2bnVTVmpPU3htTm1xTjJUSk5MMWt4OWFsVlpBMk00UDB5UVREOEdoeE5R?=
 =?utf-8?B?UCtocWZlNDJ5MDcxVkZwdHBZVThaTktGTmZUOHgxOUtzWHdydnFNWEpuamtJ?=
 =?utf-8?B?R1dCSW96RUVxT0huVi9JS0dybm95RXlZRXlBRitKWktyQzVYOU0zUk9SdXJi?=
 =?utf-8?B?Um5VenVwN09jUldCbVZRVmRvSm1DLzJSd2FjT0NLUllXdVUwc1pWSTVLRG13?=
 =?utf-8?B?U3BGaDNneTBFZEtqcTFtaEpMYktyVld0d2VXLzRDT21weldFRjVmNHFKUzhr?=
 =?utf-8?B?RGdXdVBTMjRXK0wvaVJROUVuOENYOVJwckRsQi9SempaZ1BhcGh1VHE1b2x6?=
 =?utf-8?B?WUI5YkpGNFFRWWZqNzI0eUZ4MVgzM1IvaWxrYzdMUUZHN2dCNE1mM3RZdXNE?=
 =?utf-8?B?dlRjdzlVQXQwY0xtKzlrZUQyWHA5N3pyYnloUUo1T09XQ1p3NStHY1h6VTlr?=
 =?utf-8?B?cHhCS29jUVJOWlN0NHp1R2xQUmFyc0NNWGFmajN0blhBNC9ycmhBckZIQ1Ro?=
 =?utf-8?B?UGtvdnpNbG1xOHRyMWxML3g1R1JrYjgxeThvd052L0Y4aVBYS3BvSThSa29Q?=
 =?utf-8?B?NzdhQXY4ZGx5SHFEbnVJVi9YWXZaRGhzaEE4YTVnb0N4MjZKd04xMU91bEd2?=
 =?utf-8?B?Y2NSeTJET1dhRWNWWFp6elNGOGphYTdBZXM0eUZpaDNkZW9ESzV2ZmdBQ3Mv?=
 =?utf-8?B?QnBiaE5kMjhLUlpleEVpSEhuVFRWWitNeWZBbS9FOEZENlNTMjhtRWZqcDVp?=
 =?utf-8?B?ek95b1JVYTd6Z1FPWmR6Zytrd1crYWovOG5LQmNrVmpFQnR5TmxpS3pSY3dq?=
 =?utf-8?B?TzczSUxpSHRSS1ZwWklISkwvS1VJUVpadVhQSCs2RlE1WHdld2hIRG85b0pm?=
 =?utf-8?B?R085cFJ1RmphZ3kvY3FCdlVKSGt5aHpJN2lDWXNPQmtHTVdMVDFWYVpnVmV2?=
 =?utf-8?B?VmVkSm90SC84WmFKWFhSTGR6Zzdha2ppU01MQVFKc0VFdjI3c09FcDQzM2p6?=
 =?utf-8?B?dU5oSzdxUUFYcmJSYm5DeFJYdmFERlRpR3VYWkFub096cDdsT2s3UkNtZWRR?=
 =?utf-8?B?eG5jZi9mWE13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2YzU1FzOWlWeGNJRzBSd042ZXc4Tk9HUjdFaEN3T0tHZ250WUhKdzVTNTI2?=
 =?utf-8?B?N1JOZ0Y1NUh4NHpGajhRTXdCUVBrZXk1c2p6UG5RQnNnUm8xUGhhTEVaWGpa?=
 =?utf-8?B?MnRYbk9UZVdWV3dSSXhjeHc3dGtrcXpaNUxWWFU0SFpSWGFuTXJaUElPck5s?=
 =?utf-8?B?T1FpQVNJVG1kVlNHTU9GbGhLUzI0S1RrdDJzVDVsSWZqYnpDRDhFVTdZalQy?=
 =?utf-8?B?djh6ZU1zb2h6b2x4V0xtUXk3OE5wWVdPTTk0aUt3dnlPTHl4c2FOUU9JRG9G?=
 =?utf-8?B?aFcyM0o4dXNzSys3a01OSTUzV2pwWWFXSTVtZTZXYmxtNkJRdVc2c3BEM2pU?=
 =?utf-8?B?QUNIa2RvWlBRSHlpd2RMSHFaUFFaN1BZeUczZEJhSmpMa0JTYmM4eWhoUVF3?=
 =?utf-8?B?amdEOWFsRDJGaE5vV0huZ3IyOWNIR1Qydk9DcXcwdGJrUUFiS0g0RDBXL2Vz?=
 =?utf-8?B?M1pxMTlCcVhYOExobjh3Q3NodHh4K1BjTGozbFhlSkVMTjQ5ZEhFSjFiNEky?=
 =?utf-8?B?QWY3UnEvZTErZDVxRlRDaE9YU0NvQ05rMWdaWmRaQ1gwQnR2cUVPK1N6emtF?=
 =?utf-8?B?MUhuV24reG4waXFpRmFNRXhMcWJOeFdKa0E3eWdWRWJWbm5hSFR3a3IrbTdI?=
 =?utf-8?B?UFdFU3ZKWldGdjJjYkQwUEpsUStMaDBtSCtpbHFRMU1ZeE9ZeGJlNkhTYWVu?=
 =?utf-8?B?RWRySkNVNFBSa0Jrb3g0K3pKdlc1RVNUT0JVZG5zWW1jeHhYTTVMTGxFZXdp?=
 =?utf-8?B?c0JPcWNtbWdpQXBQaHRkSC9zZTM4MExlbXN5TW83V0hWbFJ4RnphVkdHQkEr?=
 =?utf-8?B?cUduWXNWcHRCVVp3VVR1Wi9yVG9IdENXRjNYT1NVMXlkZDZnS1VnS1lzaGZF?=
 =?utf-8?B?LzEzNHIxWDRLekh2UEdqNERHbklFVUhDVi9XLzVPa2kwUFBqRnNnZ3Y4YjhQ?=
 =?utf-8?B?NUdleGI4M2x3ZjM1VHE0czZkZzJ1ZGNOdEMvY1A4L09GUDFTRms5Ym1XL0RO?=
 =?utf-8?B?WVRjUXE4ZWkyV3hxb3BWVWtUOTBzaXphc2NteHRyMTlzM0RxYWR1aXhkOTV0?=
 =?utf-8?B?ZmFtNDV2a1Jta01CNGM2K0N5L2NhcXBQQzd1WEdoUXBKWkNjM3pyRnlCUTYy?=
 =?utf-8?B?NTg3cmIybE82dFJxd3VvempORWh5dVkvdFZDNnVRSWhvRFZ3WFExZlk3OTFk?=
 =?utf-8?B?cmMrRGZ0eUlPeWF3Z0hsd1NQZWVseTBkL1N1ZHp2UzFIVHRIaVpLa0hkSzQ4?=
 =?utf-8?B?MEZvcFhVRm1ETEtGaVUrRUpNM1JvZjNtU01pTGMvcHVEajMwamxrM05yVWtr?=
 =?utf-8?B?YjI2RHhEM0o2SldHdWxBRE8wRFlKa04xZGEwL25mTkJ1RndBaGcxdXIyZ1lF?=
 =?utf-8?B?a2N4akU2cWJNcGh2d2REZWplTjJMaXVtWXBpSWJDMVB1akMrNGVhMmFSbkl1?=
 =?utf-8?B?Nll3ZEhnSnlzL1BLcFVGZFZjdTZYZGU3TjlLMHhEU3l0OEhFQ1VGMUQ2TXM5?=
 =?utf-8?B?QzhYS1lKTS9vRGtmNWJORktNaUp6dCtZYlI3KzdYR1l6SFhSQzhmeU1XS0Jr?=
 =?utf-8?B?OHg5SFoyYzZiVHZ3NHFVNGdpaG5VREwyM2pIS1RxOS9HM0NodGRNQ0t1L2hu?=
 =?utf-8?B?QWhCM0FFaWZxNmY2UENhU0doV01jMEh5SU5idTFZSGRXNFlYdldnalM1b3Zv?=
 =?utf-8?B?T09UWXljendCTTRTblFHb3dBRVE2ZG5QQ2pTV280eWFkY1N1RGxPY0tTZXZp?=
 =?utf-8?B?UEtETDlQSUNzL0xlYUx2U0s1ZlRJeUNHeEhEckdpZU5UMFcxeTlEejdPUzBa?=
 =?utf-8?B?N2dUOWtLUVNBMVY0VjFlNENPQjA2bjFKWkd0cTNuelpaVi80RmVSZ3pDd0lF?=
 =?utf-8?B?T0d2cnhyWlhMU1FQdjkwdWJDeXpYcEl2eGZNSWxKQzc4TmVzSlRLWXdTWTdX?=
 =?utf-8?B?TU9NZTNvSllwZGlJNjFXUGl2T2JTT3ZkNkllOFVpRlVUc1dLdHVWYU9jNk1P?=
 =?utf-8?B?SFV2aGJnMjlaYVhOTWR0cWtBYVNOalZkVHdKbHRiWkJZdHZWN3JlejhsOHBE?=
 =?utf-8?B?ZjE1RlA0SkNmTXJSNG5aN2huZ3VEQUVLUDVXQVdBREFJWnRaNkZSeENPWlYv?=
 =?utf-8?B?SVM1Mmd0cmRzajkrQTdhY05ZS010OEFyMGJ5SFB3ek1LRWdtUEV2akFJcHRP?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nRY/3YNrpBkYF2P2OBY+Sqe1wNsheP1inqGTjRrP7lH2KwHP8yBIHKzRdIkDXE+LlKCfR03UlvEx+0SVYoN+iZLFV68nxhfwP+DsKGwaukD3XY8FVBrwoB3sljv1D+97pT6oN8dbxR8j0Ffv3bIuKGA2KlsdvJhoJeSUlSxjE30PWmljw4fxb8zsve71xBy2YGcVLe40P5xT89Qbag4NcS4w4eZsBmfr2jUcJhNH2124h7HLoCBM0VwJFdKfj06nLOu95gkUv8UuuNpIDE6XmGO8Gk3cbAMimKL+DeS7Vtx8lLQzJI0Lb2Mv5fjvJaTjMxORkcQCOgGgcmV7zq4xXAjtpOzj/sBFNx6ksoKWA5oMUnH/92kIWwHXuftsekxIdnWnDkKB403J7Wt2PslYneba+a2iPjXm7yLRdKkvwHzMXxYEwAeZQ6NJRY8Kd8SbR/kahAq4ZlhqnIpX1jupjt9jW5VMEiADJcGe/6E9B92nzlEYUT9CrEAQldOJlD+qkoxgqewUp2l9rXiXVSxMm25wjHHb3Pe+bIOWFUoP3ZcYzx5dq1MQ6aten8xhzB/snWbh1PocxOSDgVKul1asycBRtZCTpG2eAEUe/g0crc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e77cbfc-be2f-4a53-b2ea-08de02712712
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 11:36:54.6638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU0krJgUt9UBHBLFsajjUueu2GRHqX95AvMl1bZMLLJ1NMekNqkK/UcqF0FBxsRBaaQD0GF2GAiKNTnXUwjO/A9cqyXjuVF8sCUJRAhN6VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510030093
X-Authority-Analysis: v=2.4 cv=McZhep/f c=1 sm=1 tr=0 ts=68dfb55a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=p0WdMEafAAAA:8 a=RZ4FCAUWAUYdEhQCNMsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDA3NSBTYWx0ZWRfX1wfK9juzskMX
 z7ur/TEJ8cozjdUjr4hp1xN9iUqhp6zHYPMdMEb0etCnmiD3TKRQOER7KN6tdrvKOvMZUQblAET
 j2OGo7ILk2yu3iRg1j50LsGnD78SSd044/mMVr9Yqh/KLhSkYFdd0NSJ4KQtSVipqQ4EJ+y3hcc
 MBpunIIA52WSoVjyxCNO7Md+1VItpS1Pq6X9eVw1zx3R/brO2wiAp4Kz3ZLH5vJQUHnyHkzTzmp
 fj3s4rXUVJovdpsQsPYfPjcf+EUzh+0LNLxzvVLyzm7sFNc10QIt+UYSFm0d7CH1x7KobiEjfjo
 TLvTKh0AmNy6BkWu/CnM9zOzJzMFHdmpki5666YQfw7vpI1CitFthgi4hbLwdCmvgd6G/SniBYP
 bp0fWONDeHe8+22NIb2NyYtwhPPxkg==
X-Proofpoint-GUID: aA8vFMf6yMznA4QrinKYl0SfftH10O9q
X-Proofpoint-ORIG-GUID: aA8vFMf6yMznA4QrinKYl0SfftH10O9q
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/2/2025 9:44 AM, Steven Sistare wrote:
> On 10/1/2025 4:03 PM, Peter Xu wrote:
>> On Wed, Oct 01, 2025 at 03:07:23PM -0400, Steven Sistare wrote:
>>> That does not make sense.  It already does that, which is why I used it:
>>>
>>> util/memfd.c
>>>
>>> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>>>                        uint64_t hugetlbsize, unsigned int seals, Error **errp)
>>> {
>>>      ...
>>> #ifdef CONFIG_LINUX
>>>      ...
>>>      return mfd;
>>> #else
>>>      error_setg_errno(errp, ENOSYS, "failed to create memfd");
>>> #endif
>>>      return -1;
>>> }
>>>
>>> Did the windows build fail due to a different error?
>>
>> https://gitlab.com/peterx/qemu/-/jobs/11566477462
>>
>> See util/meson.build:
>>
>> if host_os != 'windows'
>>    ...
>>    util_ss.add(files('memfd.c'))
>>    ...
> 
> 
> I see.  So you were suggesting, as the minimal fix, to add ifdef CONFIG_LINUX at
> the call site, not inside qemu_memfd_create, eg:
> 
> QEMUFile *cpr_exec_output(Error **errp)
> {
> #ifndef CONFIG_LINUX
>      error_setg(errp, "qemu_memfd_create requires CONFIG_LINUX");
>      return NULL;
> #endif
> 
>      int mfd = qemu_memfd_create(CPR_EXEC_STATE_NAME, 0, false, 0, 0, errp);
> 
>      if (mfd < 0) {
>          return NULL;
>      }
> 
>      return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
> }
> 
> Do you want me to re-submit a patch, or can you add the above to your tree?
> If the latter, feel free to tweak it.

Hi Peter, do you need anything more from me at this time?
AFAIK I have addressed all current issues, with the snippet above, and
with the new 0001-vfio-cpr-exec-mode.patch attached earlier in this thread.

- Steve


