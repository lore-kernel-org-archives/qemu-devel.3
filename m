Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F138AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6Ld-0005c2-1o; Mon, 03 Jun 2024 07:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sE6La-0005bV-Um
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:59:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sE6LX-0007Eq-67
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:59:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 45320Slv025774; Mon, 3 Jun 2024 11:59:16 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D2sJMscAK0X18XLjyVFiOGO2WMPth+dJwyNKTrVFhKRg=3D;_b?=
 =?UTF-8?Q?=3DVvgx4MHC7aSXEzAt4rpnfcMxGDKWiuhqh/alvDB5wRe5Rl9uWBZfUw9NnB26?=
 =?UTF-8?Q?SkcxFywU_uQW4W6j8t3nReRibHYR/pRfhoB9RPTeQTVbKt6e6t/ux3+D9evokMR?=
 =?UTF-8?Q?oOM4/DRxVKDMJK_Z+8BY4TuiRHLFltJM0pOs1nviehrZ+MpTwcYUGuZNI/DIQWl?=
 =?UTF-8?Q?yOHdOJe4LVKciFabtJSB_AiBBlqIB7gKYJZY7prT+VHKyLOPZxub22AoMA9pWvc?=
 =?UTF-8?Q?pxr7A7o53qC3+7zpvuhGGJpME1_RzahePjcEDMfToAgIXH6a85AlIqde3gDz7o9?=
 =?UTF-8?Q?U35pCyvZK0HLLynWFgAldObUnyvn3TFV_Qg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3ntnde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jun 2024 11:59:16 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 453ANVCs030972; Mon, 3 Jun 2024 11:59:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ygrmc27e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Jun 2024 11:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ9PrfBdNQ4x9DGa+0j2BY3EJCsrDKbqy5mImr/39mH+xy5ozeT9osBllf8cFh468Th4bmrlQ78IjQ9cnIUp6BJpigVU6kdbhGy8Z2UtU6+dIBbFtoMB8AH8Pj6qMwg9EOTL8Un2RyD02PJpIcPq31OqlwL5hyc1CTl+Wsga8HSJ1A7c7NBsecu5npXxUl7Lc0VgsXP6la1dde3OFWoZ0xqacw3Ft9VEnT7xu1FRFiMzcFyBOyFvOKpKtMi/hgGPNmnZRfP/5MyGPE/omXnY108OOlRgjMVpIvOskslci3AqcQ3jwmD959m+0mAFJU9nngF7O4rO60BT2wFQDfOQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sJMscAK0X18XLjyVFiOGO2WMPth+dJwyNKTrVFhKRg=;
 b=URpqpkiH7CgbYpolFRrKoL8K0jhkEtur3G8bJ+EUApS21SUCLU5XB6fpRQv1sOIHg6ucIVLX4y3ltBoT6yQ8D4geldFPLVPhAjOkKOH/gfwGQfXmp4+C3NBVwkMNo7szr692pYUNXHUveJN0HCGYZyiQ6na5949AAfmpXiUakptatzgyGaAYsnXFJk4SBLGHx3iAp7ERV4G8RqQGOKXAP0uZTEYI+9yYTLpAmU3MA0byzLGtak+x72crXHL88K0sv5YIYaFjbx+2mpmP197aTQZEFwku+fbISQ2lKdnpmbn7Yj0szCYIkV2MIKqy08noyGB5ljtAnydEga+r5ow4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sJMscAK0X18XLjyVFiOGO2WMPth+dJwyNKTrVFhKRg=;
 b=ZFmmGlQKf3a13vjUEgOSWeD1RFXo5Rm0LzzzQ5XFXrE+rox2/qwtMcx92Rx7sof8IjDd1JTIuQUtnmFakLtTI87QYABi6g7G9zT7Lq9U1KhWH0Qk7mEFPWQmaAF1goPuMWFJqD5/mwKEOHEy1bsAbDCZgpwq1Qi0+7Js1M98jMY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 11:59:13 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 11:59:13 +0000
Message-ID: <2b4bc907-902e-438c-ae0b-a8260721106b@oracle.com>
Date: Mon, 3 Jun 2024 07:59:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n> <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
 <Zl2YQhv97Ez3_FGn@redhat.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <Zl2YQhv97Ez3_FGn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 39273b28-5955-4043-3436-08dc83c49600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEwyb25vSUtNd1Y0RUdJY0dPU090VFNJT1JBeklXQXBBMDI0UVA5K3VIU0tm?=
 =?utf-8?B?dldXdFJyYUJJNlk3aTVjTUFPb1RsQTZMRFh5Z1F6SmlMV21rL0VBUlBDREVV?=
 =?utf-8?B?ZVFvbmZKWTYwNGVJVUVrNEZMZGVqUlQ2QW05d1BNSVYrSUJoaHdvRHZMLzZV?=
 =?utf-8?B?TXJnUGR3OVh5ekI4ZUZPcXd4MlRCc0pvQjA3WUFiUVRBQlI5SytuMFFnNzdo?=
 =?utf-8?B?SGlXUmltKzNzVG8ySHVTWlhWSFA3UnFTZWtJUmZkRUlkODNQWjBTWDhaYXpP?=
 =?utf-8?B?ZlNMOC9PQ3JWY2VHTDljSXZIUTBzTFRsVlo0NmUvUlpZaU5DdGFxdXVwT04x?=
 =?utf-8?B?cktrTVVBanhsdTN0VHA3c2JrK1RCZGRpdllDN1ZQVDdScC9JWkRybWp1OW1M?=
 =?utf-8?B?M0EyMy91OWJXdUpvb2NjT0hSc2RIY3NrcFFoWW9Mb0N5ZVNQNTRWbWcwSjNP?=
 =?utf-8?B?S2E2OVF0NmdNb2s1cTZnSTBSNkZxUmxaUWFZZzRQMDNjRktlTmU0eGZXUEJB?=
 =?utf-8?B?WkRUdWFGZjJrdDJ1ejVOTHdPcDZLU2kyaUhTTXhQVGJtZ3FvRXRzdkhQVkt0?=
 =?utf-8?B?dCtvNWxhQXl3OXEwTUR6YkxDS1R5SnMvaTRNR3dNZW1uV0VGQzg3dUhFazAv?=
 =?utf-8?B?bXhUTExVUjYvRWg1TnkwM3NnTk9GNFFjeTAwVG01MXV5MTFUQmxIRWhpclhH?=
 =?utf-8?B?L29NcHlhT0Y2TGM5RHBuQkZsODErL1JMM3Y1KzB0cVhoUHZldFhEbnA4SmU3?=
 =?utf-8?B?UzlBTFgzc0R6VUpQTGNVZWhGaVhmUU0wL1AzcWRYR0RRdjZmZGtRbzlSb2t6?=
 =?utf-8?B?a3ZSS0RBQ2JqMW0wQlBDVGtDYmp3bmhsTjAwRE9XWTNiaElTcVVIY1JRWWh5?=
 =?utf-8?B?ZGx2SEFib0FSYlV0Snh1NnV5Q0lzRmtqUTlrZGFoa3BFTHROb01iYWo4SEZN?=
 =?utf-8?B?NUxKZW9WOStwSUZJVUdpcGp1bjh3SUFVKzRSWm1QMkFGbGgyK2o2MUc2UC9i?=
 =?utf-8?B?azZEUWtvNFF4MGw0OEdaVFUyR0thM09hTHd4TUF4U1cyd3N2T0N4Q3FVdmRo?=
 =?utf-8?B?TThzSG1sN2lhVUc4dk1ZaDM2U0FEVGJIdjZzZ2UxOUxrS1VuZ2lLanNpN05w?=
 =?utf-8?B?c0VSM0lHbnVoRENyeFpYZUFKVVhBNVhrVDFhdHBKa0tZTkUzdkFnZXo3TGVh?=
 =?utf-8?B?c2pablpvcW5mN0NTVDZad2xLa2l3Nlc1WDczWVZXSVIvSFZvS0pOZXJJNGtB?=
 =?utf-8?B?TFZvRXNPR0ZiWEw0Y0xLVjFFS29oaTZWcktkYXQ5b1JSQ1hjUVFxcVVIL1d3?=
 =?utf-8?B?MUNkdFFnbGpyWjhtejZiRE5RcXUvYlAvSC9NaXRrUHo4d0RIYndCZWx5ZllU?=
 =?utf-8?B?a3NFZGsrSUVCV0ZkTDlrQnRuQS9FT3gvbVQ0TitBcWFQMGZYOGFDdXA3QWox?=
 =?utf-8?B?Tm9jK0MyeEpiZWlRNEJQOWU4OUZ6VWxraEV1QXhrYkdMUy84TXhEYjR4dGFj?=
 =?utf-8?B?OFE3b3MyeHF4dXQxTjdSVEZYbTc4eUxVcmlxOFRKSmE2bFZNTldyRVRrU3dV?=
 =?utf-8?B?RTRUekdEN3llWXV3YUNGUXBQT1N1dGpheGlrRTh3eU9pZ2xyNnlqZHNybmdT?=
 =?utf-8?B?Njl0ODMvTWJNa0YwVXdOQWlsWm4yZllaSjIyVmpraHVscXhVL1MxVTkrSTdI?=
 =?utf-8?B?WVhuK1lTdE5DajYzZVUyTHJwdStTaDlNL1RLK1dxc1hPTjhJS0FYSFhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVlV1dxN0R2NzN1ZlAzMDVmUmt1c09xTVpWTlhYOWRINExNNDBrY0M4UkZs?=
 =?utf-8?B?bUgzeDVNdmU1NWd2d0ZTTVZ1ZWNsbHlNRlZNdTBhamk0UTBvd0Yrdkx5djN1?=
 =?utf-8?B?MS9SeFEvUGkrTE95L0hPcnRUbC84amp5YVdOdEk0eHJtbW9ZYko5YmFtT1Nl?=
 =?utf-8?B?NEo5cnpFSlQ1UFNqVkFvMUNkS3B5L05qYmxjQllLWFRzSkJXWSt1TVdzTTdl?=
 =?utf-8?B?T1U4RWZRckVuUXVWbmMzT2Z4d01iQSthL1VodS9GWU5vMklaSTduMVFoNEdp?=
 =?utf-8?B?c1lEVndZdVJKbXBIUmVmL1YxTVM5cjgzQ0xabUliTFY5RzJlQ3FNRmhrYitF?=
 =?utf-8?B?V1FHOFN6TFliZ0dXeFRhb3JNeEM2dnZLZ0JVelpmUlVQNDJHZUI0dmY3ejlQ?=
 =?utf-8?B?THZkWTUvVmxJZm1VYm1ES1d2MC83N1MwNWVFL0o0YnNjMHorNDZiRE1uWnMz?=
 =?utf-8?B?d243VlJMYVFVbDM4dHlCQnV4ZEZKVjJiM3FRVjdEWWhRNS9IK043WWFndHdp?=
 =?utf-8?B?WTJUL1hYMCtISW5zNmFJYVdPMUYwQzFCMXphQjJ3NTVRWVBKcHZwbXp0NVBa?=
 =?utf-8?B?U2dTOXZvblBiQ09PKytYL0JVdE80bEVGTncwRXMrUFByd2RDMzlob3p0UDA4?=
 =?utf-8?B?d2FzQ3lyYjJHNWcvQVVhZ0NKbXBaUjlNWUlPNmNGWmptRTNuNk5TbXlYeGpM?=
 =?utf-8?B?dVRqc0hFMVJ1cnBzTmpRWStjcm96akRXOENwakRmRzhiak4rb0U1Ym45MWpt?=
 =?utf-8?B?SnpIRXkvc2pTUUx6REVyeWJLODhvcEd6Y1ZTMDNWRnZLUDRNNElSQjl2QlJI?=
 =?utf-8?B?VEl0ejhsU2lXcWN0cE0yaHlXaFdqTHk4U0VKVVJoQzJwLzBPbjlYVnhxZmNr?=
 =?utf-8?B?V0FWUUZaQytFQUlxeG9va3NYZHZYRGM5d2NQQmNJZ0x1dS9QS3BKT3RueGR0?=
 =?utf-8?B?dG1yajdodTZKN1VrZEtlQktqTGpmSXBGM0djSkhFbzVTVVlJU3IwcE5hY00y?=
 =?utf-8?B?N2UxZ0ZESy8rVDRJYzZ0b0NITFYxbnIySkxRb1Fya0dqLzdjZ1Z5SGlYaGdi?=
 =?utf-8?B?MnYwam80ZExsTnhUbWhhZXZuOWNFSlh6OTZvWTVpSk5RY3gza2RiNmRIb3Na?=
 =?utf-8?B?VjFTZmVkdEZuNlRKNnY4TFZXd2YraEJRSWhPM2hVTTNlL29acGVCVXZTNTdq?=
 =?utf-8?B?Y0UwZ0hsS2ZJNWI1clFjQjJFLzA4MzhjWEhMTkF2WkpzcDNTZHdvWGNJOUUr?=
 =?utf-8?B?VUUwOS9scUlQczcwakRyMks5RHV1Q200K0k2QzExR0VMQUFvZGM1N3hlcXB4?=
 =?utf-8?B?TERVTXowTWR5d0hpbWVXelo4V29qRG54RnZNQVRHbnd5UFhOTUYrWllXWDM3?=
 =?utf-8?B?QnlKczB5YlVoK3VNVHJUQUw2dU53VFNtSWVoc3lDU2g3VlNCc1Z1OFZjNWxy?=
 =?utf-8?B?Rkk2aTRhNGprVkhWa2cwUDdBNDlZQnJjbjlONm9uWkJrRk4zTUQxZXBMK3do?=
 =?utf-8?B?cDRMZ3lid0Nvd2JIeHc2ZzhlVXpMdjFBMk1oVEgvV29FTXU4R0dPNHVEcFJI?=
 =?utf-8?B?RXdkd1l0OEcvS1pvYThDNlEwR2xobnpnWTlSS2xuN0RlTkhHRStaVEJVVjlF?=
 =?utf-8?B?K3V1cWs2bVlmMUV4T1h3MWVvNmZOM3lxZWlMa0F2TUYrR2VyY1huRXNaU2c4?=
 =?utf-8?B?dk9iZkdrUTVtblNFZmxzWTNOcWpxaHhkbkR1MXV2U2dCYVl6bWpZRDg1YkhQ?=
 =?utf-8?B?TVZHWmtsV0dhdTc5eStkNDBHb1pzTEtFbFQxM0lIa0RHbzJPNzA3dFNPTkY1?=
 =?utf-8?B?MFgvZjBoYk04M3hTcFMxTGowdFZKK0Q0aVczVVp6L1NzbVlnbHd2OTJxRVN0?=
 =?utf-8?B?YmZwN2pnY2dZRDU0MWhTcVVrWGsvSzdGQ0RMVU1WL3c2UURBenVpUEdObk93?=
 =?utf-8?B?b0hzWjE2WWtRYzBWbm96TjYxazN0dDF3MHQ3eXFDQ2xJV2UzcnRLVVhYdFR6?=
 =?utf-8?B?OW5KWDFITlNMNjExckFOVUx1ckI5OXBmYk5HOEdXV3IzTi9LUU9qWTQxVm1I?=
 =?utf-8?B?Nmc0SWNSWnEraFI3djZYMEx6aDV0Z3kxTTB6VFRIZ0tqdmRsbDdtQytacWVi?=
 =?utf-8?B?aEpLeEU4bFE2NmNqeGhvVXZjOHU1aFRpNnBoNWtCNWpDaGhRU1hsaXNDR2J5?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KqZVSUH5kjrCK19tW5W38/sFhIrVEJzKEsqE2UXBncdg3AUyouHvSoGKEIGAaEPDPRW/VT62EB3zi608tTVjiAIZhcp3B0025i1HvczI728oU0C+sf08BgmPTWyC9qvNG2RhJVkoa49uSODxddr2GKtkrCNHMhnFLWoZLh/E6DNP34Owg2A6uksmyJA9+JYMqxblvKAsj03HLCovf9SWJcQR4jzTrbRN7JGPd46zjSI5LMGdN6sobKkLM0H5SPaIgPIOgiEzB9Li99VF+Pk/3AI1T0dmSpjniCWI3LLDpzr5+h5Yj4awWjuIn52/V3sAYR50sQfL5iCjKlW8KbukZYzhf+wDaZaADzmg5bF0yHMscZqfWDEx8r2oAsAnJ9LPj377c08Uy0M4CSeZn/8+uk29R5QQtsfUFnMI7hLOuwXLOxQVpkvoIyhlb9BGlDohOI4+ZOyaciJq4uKSSr2blgf4wod/qg5xCrU8e/nds04mOtG/ra10JnSh02SEeKm9K3bNDn73e+LVqDY9LqZi2SUydWe+mqC0dSx4QRLXsFIKuL3kfC2NE2ProJoezmdhzU7g0UN3myuHOyLyytXqRQbiceN+aQOuHbN/+DhGfdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39273b28-5955-4043-3436-08dc83c49600
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:59:13.4277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtKDyjLftfo9+H8/PdTKKh+QZ1su49jdquSquy57VO/JzlM1Am1K+5BDKRoWzkiR7JzZ+O4VrQ+uFk3C3uIh6xUXpgV+wPnD1B4/ho7ACJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030100
X-Proofpoint-ORIG-GUID: 3tn0Iyk2XoWkK2tlR-nPPV4nXgGLaxAJ
X-Proofpoint-GUID: 3tn0Iyk2XoWkK2tlR-nPPV4nXgGLaxAJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/3/2024 6:17 AM, Daniel P. Berrangé wrote:
> On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
>> On 5/28/2024 5:12 PM, Peter Xu wrote:
>>> On Mon, Apr 29, 2024 at 08:55:26AM -0700, Steve Sistare wrote:
>>>> Allocate anonymous memory using memfd_create if the memfd-alloc machine
>>>> option is set.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    hw/core/machine.c   | 22 ++++++++++++++++++++++
>>>>    include/hw/boards.h |  1 +
>>>>    qemu-options.hx     |  6 ++++++
>>>>    system/memory.c     |  9 ++++++---
>>>>    system/physmem.c    | 18 +++++++++++++++++-
>>>>    system/trace-events |  1 +
>>>>    6 files changed, 53 insertions(+), 4 deletions(-)
> 
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index cf61f6b..f0dfda5 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -32,6 +32,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>>>        "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
>>>>        "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
>>>>        "                mem-merge=on|off controls memory merge support (default: on)\n"
>>>> +    "                memfd-alloc=on|off controls allocating anonymous guest RAM using memfd_create (default: off)\n"
>>>>        "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
>>>>        "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
>>>>        "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
>>>> @@ -79,6 +80,11 @@ SRST
>>>>            supported by the host, de-duplicates identical memory pages
>>>>            among VMs instances (enabled by default).
>>>> +    ``memfd-alloc=on|off``
>>>> +        Enables or disables allocation of anonymous guest RAM using
>>>> +        memfd_create.  Any associated memory-backend objects are created with
>>>> +        share=on.  The memfd-alloc default is off.
>>>> +
>>>>        ``aes-key-wrap=on|off``
>>>>            Enables or disables AES key wrapping support on s390-ccw hosts.
>>>>            This feature controls whether AES wrapping keys will be created
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index 49f1cb2..ca04a0e 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>>>>                                          uint64_t size,
>>>>                                          Error **errp)
>>>>    {
>>>> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>>>
>>> If there's a machine option to "use memfd for allocations", then it's
>>> shared mem... Hmm..
>>>
>>> It is a bit confusing to me in quite a few levels:
>>>
>>>     - Why memory allocation method will be defined by a machine property,
>>>       even if we have memory-backend-* which should cover everything?
>>
>> Some memory regions are implicitly created, and have no explicit representation
>> on the qemu command line.  memfd-alloc affects those.
>>
>> More generally, memfd-alloc affects all ramblock allocations that are
>> not explicitly represented by memory-backend object.  Thus the simple
>> command line "qemu -m 1G" does not explicitly describe an object, so it
>> goes through the anonymous allocation path, and is affected by memfd-alloc.
>>
>> Internally, create_default_memdev does create a memory-backend object.
>> That is what my doc comment above refers to:
>>    Any associated memory-backend objects are created with share=on
>>
>> An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
>>
>> The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
>>
>> +#     Memory backend objects must have the share=on attribute, and
>> +#     must be mmap'able in the new QEMU process.  For example,
>> +#     memory-backend-file is acceptable, but memory-backend-ram is
>> +#     not.
>> +#
>> +#     The VM must be started with the '-machine memfd-alloc=on'
>> +#     option.  This causes implicit ram blocks -- those not explicitly
>> +#     described by a memory-backend object -- to be allocated by
>> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>> +#     RAM when it is specified without a memory-backend object.
>>
>>>     - Even if we have such a machine property, why setting "memfd" will
>>>       always imply shared?  why not private?  After all it's not called
>>>       "memfd-shared-alloc", and we can create private mappings using
>>>       e.g. memory-backend-memfd,share=off.
>>
>> There is no use case for memfd-alloc with share=off, so no point IMO in
>> making the option more verbose.  For cpr, the mapping with all its modifications
>> must be visible to new qemu when qemu mmaps it.
> 
> 
> So IIUC, cpr doesn't care about the use of 'memfd' as the specific impl,
> it only cares that the memory is share=on.
> 
> Rather than having a machine type option "memfd-alloc" which is named after
> a Linux specific impl detail, how about having a machine type option
> "mem-share=on", which just happens to trigger use of memfd internally on
> Linux ? That gives us freedom to use non-memfd options if appropriate in
> the future.

That would be fine.  Internally we still need a mechanism to preserve the
memory and name it so qemu can mmap it post-exec, but in theory we could
invent some other mechanism to do so, such as creating /dev/shm files with
canonical names.

- Steve

