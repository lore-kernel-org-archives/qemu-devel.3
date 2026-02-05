Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE5EA794D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vno1v-00073Y-9z; Wed, 04 Feb 2026 20:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vno1t-00073E-3D; Wed, 04 Feb 2026 20:19:33 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vno1q-0004lW-4d; Wed, 04 Feb 2026 20:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUj065zGyPK4SYNFAki7ftlwDtsRIluHsZpcsdtouxITnBOCIhDHFC7fUFBVtXVFMzawDqH6+lfnyjLDb5AaJ5/YXiqzx77klgfkCWsJKg5cKrr4gYSB77g/Wnj/8H6sLFLMsCnJRtpaL4Gg9n1NjfcnLkBMTEx++jhxdhWpW/glepOjgxpW5aCNsQwBkLCP7QMqT3eV3bdjKcAjhYSezDZ4v6VrLlPzyHivBbz/iQ4CFV2i7XW2X2iINvLWTBeqyrRdvVCwFf5ven4NYjWbJVuspNh10/VQBPau1xXKNdboEw8ZQUIjAiW4MJAQ2Rb9ED1xwMeEm/QhZwJEuYLArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj+Q9+IUqyDxu0lix1bJIJO7Ht4/E+2N2nBvPvuI3i0=;
 b=LAsUh7FyolF0dQi2AQkGBuXxJgUc4JGsJ0Li2iULQXQZB6KJIZCG6UBqYa34FBr97YfiXT2hCaIRRQy/rjnqmNmU4w9KVNJsExMq36gwL24s5NY8FfPEhz4U99BUoWV5wfI5mNGP7k1txchLX8fZGZZvcroYVCGHLCnUuYFeTCDuXGg3z5n0fSyEsUSq38eahE4poBbqzyEO9TVvMcU5K5ZbVvhS8W7EuxrpigHOmWJthn2y87M2tcLP0oFhlT546ZBMZrtoIG7lZ5PFrLfv0JUCKuJZMoqeznQ46fNAOqv8qhM9gOTKCz1DVvm6KAX5EA4DflgI4kyCD4TWhejx9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj+Q9+IUqyDxu0lix1bJIJO7Ht4/E+2N2nBvPvuI3i0=;
 b=nieGvgqWrZC+KDmYA7TJ2jwluvyBM+ILmc71F4nWDgQaue+NWzVbftW75tcfMlyoeW4HSr0AtusxAjUAwTijabu320367OGFOkeyW9TYguH5Eo9BYWiIoEaK08GL6e1IMPwxT+qm1y9k/oCnCXi3AIxyj2rS9toTbLa1UX/idmxYwVeSbWO7omB4I1NM0IubaWZRrom0cdfWLqs4K9WQGHd+Sa8d2ILjwD4SQrCuD4dwjnh+gM5shom710VVy8UqLsai45GrDUSJDSvaPrJAecvZ2BQ1qc/vT8nU0hRHynLgPc9kKwhkqdTderyRnMqGmNn6KBknIBhbI+nAc/XnoQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6213.apcprd06.prod.outlook.com (2603:1096:400:33f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 01:19:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 01:19:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, "komlodi@google.com"
 <komlodi@google.com>, "nabihestefan@google.com" <nabihestefan@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v2 00/20] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v2 00/20] i3c: aspeed: Add I3C support
Thread-Index: AQHclOpwDYCOcAXTnkyCFQZNvidrErVyX2KAgADxZCA=
Date: Thu, 5 Feb 2026 01:19:17 +0000
Message-ID: <TYPPR06MB820658FF127E955B277A822DFC99A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
 <242b711e-d668-4278-a990-59921101bef3@kaod.org>
In-Reply-To: <242b711e-d668-4278-a990-59921101bef3@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6213:EE_
x-ms-office365-filtering-correlation-id: cabb7f9a-9e81-4960-f322-08de64549579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?TC94WVBtSXp2aXJFNEwxd1lzeTVzb2JhbGVTd3pJMVB5UzVzQ2E3WnFEQzBh?=
 =?utf-8?B?dW5OU3NBell4MkJ2ZjdZWVk1ZFMweVhpTzgyaWlwWmpJVEM0V2Z3SUpjcCs1?=
 =?utf-8?B?em8zYzlOam4ycHlhRVpEVXU3RXEva28wbTA3TFpRR2w2ZWM5RWZIalpZbnl2?=
 =?utf-8?B?K2F0V3ZyV0J6YVNKWVZCRzhsdURRMzVDeXN6alV5Q3BiSDMyWllxN1UzeC9C?=
 =?utf-8?B?N0llUG5UV042cXVFZE52YnJSQ05PL3JhNlRTM3MxSGlhWE84alhUOEtxdmpl?=
 =?utf-8?B?TGZzYUtjYXcrRUVYOHFOQmxHUkhFdjdaTG5QL0xyc3AySjkvQkNHS1dxUkJV?=
 =?utf-8?B?NGwvWGVsZ3FGaTJsUDVNMTEwMkVYTXdWMHo2Wi81RGVxYUhYUi83U0hHSkVx?=
 =?utf-8?B?MUtScVdRbVBoU2lwTWlPV0JRZlRZV3d1NzEydFJZSjFNMG1kaDNHZUFUUW9n?=
 =?utf-8?B?cEZVMGRLWERpVk9JU3hVakpXTXpNRXdjRGFkQzUydlBwM0p3SS9RaVFpUVZa?=
 =?utf-8?B?R3BWOUV4QlVQKzA4WHVGVDVwL3JPdzU3Y1Q2Y3c1bHJsZXozRnAxT3RzZDVt?=
 =?utf-8?B?VVRSRDRFWnVLYnNic2xhMlNXbU1qb3NrVElPZndBQVE2b2Eyd0tKL2NZMlQ5?=
 =?utf-8?B?d2ZCRnpUOTNrWUVud0JiejZvSVhJY09WNzdqZTdIcXo0akVteHp3M1ZiVU1U?=
 =?utf-8?B?cHhYRG5PZEhhWUZ2QVFxczFjTHZaTnF6VStGSXQwRXZDNzFrY1F6bnlnNVlH?=
 =?utf-8?B?cWZBb2JOMEloUmxsYnBEa0FwWFJOVUVsSHJaVjh2ekZQMnBqSktTSlZxMFhT?=
 =?utf-8?B?Ukx5WmlJQUx5R2pZaWtuOEFoY2JHSnQzbGZuSTJTMVJ3WFdIUmd2MFdNS2Fm?=
 =?utf-8?B?QTJDL0VwRjhRRHBEUG4vZkN3VHEvZktRUEFycVZWTUxhZDZEOXZnSE1ha2lM?=
 =?utf-8?B?U2w3dnNnU1BpbEtyYnF2cUtTNWdnNzNneWVEOCttbndBMXkwM3BKZFI3SXJQ?=
 =?utf-8?B?c0tITkhPQWNXQytLVk5pSDlnY2dkQytLbzlKclRPcmtaZG5LdXhjSThrc29T?=
 =?utf-8?B?WVRkdnZQdlZMSFdYSnorVVI0aWdXam1zenArTXpEYTk4NWdXVC9neWdMdWFh?=
 =?utf-8?B?d3NYdFd0MjdlbEwzUnJ5a0xIK2xpNXI3MVFOSTl2T3pTTUdkK2s0aHBLdUli?=
 =?utf-8?B?US9pZ0tEeHp2Yzd4RW55ZVZRSHZWYXljUE5reUVubWNEbmVFVktJcEYya003?=
 =?utf-8?B?SUpsWFJnMUdVUXdQZk1tQVo2bVFleS9yaVFBajg0TGN6TGZIU0ROcHM2bWxy?=
 =?utf-8?B?WVovNldFVlVnL3V5MHlkeEg4N3dVemh4c3c2bzFNdFVBSTZqb2xCdFU2aUNw?=
 =?utf-8?B?MEFNS0Q4M2JFSjZTb2JQUEU2czBPMytDdDlnaEJkN0ovUVNZUnVrbEZ3ekNP?=
 =?utf-8?B?ekVZMFdQSTA0eGQ5VTJNSE1EYXdZVXQyQ2wwU2J0SWM5dFJxNEJjSnFPZnNr?=
 =?utf-8?B?MHFhdUxta3NUL1l1VFBqUDNQeTFaY0lOVVM3K1l5NVRlbGpQYlVURVlVUkJH?=
 =?utf-8?B?bFRSZUF1S3lxMzFKRmFaalRDQkhkME14NGxidnNxVGtXTEkxYXBsSURwM01I?=
 =?utf-8?B?cWNPRjNpeCtFZTEvdVBKZ2ViVzduWUhOREJBVlB6Nk5YeFoyVU0zSFIyTXZS?=
 =?utf-8?B?M2NUWDlMMHBtUGp2L1I1dkttcGhQWjc5NWVYL0RzUlJTd0t6UVp6aDRzWVh3?=
 =?utf-8?B?NTdISk42dzIvd2FFMHJuREx2ZDI4RWRCaS9uQUdkRVNFT1FhUFNiU1Q3cVA4?=
 =?utf-8?B?ZVJueUxWREJHVzVCTkwzYmdxVHpIVVo3d2RRazV6Y1IvcEttbzBFSC91d1Zr?=
 =?utf-8?B?dThyU0l2dXhjZkV6aktXdzNSa0ZOUEd4NVk5VnQ3QUNIV01iLzMvS0NPQUNN?=
 =?utf-8?B?bktaM3RvczBTNTlrWDNaT3BCa0FPa2VQczhRN05uaHppZCtIQUU4OWoxZ1Ri?=
 =?utf-8?B?eVlsaGl5ZTlrYncyeEk2SXArK0YxNWFWOFptTVl5c3I2WFJZQUJ2S2NpaFN0?=
 =?utf-8?B?Y0tTOTFaSHVwVm8wZEdYdk9kZlh3Y1ZXNzVYcGhCQTZFQjUzamZ4SkJ6NmZZ?=
 =?utf-8?B?QnoweEJkZlphNFlNWkRzMDFCODc3eHNSTkFvTWs4aXMrWUdPU3BVUW1hb1BT?=
 =?utf-8?Q?/e4lCrOb8gWgRQQCZ+0XMmEnNBMfHdIQIAXgGTsL1avA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUQ0Rjg0aWlGdTg2YnhsTkJrSStmQlRJa3lvQ3pRT2hmUDExaUZXc3lhTGFn?=
 =?utf-8?B?RmJYN2NQYXJnK2VkZGFUZEpFdWc4cWZPK3VXSE1ZcDU1V29BS3dqSUtEeWhR?=
 =?utf-8?B?bFFSTnJ1RUVoSXY0ZnlrK3MwQXVobExGZ2VkWk1kbm8yNnBXSDVPaU9sQmV3?=
 =?utf-8?B?eHEvS0UyZFVzQjNnaFBuVnlFYktvMHo3c3lrQWNKS28xS1g1Z0tGN09iZlBU?=
 =?utf-8?B?T3FoN0x3aGxxdEY0Nmp5ajU3b1hRS3RPVnU3VTlMSXhnUVhmYlV0NW80OWMz?=
 =?utf-8?B?UEZxbFliMGlVQnlSQXpIdHlSanlIQlQ2dy9veE5Vcit6Sm43MVBwOGlLT2VN?=
 =?utf-8?B?TVJhZnBMWXo4Rm03QnVUSGhsM3VjcmpBSi8vcURrNi8rM0dZUjJ3Mk5razRj?=
 =?utf-8?B?akZORG5TYm5yYUxDMk5mRlZxMDBTQWJoMmRUbXhVamhGNHlBUkxQTzFKMWlV?=
 =?utf-8?B?V3JramNmU1UrUzFNUGVybEFjcFFhTG12eERGQnBtcmV6UXRhVU50WE9ham5l?=
 =?utf-8?B?SngvcHprWjRha0ZKZnpNMjhoMEtLUXJxcStkaHUxbVVSYzF4L095d1NTamk2?=
 =?utf-8?B?ZEFtcDdPZ1R2OWRvZ3JhZC91dU56ZHV4bkQ2b2NNQW12WnptVW9STnZaMytr?=
 =?utf-8?B?VFJzUWZlRFE3U2lIbE1kcG9ZK2F0bzRSblovWXdicjNkMCtMamtHQjBSN3dW?=
 =?utf-8?B?d2pMOXZIMVhqUTY4OUlnS25NWGhWRXZ1cUE1TmI3Njk4TEJBL1BBQU1BWlFK?=
 =?utf-8?B?OWcyRjJScUZINDNFNzdOR2cvTnZZR2ZCRjdWQURsc1ZFdnZ5TkdzWjRmdC95?=
 =?utf-8?B?SjcwaGJ5WG90cXVWUzNQRU9qTXk0VXZqUTBlZHNiN1U0bDM0T050bi8yMmRN?=
 =?utf-8?B?bXlvNzZXL0ltZzZQTzR0UTRlM0tKTnpMaEsrRHU2OVdHSksveElmNkMxMU1z?=
 =?utf-8?B?WlM1cEloM0FOcUc4Y3F3OGVRV3dEUEJxUDYrb3pxT2NiY0QzRWNEb1Q3MG5m?=
 =?utf-8?B?MDBhdUJqZmI1aDZoSkZoY1BGTmZRM085djVNZnFqeWNPSFhzWWxXS0Y5Tzh6?=
 =?utf-8?B?RDBHREpadXNvVVFvbnVXMXFXQjVBaUxFZm93MHRVTmEwRmVzT2duSjd2RUt3?=
 =?utf-8?B?aW4yNTBDaG9NQnQzZWgxa21FMnZCM2M1a0tLRkY5WW10Nkt4d3lWbDZNKzFi?=
 =?utf-8?B?Y1pqcHA0eTQvNWlmT2VKZHp6MzdvNENTZnFhNTFKVlNFenRoUjZkQWJ5TFU4?=
 =?utf-8?B?cDdrOWtOYU5aNGF6NVAvd3g5eUQxVTRCb213OWt6d09Eckl4R1lpTjJXNkh2?=
 =?utf-8?B?cXFNU2RTN2hCRlRjd21MZzUzR3ZwakZ3WXlDVDJ0eVhLd1pwVVNOSjBocjJX?=
 =?utf-8?B?M2xRRUlOQVRuOUkybXpWNmcrV3ZnTTlENGJQUFlsRUNLa3l3STJZKzZEOHRC?=
 =?utf-8?B?dnRHUjcvelNsV0ZNYzJ4UU1lcEwwMkw3Qit2dmJVVHpaUDR3VVZ1VWg4S0hC?=
 =?utf-8?B?WXZJUE9sMkpSL3lRcEtEQ0YrNkZRaUVjYUg1Tkp0VmxuVXN6ckU5bC9yenBI?=
 =?utf-8?B?clZ6bmlUcDVtcE1kRHFVMzcrUnBMWlBwUmlpU0xERGV2RHYvU2g4VUJYWktm?=
 =?utf-8?B?aUY2T3RvZ3lFVklJS1NCek9GcmdkNEhBMGdrbnVBYk9iQ0lzc0o0eUJnQ3l2?=
 =?utf-8?B?aGF3QThQd3ZHeHY2U2lsalJUZnhwcGFoMUZpRW5nMTZWN2FMMmZJRFN1WlZs?=
 =?utf-8?B?Y21ibmFYbkNLSzRoaVFoOFhvT3VDOXNoMU5OMmFIVVZtYWJGQktGdUppa1Jz?=
 =?utf-8?B?ZlJLV1pNaVpXMjlCWVRDL2ExdUhUS0JTZURRcjUyMTlERDRZcVc2K01OVTVV?=
 =?utf-8?B?d1IvYUxtWXZuaUNDQ1VoUTB5aTI2VWdZNmJuNVgyQ25oU3cyZHJzRmN1cmt0?=
 =?utf-8?B?dkhnd0xNMjVKSGVXdy8zWG5FTGxtZFNTb29POVhDbzBjSGszZmwybmYralEx?=
 =?utf-8?B?WUFXVktmVm51bWRjdW96Tk1xbkxURkhqbnVKVU1kNzhIaW43QkQwM1A2Y3JH?=
 =?utf-8?B?dnNBSExwYjAvYWwyVjNMbllWUS93eXBuS0I0a1o4cXJnU3FXRGYvaHBFbzEx?=
 =?utf-8?B?MGFMWVllSWFBdlB2NWpwb0l5SEVWa1JNTThvUStPd1dqdTUxbWs0Rno4QjlU?=
 =?utf-8?B?S2h5SGpJZFZMZ0Vna09Qa05GV1RHTkpuaEtVTUxHajJNMnF2SDFjN0srRlJn?=
 =?utf-8?B?MmJXc1NYZlI4SFlTU1ZvTnZmNXJRY2VBaUttNUt4UFJSWnlFMlVWSkxqemxL?=
 =?utf-8?B?d3RvY0V1czNNTXUxZ1dNMFZqMlpFNzJWR01iUE1kNU11SzlJZU1pQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabb7f9a-9e81-4960-f322-08de64549579
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 01:19:18.0363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZs+m8WZlPIo5i/gnUAsNyhkPM9o7VDQ0GY7dMHtoEjzw5v3+2l4MhQ8Hdjn5tJSHAYikVt09MR2oJ8o73wj834JSCsstHMmLTp20ms/Wgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6213
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAwLzIwXSBpM2M6IGFzcGVl
ZDogQWRkIEkzQyBzdXBwb3J0DQo+IA0KPiBKYW1pbiwNCj4gDQo+IA0KPiBPbiAyLzMvMjYgMDk6
NTIsIEphbWluIExpbiB2aWEgcWVtdSBkZXZlbG9wbWVudCB3cm90ZToNCj4gPiB2MToNCj4gPiAg
ICBUaGUgaW5pdGlhbCBwYXRjaCBzZXJpZXMgd2FzIGJhc2VkIG9uIHdvcmsgYnkgSm9lIEtvbWxv
ZGkNCj4gPGtvbWxvZGlAZ29vZ2xlLmNvbT4uDQo+ID4NCj4gPiAgICBUaGlzIHNlcmllcyBhZGRz
IEkzQyBidXMgc3VwcG9ydCB0byBRRU1VIGFuZCBhZGRzIG1vcmUgZnVuY3Rpb25hbGl0eSB0bw0K
PiB0aGUNCj4gPiAgICBBc3BlZWQgSTNDIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiAgICBUaGlzIGlt
cGxlbWVudGF0aW9uIGlzIGEgYmFzaWMgaW1wbGVtZW50YXRpb24gdGhhdCBpbnRyb2R1Y2VzIElC
SXMNCj4gPiAgICAoaW5jbHVkaW5nIGhvdC1qb2luKSwgQ0NDcywgYW5kIFNEUiBkYXRhIHRyYW5z
ZmVyLiBBcy1pcywgaXQgZG9lc24ndCBzdXBwb3J0DQo+ID4gICAgbXVsdGktY29udHJvbGxlciBi
dXNlcyBvciBIRFIgdHJhbnNmZXJzLg0KPiA+DQo+ID4gICAgRmlyc3Qgd2UgYWRkIHRoZSBJM0Mg
YnVzIGFuZCBjb250cm9sbGVyIG1vZGVsLiBXaXRoIHRoYXQgYWRkZWQgd2UNCj4gZXh0ZW5kDQo+
ID4gICAgdGhlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIEFzcGVlZCBJM0MgY29udHJvbGxlciBzbyBp
dCBjYW4gZG8gdHJhbnNmZXJzDQo+ID4gICAgYW5kIGhhbmRsZSBJQklzLg0KPiA+DQo+ID4gICAg
TmV4dCwgd2UgYWRkIGEgbW9jayBJM0MgdGFyZ2V0LiBJdCdzIGludGVuZGVkIHRvIGJlIGEgdmVy
eSBzaW1wbGUgdGFyZ2V0DQo+ID4gICAganVzdCB0byB2ZXJpZnkgdGhhdCBJM0MgaXMgd29ya2lu
ZyBvbiB0aGUgZ3Vlc3QuIEludGVybmFsbHksIHdlJ3ZlIHVzZWQgaXQNCj4gPiAgICBvbiBMaW51
eCB0byB2ZXJpZnkgdGhhdCBpM0MgZGV2aWNlcyBjYW4gYmUgcHJvYmVkIGFuZCBjYW4gc2VuZC9y
ZWNlaXZlDQo+IGRhdGENCj4gPiAgICBhbmQgSUJJcy4NCj4gPiAgICBUaGlzIHRhcmdldCBpcyBz
b3J0IG9mIGxpa2UgYW4gRUVQUk9NLCBhbmQgaXQgY2FuIGFsc28gc2VuZCBJQklzIHVwb24NCj4g
PiAgICByZWNlcHRpb24gb2YgYSB1c2VyLWRlZmluZWQgbWFnaWMgbnVtYmVyLg0KPiA+DQo+ID4g
ICAgTGFzdGx5IHdlIGFkZCAgaG90cGx1Z2dpbmcgc3VwcG9ydC4gVGhlIGhvdHBsdWdnaW5nIGRv
ZXNuJ3QgZG8NCj4gYW55dGhpbmcgdG9vDQo+ID4gICAgY29tcGxpY2F0ZWQsIGl0IGp1c3QgYWRk
cyB0aGUgZGV2aWNlIGF0dGVtcHRpbmcgdG8gaG90cGx1ZyB0byB0aGUgYnVzLiBJdA0KPiA+ICAg
IGlzIHRoZSBkZXZpY2UncyByZXNwb25zaWJpbGl0eSB0byBob3Qtam9pbiBhbmQgZ28gdGhyb3Vn
aCB0aGUgREFBIHByb2Nlc3MNCj4gPiAgICB0byBwYXJ0aWNpcGF0ZSBvbiB0aGUgYnVzLg0KPiA+
DQo+ID4gdjI6DQo+ID4gICAgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+IGhh
cyB0YWtlbiBvd25lcnNoaXAgb2YgdGhlIEkzQw0KPiBwYXRjaA0KPiA+ICAgIHNlcmllcyBmb3Ig
dXBzdHJlYW0gc3VibWlzc2lvbi4NCj4gPg0KPiA+ICAgIENoYW5nZXMgaW4gdGhpcyB2ZXJzaW9u
IGluY2x1ZGU6DQo+ID4NCj4gPiAgICAxLiBBZGRlZCBJM0MgZnVuY3Rpb25hbCB0ZXN0cy4NCj4g
PiAgICAyLiBVcGRhdGVkIHBhdGNoIDQgdG8gcmVmaW5lIHJlZ2lzdGVyIGZpZWxkIGRlZmluaXRp
b25zLg0KPiA+ICAgIDMuIFVwZGF0ZWQgcGF0Y2ggNyB0byBjb3JyZWN0IHJlYWQtb25seSByZWdp
c3RlciBmaWVsZCBtYXNrcy4NCj4gPg0KPiA+IEphbWluIExpbiAoMSk6DQo+ID4gICAgdGVzdHMv
ZnVuY3Rpb25hbC9hcm0vdGVzdF9hc3BlZWRfYXN0MjYwMF9zZGs6IEFkZCBpM2MgZnVuY3Rpb25h
bA0KPiA+IHRlc3QNCj4gPg0KPiA+IEpvZSBLb21sb2RpICgxOSk6DQo+ID4gICAgaHcvbWlzYy9h
c3BlZWRfaTNjOiBNb3ZlIHRvIGkzYyBkaXJlY3RvcnkNCj4gPiAgICBody9pM2M6IEFkZCBidXMg
c3VwcG9ydA0KPiA+ICAgIGh3L2kzYzogU3BsaXQgRGVzaWduV2FyZSBJM0Mgb3V0IG9mIEFzcGVl
ZCBJM0MNCj4gPiAgICBody9pM2MvZHctaTNjOiBBZGQgbW9yZSByZWdpc3RlciBmaWVsZHMNCj4g
PiAgICBody9pM2MvYXNwZWVkX2kzYzogQWRkIG1vcmUgcmVnaXN0ZXIgZmllbGRzDQo+ID4gICAg
aHcvaTNjL2R3LWkzYzogQWRkIG1vcmUgcmVzZXQgdmFsdWVzDQo+ID4gICAgaHcvaTNjL2FzcGVl
ZF9pM2M6IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+ICAgIGh3L2kzYy9kdy1pM2M6
IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+ICAgIGh3L2kzYy9kdy1pM2M6IFRyZWF0
IG1vcmUgcmVnaXN0ZXJzIGFzIHJlYWQtYXMtemVybw0KPiA+ICAgIGh3L2kzYy9kdy1pM2M6IFVz
ZSAzMiBiaXRzIG9uIE1NSU8gd3JpdGVzDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIElSUSBN
TUlPIGJlaGF2aW9yDQo+ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIGRhdGEgVFggYW5kIFJYDQo+
ID4gICAgaHcvaTNjL2R3LWkzYzogQWRkIElCSSBoYW5kbGluZw0KPiA+ICAgIGh3L2kzYy9kdy1p
M2M6IEFkZCBjdHJsIE1NSU8gaGFuZGxpbmcNCj4gPiAgICBody9pM2MvZHctaTNjOiBBZGQgY29u
dHJvbGxlciByZXNldHMNCj4gPiAgICBody9pM2MvYXNwZWVkOiBBZGQgSTNDIGJ1cyBnZXQgZnVu
Y3Rpb24NCj4gPiAgICBody9pM2M6IEFkZCBNb2NrIHRhcmdldA0KPiA+ICAgIGh3L2FybS9hc3Bl
ZWQ6IEJ1aWxkIHdpdGggSTNDX0RFVklDRVMNCj4gPiAgICBody9pM2M6IEFkZCBob3RwbHVnIHN1
cHBvcnQNCj4gPg0KPiA+ICAgbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMSArDQo+ID4gICBody9pM2MvdHJhY2UuaCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAyICsNCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAg
ICAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4gPiAgIGluY2x1ZGUvaHcve21pc2MgPT4gaTNj
fS9hc3BlZWRfaTNjLmggICAgICAgICB8ICAgMjIgKy0NCj4gPiAgIGluY2x1ZGUvaHcvaTNjL2R3
LWkzYy5oICAgICAgICAgICAgICAgICAgICAgICB8ICAyMDEgKysNCj4gPiAgIGluY2x1ZGUvaHcv
aTNjL2kzYy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNzcgKysrDQo+ID4gICBpbmNs
dWRlL2h3L2kzYy9tb2NrLWkzYy10YXJnZXQuaCAgICAgICAgICAgICAgfCAgIDUyICsNCj4gPiAg
IGh3L2kzYy9hc3BlZWRfaTNjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNjEgKysr
DQo+ID4gICBody9pM2MvY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
NjY5ICsrKysrKw0KPiA+ICAgaHcvaTNjL2R3LWkzYy5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMTg2NA0KPiArKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvaTNjL21vY2staTNj
LXRhcmdldC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDMxMSArKysNCj4gPiAgIGh3L21pc2Mv
YXNwZWVkX2kzYy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzODMgLS0tLQ0KPiA+ICAg
aHcvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+
ID4gICBody9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAz
ICsNCj4gPiAgIGh3L2kzYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMTUgKw0KPiA+ICAgaHcvaTNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgNiArDQo+ID4gICBody9pM2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDQ3ICsNCj4gPiAgIGh3L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICAgaHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgMSAtDQo+ID4gICBody9taXNjL3RyYWNlLWV2ZW50cyAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2IC0NCj4gPiAgIC4uLi9mdW5jdGlvbmFsL2Fy
bS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nkay5weSB8ICAgMTIgKw0KPiA+ICAgMjEgZmlsZXMgY2hh
bmdlZCwgMzczMCBpbnNlcnRpb25zKCspLCA0MDcgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvaTNjL3RyYWNlLmgNCj4gPiAgIHJlbmFtZSBpbmNsdWRlL2h3L3ttaXNj
ID0+IGkzY30vYXNwZWVkX2kzYy5oICg2MyUpDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9ody9pM2MvZHctaTNjLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3
L2kzYy9pM2MuaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaTNjL21vY2st
aTNjLXRhcmdldC5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL2FzcGVlZF9pM2Mu
Yw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9jb3JlLmMNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBody9pM2MvZHctaTNjLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9p
M2MvbW9jay1pM2MtdGFyZ2V0LmMNCj4gPiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBody9taXNjL2Fz
cGVlZF9pM2MuYw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9LY29uZmlnDQo+ID4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL21lc29uLmJ1aWxkDQo+ID4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaHcvaTNjL3RyYWNlLWV2ZW50cw0KPiANCj4gDQo+IEkgZGlkbid0IHJlY2VpdmUg
ZGlyZWN0bHkgdGhpcyBzZXJpZXMuIFNvIEkgZ3JhYmJlZCBpdCBhcyBhIG1ib3ggZmlsZSBmcm9t
IGxvcmUuDQo+IENvdWxkIHlvdSBwbGVhc2UgY2hlY2sgd2l0aCBLYW5lIGhvdyBoZSBzZW5kcyBo
aXMgcGF0Y2hlcyA/DQo+IEFsbCBpcyBmaW5lIHdpdGggaGltLg0KPiANCj4gDQo+IFBsZWFzZSBh
ZGQgeW91ciBTaWduZWQtb2ZmLWJ5IHRvIHRoZSBzZXJpZXMuDQo+IA0KV2lsbCBhZGQgaW4gdjMu
DQpUaGFua3MtSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0K

