Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D2FCF395D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srKdU-0000sg-HJ; Thu, 19 Sep 2024 13:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1srKdP-0000r6-Al
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:08:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1srKdM-0004Wc-Gc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:08:03 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JGtciZ015612;
 Thu, 19 Sep 2024 17:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=aM5VAxWRD6l9JwIzp4Sq2ljzheoRYF6Lyb4t8sXgUoU=; b=
 F068uAEw1QN1A8DWXrbwG7Ct/rbTHVcNpSqCC3P7beigby70qheWqVRRWkR1QDPJ
 iNBqALk7qkec3iEbaOrtHgPtcfOlgJ1ko1VH32nCj7jo2Tl2dzIYGrHY7l7hV29V
 8Pi5OGkTn0NX5xgODusiLlwVnC3ighZ9Qkak65xGklqNMaPx4afmWuSqJAoHmgHA
 f3bm+0ZFCz7sTq8wvrVH97EPUVAPJZNXCiAKmYXSJZuZ0IcDI3/CS6fuJEfyLt9Z
 B5KNovRPRiQ+H9COb2p0GR0RhxYOERmfMkv6pm3pelR6R9HAgzndUMHH+f30PvNU
 7LdmDvi2uM67NI0zVULdnA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfvpbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2024 17:07:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48JGkL0O011588; Thu, 19 Sep 2024 17:07:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyba1xum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Sep 2024 17:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3IJxwKj9k5nXRWh/3hG/j4hPcKMuwT+6GK5B0aIX8in2YqA97ADqsOsuWA/gOeqYqRjgnQRO8xpFOQIsgdcl91BRdDIZcbZZULlTHL7WI/ivwx9R3HHrXXYEYTfVCK90d+PE1ckOw8yyOMaZpAHErOkWZa/3yC3bIhCdxkiRppxZyKBKEohH8jGb6CG46FbBo0M0dlCKcbKq55IytGphTeW5gvHVII6RGc6oD3tvuekdDH/zsHqfhCxhRG6RJHHs4LLpo+l6CP4PmFYAMGLVTZOykNEbEB3r+v5xt4ULBZAgcmQQ7BRyxYRVu2Or1kb+vMxw+I4wBc/WXxZuhz/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM5VAxWRD6l9JwIzp4Sq2ljzheoRYF6Lyb4t8sXgUoU=;
 b=cAefGMjMBPulboXR0+/RiNDojgjgQZKs305pTp6VfdLvegX1tqj69YnK5nokKlcOkRpYpvTEmrgU5W3tDgzsXtfVpYBxsDvFyrz4688pVPA7IH/TN+g4MDvIFmD8Ej4Ysh2ZQWTqrdicyh0KMXjX5fUmXJoLCcLeL9757l/fqKgU6UejJvXdhj+DjdkQljmrpKYKWGyuATU/M8UFK0zIkA4md8xIH3W4f9Ashanws8v+UvZga8AvtGQJ2P7BtcE1LZHlN58sf6YnobPPsfnp0wkNzQ2LtKY38ZVWV9M46SMi7WjcYYrCkCeP8gwb3rUm4BuPUdfMA1Lxdi6nZnrT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM5VAxWRD6l9JwIzp4Sq2ljzheoRYF6Lyb4t8sXgUoU=;
 b=BdXT+R9SKwKusiCGgowAZ4zXtcW7e5eFEP1Hl3SNiFw/cq71HIwXKHxx3K4sHpI8or3HKHv+G/drpnYIi4K55FH5mNBuuD9Sd5bmoJSq4BsxcXqJG14Lx4hs5uzxzntpemHCLctpoY3TvFS5kfRwqEFQ3iW6sopL9F2yqOiMBjg=
Received: from CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12)
 by SA2PR10MB4410.namprd10.prod.outlook.com (2603:10b6:806:fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Thu, 19 Sep
 2024 17:07:45 +0000
Received: from CH0PR10MB5004.namprd10.prod.outlook.com
 ([fe80::400c:6e9f:d137:4a2d]) by CH0PR10MB5004.namprd10.prod.outlook.com
 ([fe80::400c:6e9f:d137:4a2d%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 17:07:45 +0000
From: Jag Raman <jag.raman@oracle.com>
To: "dave@treblig.org" <dave@treblig.org>
CC: Elena Ufimtseva <elena.ufimtseva@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] remote: Remove unused remote_iohub_finalize
Thread-Topic: [PATCH] remote: Remove unused remote_iohub_finalize
Thread-Index: AQHbCrU7ewo8akhmh0qX8ahHxIZdHLJfV3kj
Date: Thu, 19 Sep 2024 17:07:45 +0000
Message-ID: <21E1480E-342E-4F4F-81A1-506CB45CC4D7@oracle.com>
References: <20240919165852.322707-1-dave@treblig.org>
In-Reply-To: <20240919165852.322707-1-dave@treblig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5004:EE_|SA2PR10MB4410:EE_
x-ms-office365-filtering-correlation-id: 092e8e2f-c91d-444d-5758-08dcd8cd94c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OWpCWWRnQVlyY1UvcWVkQ1ZiMzBmT1FacFFTRGVrQm1vTHE0eFdUdTBxazZr?=
 =?utf-8?B?VTJIaUNHR3U2SzljU3VvU1pZUlU3WmlqS1d6YVJTVWM1cEkyeXFyN2syMGE0?=
 =?utf-8?B?a0VxTWptZzZubXNPTkZ0RkdFcXRhNUY3Z1AxK2RTNFVEa3dqbEF5UU5Ddjdu?=
 =?utf-8?B?c2ZTWnEzd29KamZCempYdlVrK1NxaVNVQlluWHZHNS9udFFKd3ArbzNRZWJF?=
 =?utf-8?B?KzlyRTRtbTYrYXlkZFArdmpDNU5pRWQ2L2tQZVk5TkdPdmpqMnl1bldUM2RF?=
 =?utf-8?B?dTYyTGE5WE5XTmtXMFd0dEgwMFJSQVNVUTVqdFNpTkt2T1dhTGJGYkc5US9P?=
 =?utf-8?B?eVhMOHhLd0hkMWw3VGZLTGJ5ODZEMVZhVDdvajdMQ2RsNnRLRWhoU0hZZkZt?=
 =?utf-8?B?TkhYeFlYdHg5bUliN2dDVXRBb1RORWl0U0JKeHZUak1jMjRFZDBYdi9icjlK?=
 =?utf-8?B?WjRmZGFMeSsxUTE3RlR3aExzb1hUMXhXdGt0ZWlJVjZLQkt3WHp1SnprWDg3?=
 =?utf-8?B?QitiZ2FzSThzemJjQmxHVEpJQjgySlBnd0IrUzQ5cDV5V1hZTEZBNWNEaWhK?=
 =?utf-8?B?UXFmUHovZG1EdTBEbkloVStreXhNbmxRZDBqcFdLbHIwKzhjM2svK2JSRDVh?=
 =?utf-8?B?MGExQXhpSFlnaGQ5YzhmWUx1WVN4ZWU3WDlldkhWbnZ1MXh1My82bWNuOHpw?=
 =?utf-8?B?MVlLOWdDSXBaWEFLOWlHM1FxVEtjZWNNcUZzTy9xTitkNlNqMEZYK2JMalJl?=
 =?utf-8?B?SmRxMUtmKzFKV3NRVVBTMEVERzVadkRvb25TeGo0NDZOdWRFRDZWLzNtZUEy?=
 =?utf-8?B?SlJxYmNyandPQkhHSm1pUldyZk9iMFFFL1pkcENmdlM1Q0YraWxMRm4wa3J2?=
 =?utf-8?B?VzRDSUZWMXUzODZTMkJ6N09hUjRXalNqbnp2L3ZXbFBtY2w1NUMrNEJZSkt5?=
 =?utf-8?B?Q3o5YndHWkFpM0RaMVQ3U1VjSXVJQlpZSjFvR2IwdGpCNTU3OTRvNTdEVkNs?=
 =?utf-8?B?SjE0YUJXc1cvYjY1Tmk4UGJ6V3VjRzlkY2ZqODVPejk1NEhXK1hrTDIxcldz?=
 =?utf-8?B?a21nUEt2NVBzaW1YV1pwZGFrN3ZmSk9hVzhrRnpIamh6bDNQdTdESjc3Q0lo?=
 =?utf-8?B?OXdBQWVsU1lZdTJ5R2M4cGt0T29keWJGL1RuQ1FBWHZaL0hEYnArMUU2L3dC?=
 =?utf-8?B?N3ZWemVHNTJNUHVhdVJxaGlZUTN0Vm90ajJmTUwyaURRaGZ0VHBnbzB6Nm8z?=
 =?utf-8?B?UUNObnN6eFVLUUI5TXBXS2Jpa3Rkc0c4ZHlrRUcvLzZXeUo3anhtMGFONDYz?=
 =?utf-8?B?Y29lQVl6bTQrNEFYcnBMTXhJNjJxeFROTG83ZXRKalBZbStKeUxqYWNYekxO?=
 =?utf-8?B?RXhQTlhXNzdvZG1lZDg5THpFa0lLbmNUcU0yaitRQnBuaTlVQVprTEFDVWpk?=
 =?utf-8?B?UnpBNTV1RXhjQzkraUx1cnNIdzVhSjJwU3hTMkx2cTNlNDhkazZ4cndwQlQx?=
 =?utf-8?B?T0x5VGI5R25wZnplWGNkWTM2OGM3NHFwc213N05lSTJxZllWWERSWS95aUNs?=
 =?utf-8?B?WW54b2l6dWw0S2UxSWNqQ3BHV1VpeVdUUGhBMHJXR2FMSGVRTHJUekdVR2oy?=
 =?utf-8?B?OXRUaERqaWw0SHh5NmU1WVAvVkR4V25FTTIxTllzcy82YTcyd1BoVWVwSzlz?=
 =?utf-8?B?cUxzNEd4MFRjUllELzdUNUJqdWFZUVVkTngvL29sbjBvaVkxdnY3WGRSUnlw?=
 =?utf-8?B?a2lmMWE3OE1IaUxmMzVaUUQvVnB1YmcvUFp5ODBwSFZwaXh0SXp2dzRhVUxJ?=
 =?utf-8?B?eVF5Y3Q0TllwMzBicjc1WDh4ajBnYlNQQ2tCeUpMdFFkL1NWcm1mN1UzWjF2?=
 =?utf-8?B?SzF3Wmw5cVd5YmYyc3k2Y09KcUMza2t0ZHRWQXpVVk5oTWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR10MB5004.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elhkVHQrN3J2b2lURHFLWGlBUDhtMFFUNDhxNzhyRDZ6REc1a2pOeVErNjFw?=
 =?utf-8?B?a09FelZldndJV0QwM21zcVkya3F4SlhZVVZaZ0tmem9NVDJpOTVXU2RVVkQr?=
 =?utf-8?B?YnJqSlFTVVFzUU9oSnVEdE15aEtrbHE0VnJqYkJtQll2WVVTZkpYV212ODYr?=
 =?utf-8?B?L2NhQ05zQjZZby9LeU1CVDg1NXBQbUozV1NyVWoyRjJtdlQ0eXBjZ0JCUU42?=
 =?utf-8?B?NGd4QlhUb1pHU3VtekRXUGJUdm5pQXk0NGdBMHhpTVZNVk5NaFJJSlRVeEhi?=
 =?utf-8?B?SHpoWlJLQnp4b1F1NGU5a0lJY3k5b2UvQjY4RFNHNTlKQks5VlJ4L2lxaFNj?=
 =?utf-8?B?ejZQSEtIQjhkbVBXdzlDUjN2UFQzOEFBcTkvL2xVam9DdnZyOHJyYitJUmhG?=
 =?utf-8?B?SVlySHRGMVJoNlM2dms0QnlGUmREQ0pERE5NZXowelpONUxwQjczQmdzUEF3?=
 =?utf-8?B?cC9RU1U0VmV0RmxaeURMV1E0ZW1MRHFaaWdPZDlPR3NmTk1aR2g5SGMxQnhK?=
 =?utf-8?B?VnRuOEVJNUNaVE8yQmNTVXo0UHdSSmhGTTMyQ3ZSWExad0krcXJweGF1NXps?=
 =?utf-8?B?VzlCUXdoMGRtT0hrVDZPcEJaWHU1WUswVDRLdWg3OXNjUEZJZkFaNUNtM21X?=
 =?utf-8?B?VUo1VFlxcGt3L0JWY2duTFIyUjgrd0luaXNocHo5VTl0eVJqT3JIU2FZT1Bp?=
 =?utf-8?B?SHFhVjlUb3NvcUI5b1BHMXpBSG1BUWhTZjNZTjB0anVZaDRxZzdwZHVtb2JR?=
 =?utf-8?B?cXlMRkZKTmxNaFY0bmlBMzVMdDJ6ajBsL014YmxjY04yNjgwaGpjQVo3L1J2?=
 =?utf-8?B?aTI3K2NuMG5xN3VHS2s3cVZWOGhKemQyZXJjc2xKbEQzaFRyeXBHd1lRbFlR?=
 =?utf-8?B?ZFZaQzV0YkxoUE1wR1pqSTh5eEFVVSt3Tk9abzBTVWE3WTFPTXNGQzB3Q08x?=
 =?utf-8?B?WDJ4dE9iSnY3UTA1NGJvREJPWG5kZzdCNmJDV1psZVJlbUV6c21LOVMwQW41?=
 =?utf-8?B?dGFEVjNKV2czOFJHcVBXYlptWWJFQkhFWEtWaHJkRG5iTis5c2syZVl6dnRv?=
 =?utf-8?B?WitBQ1VmQVlPTDlEWnlGVjBkVGpYc2htQlpIV3FidStRMStkQnVLTWEzZHVD?=
 =?utf-8?B?MlhtWjYwNXpCMnRNK2w0QjZrWitRc0lwY2RqYk5FQ1dJS3hOcHJoQzVKYXBu?=
 =?utf-8?B?NWFPY3pHL3VuSEVEZ3gzZjRzTjJoMTQ2aExLZFBnY1ZXK0pVdU4veXZtN2h3?=
 =?utf-8?B?cGtDMUhsdkQvT29qZU9QdHFjRkxsc3I1ZFVqRllYdElDR1h4TGFmTkUvSDAz?=
 =?utf-8?B?SXV3cmN6UzMxL2NqckF6aUN5Mjd3K0tnYzRyOVRvRVVYVm9CeE5kM3dJWTV3?=
 =?utf-8?B?YUN4OC9iVnNvV1JJNFJCNC9TWE51OUc1MGhyTml0MUQ3S051QTk4WUxxVjZC?=
 =?utf-8?B?TFlMRzVTWVNwUEFDYjJuYkl0WWg3VDRjZjhYQ3dyVnhpeGpYYmRMUTgrODN1?=
 =?utf-8?B?UGtPMzBycWp1cW82YUZ6S0pkYnc2Y25yVlV6WmdZaWRJcC8rTW4xR2U5S0xn?=
 =?utf-8?B?Q3NYRERybnd5QU9qeFF4dHp1ajFsbGQ4NFVtS2JDSEZmKzF1cVZqdWdnanhR?=
 =?utf-8?B?T0RiTXhsREdhY1MxME04L0dLbTFtaTN5NGdFNlVZSEErZU9CYTlkVk05cVpq?=
 =?utf-8?B?aDdLN0FGdkpxTHlEenRVUVV6aWphTWtuRC9Qb0VabUt5eXBWMkc1TUxnWW5B?=
 =?utf-8?B?amZSajFQa1BZb0F0dXhBa2o5dk50MjYzbVI1QnBVSE9hb0NjWmpEZUFiTnpk?=
 =?utf-8?B?Q3lqQkJNKzNFblRDSnBNQTRZUVdFM2JEZGZBZk1YMmZjeGNLMTRmekUrTmtq?=
 =?utf-8?B?MUc2OU9RWjVJcDA1c3NkVmJMdjVqeDV0RUxCTWFqVjRnRUZ2UnA0NWMwTnl0?=
 =?utf-8?B?em16SzRFRkRoMXJ2NDc2TmRYTWNVNERtVVR0cEllcjFidERnakpvUWxzRVlB?=
 =?utf-8?B?dzJJQ1J0TWc3L1BqSEFpR1UzUkttdlRjS1pSYzAyWjdSbDh2aXlzcDAyUHl4?=
 =?utf-8?B?QlMyQXphVytYMnhHSmhlNmZlNGVGQkF2UzAvdEtRWXlDN2xYeHZnVnY3QmZV?=
 =?utf-8?B?OGxZQmxEeWs5alZrMUE2cGlrTHZKbGc2UlorMUpsUHpVVzIxQzhib1V3NkRj?=
 =?utf-8?Q?SLIEjdApRts/eUMbSvkOlg0flcFb+b1YlAMldL6cWxyy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XTF2sGNBBxea+RskVj2nLpvNWdt5A4iAuL1u4Mw4ZQfB5vZkMvIZac9HnggDDKOM5ZK1zn7Tn3v26jyXsgjcI6iTSwC1XL0pdIravbt+5iJnGC9R68b/uQqehCz6cJyk5AllUSH4P3fObLvBukqkVR+liTrD0HcxlLJ7W5tOeAc7O2VUVGdsVr+7xiPYqOGE27frUk590cub5zdldC1bWthGtuLYKz4TtTV18iL9N0mvlSPhPjL612ooxdSnAiG97FaStYpSpa8VgMPgWT6jDWFVmaVBp/6EE/L75zjnQ73czPg3c+pggdRm8yBc1hJkldEpdiZ010J5JU/SXUynCv9J7XZY8hD3MVuhKiHVxNLvBdZ7BvN/cyxBSDyfJm2ful9B+WzutZQByK/AzCeKmotDkLCr7BkmKqgZSk8mQsuR66i1PTZcC9VZq+xhYpCWA6TlYPALioCBkHNuFd5uAFKPa4/dp5zDkEttusDE3duGv7PwnwzGs+RVMrr6KbRX9BydJRPi5Du3ozsvATutHwtEnOwH72yY/RiuAdaE+hI5bMNSx0Wp5CfKx02RkNHDOaAU+x4+aIoXT+ghViraxjgTNtOSo9LfxFP0qJKIQtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5004.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092e8e2f-c91d-444d-5758-08dcd8cd94c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 17:07:45.5449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUQ2D9tEMDp7bErEF1nC7fFGWdDSS+saBkXjuJkpN1ebqPEuD5NCwF1Co5Qys4t3O7vyQ+aPE1U5fTd/c+GOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_14,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409190113
X-Proofpoint-GUID: YAWrH4SyglmTrEpAYSIHLMaqz-k2MJdO
X-Proofpoint-ORIG-GUID: YAWrH4SyglmTrEpAYSIHLMaqz-k2MJdO
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

DQo+IE9uIFNlcCAxOSwgMjAyNCwgYXQgMTI6NTnigK9QTSwgZGF2ZUB0cmVibGlnLm9yZyB3cm90
ZToNCj4gDQo+IO+7v0Zyb206ICJEci4gRGF2aWQgQWxhbiBHaWxiZXJ0IiA8ZGF2ZUB0cmVibGln
Lm9yZz4NCj4gDQo+IHJlbW90ZV9pb2h1Yl9maW5hbGl6ZSBoYXMgbmV2ZXIgYmVlbiB1c2VkLg0K
PiANCj4gUmVtb3ZlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRHIuIERhdmlkIEFsYW4gR2ls
YmVydCA8ZGF2ZUB0cmVibGlnLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEphZ2FubmF0aGFuIFJhbWFu
IDxqYWcucmFtYW5Ab3JhY2xlLmNvbT4NCg0KVGhhbmtzLCBEYXZlIQ0KDQo+IC0tLQ0KPiBody9y
ZW1vdGUvaW9odWIuYyAgICAgICAgIHwgMTMgLS0tLS0tLS0tLS0tLQ0KPiBpbmNsdWRlL2h3L3Jl
bW90ZS9pb2h1Yi5oIHwgIDEgLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2h3L3JlbW90ZS9pb2h1Yi5jIGIvaHcvcmVtb3RlL2lvaHViLmMN
Cj4gaW5kZXggNDBkZmVlNGJhZC4uOTg4ZDMyODVjYyAxMDA2NDQNCj4gLS0tIGEvaHcvcmVtb3Rl
L2lvaHViLmMNCj4gKysrIGIvaHcvcmVtb3RlL2lvaHViLmMNCj4gQEAgLTMzLDE5ICszMyw2IEBA
IHZvaWQgcmVtb3RlX2lvaHViX2luaXQoUmVtb3RlSU9IdWJTdGF0ZSAqaW9odWIpDQo+ICAgICB9
DQo+IH0NCj4gDQo+IC12b2lkIHJlbW90ZV9pb2h1Yl9maW5hbGl6ZShSZW1vdGVJT0h1YlN0YXRl
ICppb2h1YikNCj4gLXsNCj4gLSAgICBpbnQgcGlycTsNCj4gLQ0KPiAtICAgIGZvciAocGlycSA9
IDA7IHBpcnEgPCBSRU1PVEVfSU9IVUJfTkJfUElSUVM7IHBpcnErKykgew0KPiAtICAgICAgICBx
ZW11X3NldF9mZF9oYW5kbGVyKGV2ZW50X25vdGlmaWVyX2dldF9mZCgmaW9odWItPnJlc2FtcGxl
ZmRzW3BpcnFdKSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBOVUxMLCBO
VUxMKTsNCj4gLSAgICAgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmaW9odWItPmlycWZkc1tw
aXJxXSk7DQo+IC0gICAgICAgIGV2ZW50X25vdGlmaWVyX2NsZWFudXAoJmlvaHViLT5yZXNhbXBs
ZWZkc1twaXJxXSk7DQo+IC0gICAgICAgIHFlbXVfbXV0ZXhfZGVzdHJveSgmaW9odWItPmlycV9s
ZXZlbF9sb2NrW3BpcnFdKTsNCj4gLSAgICB9DQo+IC19DQo+IC0NCj4gaW50IHJlbW90ZV9pb2h1
Yl9tYXBfaXJxKFBDSURldmljZSAqcGNpX2RldiwgaW50IGludHgpDQo+IHsNCj4gICAgIHJldHVy
biBwY2lfZGV2LT5kZXZmbjsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcmVtb3RlL2lvaHVi
LmggYi9pbmNsdWRlL2h3L3JlbW90ZS9pb2h1Yi5oDQo+IGluZGV4IDZhODQ0NGY5YTkuLjA5ZWU2
Yzc3YjYgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvcmVtb3RlL2lvaHViLmgNCj4gKysrIGIv
aW5jbHVkZS9ody9yZW1vdGUvaW9odWIuaA0KPiBAQCAtMzcsNiArMzcsNSBAQCB2b2lkIHJlbW90
ZV9pb2h1Yl9zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IHBpcnEsIGludCBsZXZlbCk7DQo+IHZv
aWQgcHJvY2Vzc19zZXRfaXJxZmRfbXNnKFBDSURldmljZSAqcGNpX2RldiwgTVBRZW11TXNnICpt
c2cpOw0KPiANCj4gdm9pZCByZW1vdGVfaW9odWJfaW5pdChSZW1vdGVJT0h1YlN0YXRlICppb2h1
Yik7DQo+IC12b2lkIHJlbW90ZV9pb2h1Yl9maW5hbGl6ZShSZW1vdGVJT0h1YlN0YXRlICppb2h1
Yik7DQo+IA0KPiAjZW5kaWYNCj4gLS0NCj4gMi40Ni4xDQo+IA0K

