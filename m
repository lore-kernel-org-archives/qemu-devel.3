Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC24D1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37KT-0001O1-0o; Tue, 22 Oct 2024 01:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t37KQ-0001NO-Q2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:21:10 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t37KO-0003tw-RL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1729574469; x=1761110469;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qmy6c4O5Dx0MGWB/1+FclqLjCFaMcdsFbYevGdiOuaQ=;
 b=LO6IwQ15HMkrOU764VVJwp8e9QPHISAAfBTazO/48eGs52wL7vPeZiyP
 QU7dA1cd3HTxBDopoRcCHBy1Ajd7ylE+wpKbSphG24WY6ooaAfa3O9afk
 KerhR/OfxdlFkd+99hrAC7dlUunkAFC0ZYBq1VRAlz36zjivoPmLRoJh6
 lsbpki8Z5ILIm9ozP/FCy5v02Y4d0JR9pGBOrsus+WmkNsu8bcKpat9mg
 QJO/yWyIGxcoq3AVYEU7oV1cuYkZS+r+jeyVJiF8ku1jWf0qChikKwgWf
 x9DjHMSlUdhvOVWE4IqNBYTw7ielCH10D1DN7h3IZwRp7FzO7g3phjeZX g==;
X-IronPort-AV: E=Sophos;i="6.11,222,1725314400"; d="scan'208";a="23253370"
X-MGA-submission: =?us-ascii?q?MDHK8fvfNNEFYtyu1olv7gASfTPuTcT+JjEu72?=
 =?us-ascii?q?L4gdTrigGho9Ahbqz4qU289Yy1U86sjME2VwVH60/DpnEikpPSOsIBIf?=
 =?us-ascii?q?vWuLI03XbqGUdH8ZlDwDHHWMHTE8oApkbASV2/eOW5FTwfC4VWumpEjj?=
 =?us-ascii?q?qx910CefVH07y94gtebvPI7w=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 07:21:04 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxFHK8xdB/m2EVCQLiykKWU26khxSYnWe/CI9xeXxt+DN0yaRsfGBr3h1dcPRUN0cLnjUBrGMwdBtg+kG1Fu/7ZJPrgrVAHMoyeapb8WjczajxfHBrCQRriUJw9nST+x7ebC8Hnjg4+sF4qr0Ukd7DQeD99xZ7Nr3Tu4iX4U/G7hlICs4tECqOR/tKVqoq8DPd8OJERmLvTmsxIwkGx3e9MjhtvR9tCqaRmC7eJuGgWXqY76tAY6Tn9Sqs4JxC2olr4n8tqQhHN5YaTcZhgVURerbsAFidAnnYV2r5ofuGIrFv2YI7MwIe3fFUEn9oe7f1eVCi2dobgTNTyhK3+1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmy6c4O5Dx0MGWB/1+FclqLjCFaMcdsFbYevGdiOuaQ=;
 b=IIdZy1f+NXzmXPWi1HTh1TwyQrpRESMZZJf8ecyhGPfnthYE8DjDxdvUbK3lV+1oYrPsBcNj5TFfJdensFy7s0sQl1vllF/caQ95i2VYKtyBBwgTgt7yhWRRELRc5E1ZpFfTGVV2yjiVEpycKs2Qvdcsq0CdhJlafMf/OvisWPYMgWNdJNz0hE1pQ0KABL5Tjw/0SsxHKXj4Twk7ANlhR3KfgaYqJRa5TTUwW9yNVIbtTIEwBuXvx+4pPEg29MSxkKj0rqwOeRcLQhCExzY65UK8EGtobSGz/jIFFbtr4j2Yjsc/fB48ERuz+Fl0jekNcVnaFAfvquz7n0Ehz7njlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmy6c4O5Dx0MGWB/1+FclqLjCFaMcdsFbYevGdiOuaQ=;
 b=AjZwex1+wFWOwdJ6iPUkBXTtGLNAL4pepg2FY1aBmQO5fC2WjUwrGNfpUssSmFiqSIIBpAk07gpm5SMQas3GBRboytd704TaNdGNikKf+KJ+MsE01IYtQjKizUFYZR7oSRYrsby1kr1ijJfJiV6oflod6dtnC9p9kR4wfQICa/dXvk7PXuBGWMo8HxMtoigrsNLKZ8Rjt8tsBI9Du0r5uhikDKghTSHdKBUA6lgDplyXnBfvO3857oIp2RmHkUW2CWvzDICqLJfp0a2jYMjzpKmiL35i/iXJfNgr+hT0zzhabK9xSNKlujtGENepQh/ujrzveAEsZqV4kjX9BMR1Jw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV2PR07MB8986.eurprd07.prod.outlook.com (2603:10a6:150:b1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:21:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:21:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Roman Penyaev <r.peniaev@gmail.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/8] chardev/mux: use bool type for `linestart` and
 `term_got_escape`
Thread-Topic: [PATCH v2 3/8] chardev/mux: use bool type for `linestart` and
 `term_got_escape`
Thread-Index: AQHbHk1/nAoZjLsZKkmtEpICiby2VLKSR8KA
Date: Tue, 22 Oct 2024 05:21:03 +0000
Message-ID: <12bfd341-a00b-4e67-9f05-3ebb508ce5c2@eviden.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
 <20241014152408.427700-4-r.peniaev@gmail.com>
In-Reply-To: <20241014152408.427700-4-r.peniaev@gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV2PR07MB8986:EE_
x-ms-office365-filtering-correlation-id: b6a1acbc-7bfe-4b46-0b00-08dcf259528a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEdDenVEVmdoRVpZa1Zodm0zOFRDTUhvNWpqNzhNNCtUdGpoVDFCL3hqYUtC?=
 =?utf-8?B?Um05ODR0a05XV0tIZTVWOGVkck9ISUl5em5nVlA0aWJINkpzaGpWSDRsZU01?=
 =?utf-8?B?ZjV4QWdtSGx6RWtTQXBpQ21XNnhDdVY2czZldU1OZnZLYlZ0dUJFUExGTnRk?=
 =?utf-8?B?SmtlbEhTZnNJK0Z2VGhoWDNzUXNZUGVBRVFUemJOdWtQOFVoZkdQakNqZ3pW?=
 =?utf-8?B?ODZQbklHc21GUmVkb1R0bU80dDhYajlPVkU2WndHaUo5L2VjY0pWN09jM0Vw?=
 =?utf-8?B?cDc2bzJGL3B6UjYzc2FEOVNoRURFcDJCSXpMYUZ1eTQva2hTRmJKbUE0bkl2?=
 =?utf-8?B?dG83b2w3L2M4QjNYZktPMDRhU0xabzZZeVlPNFIrcVVFUXVraG1kTWhZOTdC?=
 =?utf-8?B?bi8xaWVka1M0OGtabkttZkoxZnprK01wck5zOWpiWXc2U2VJQy8yWE1NRjNr?=
 =?utf-8?B?TG00YlRaR3BRbW5QWXp0Tkd1VXNDbklNWUlFQytPMjduRG5tSHB0Q3NHUUpa?=
 =?utf-8?B?QmhZb3pORy9SR3J5MCtveU1nOGhGVS9RQjBXVG9waXAzWS82WCt3R2pmcmxT?=
 =?utf-8?B?dGpibmdlTEtheGQ1Z0dXNFpxdmNNeTFkNFV4aGwrSmVTV05PRlhIZmhwQjFh?=
 =?utf-8?B?MGNmZVNON1dNcitUQmJBb250VkNYWmQwSkZTbkJUU2ROZzNmK01hOWk0S3Fu?=
 =?utf-8?B?L01VMVk1clpGeU41Z25raDMvVWlUc0tBY3prUmxwUytURSttTHJIeW5icmxV?=
 =?utf-8?B?OGpYN2IxYzBtcG5uMlJFTS8zT1VjS2thRmNBa2RSLzVvWFoxam5DUnYxaTU4?=
 =?utf-8?B?R2NQU1N6cGVrd0EwLy9lT2s3ZHUzQ0lVcG1KUWJld1lSUGpndGxKSkJhc01G?=
 =?utf-8?B?dU5FY0VUVm9ibXg2azYwWUwxR1BaYThybVVibTBtSE1Gc1d4MStFZFFpeWIz?=
 =?utf-8?B?VU5odkptRjdOL3ZLKzByZE1FYXRrSTBReTN2Q2h5ZDZtN1J5Snl4cTR0SDRX?=
 =?utf-8?B?RFluUGcxa0t1dnl4SWJmSDl2KzR4Z25wZHBjYTJhdHdzaXhmWkNsTWZucVpm?=
 =?utf-8?B?WGtBM2dISFRJaWI5N25Eb0h6MjhPR2RVSTRYZ3VOTXNSeFZvMmpuZU9kN0dq?=
 =?utf-8?B?SUh6d1hkeUxTM1RWQ0ExZ0JFV1g4NzdQYUVQUi81WklwRlhwYWVHcDlYWGhS?=
 =?utf-8?B?YUVKa29ldXNoQXYwSE41VjNKYm9lclNwQU95TjZ4bVFGTlBWdnBZbXpFbU9T?=
 =?utf-8?B?UHRvR1Q1M0NYM051cGNQS2E2MVFBNjRWdTBlWHpTVmZXSjFUeHJwVklZbnhY?=
 =?utf-8?B?cndBeFZhVTBQa1B2a1IwdS9RUGZWOWhIaTY5UWduK3RVS0dqeXIxL0VIZ0N1?=
 =?utf-8?B?MWlEcHpLS2FYMG5pbml1dUFwbDB3YnZTTXV5aE1QMG9kOE5vV2lGL1pBYld5?=
 =?utf-8?B?T1FrTDdFUEZOZUxSUE8wTEFCR3RKMGFCUHlVNEZFZHFpQzVzcGRDWXN1bkRO?=
 =?utf-8?B?bjR3akt5dWwvYS9UaEFEcElLdU9wUFZad2VFWUZpR2t1NHp1Y3lmckhLOTgv?=
 =?utf-8?B?WXpCVjVjcVU4OTc3czZnSWs3ZlM1MGF4VktCSGRsRUtsdW9pbG8ybGRzNzZp?=
 =?utf-8?B?UTVnUU5XTFY5SzE1RURnUkZUbktPQkpWZk40b1lXZk5XK1R0MythQUJXc0Y3?=
 =?utf-8?B?TWMxV2RYQ0J4Ulp0WldVdWlqaEd3YjNCRDU5aHFwYUZsZGtkcG05b0Rva0dz?=
 =?utf-8?B?dmxOemhJdXJzWjROdzRuUmlWMlI3aHA3WEJrYkkwbmx5RFZ1akNnSEJYb0hz?=
 =?utf-8?Q?Wvi+0ZPUv8KSM7th29dV8sRa/+Qp5nUyInDmI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE5pUnpDT0lhb0pJalB5bXg2TTRXL1hsOWlYcFAxMmpzS1o5aytudTc2WXYv?=
 =?utf-8?B?T3hLUURydVc5WTNUR3IxSmtWN0gxTFpiLzdCeUdsLzJrc09iNzhRQkxBTzdo?=
 =?utf-8?B?b2dEZzVWejViQlo3emF5OVYzajk1Y1BJcWQ4OFd2cC9Hb1YyTks1YktjcFUv?=
 =?utf-8?B?eWZOejFVWXR0MjI4WXkvVW5tdkFZWnY4TjNvcUo0S05VdVp1ZlJTU0NYczFD?=
 =?utf-8?B?bmlzc3hOSmJOc0JzUDZiQ0x2QjllOEFyTVlxVzJycjJVdk9veTN6emJ3My9L?=
 =?utf-8?B?N1dLc21OMGxEaURtRTJuYWhXUDJHWmxkdTg0TEtVSEc0ZGhOYjJNdEpsM2Rn?=
 =?utf-8?B?bGtSL3kzK1pPRitEY0lDVlpxcXF2Nm0vVHpwUXpoUjY5S1ZPbmxpclRBSFZZ?=
 =?utf-8?B?SnNvT2Fnc1NhL0JHUTQxc1JoY1gyQ0E5ZjlUMWdkNDlhMmVFNC9xK041RXNR?=
 =?utf-8?B?cEhjenNWTUNpejJLMUhoNEVHSXFqS2Vyd1BnVjlqRHk5cWlucmhTUjZFWndS?=
 =?utf-8?B?Y0NBblExSjRsTC9sTEpsQTQzbGpCdW9GQmh0SGVxZFFudjdsbEdIUkZwenlU?=
 =?utf-8?B?ekFFRFNFUDNSeE4ra1RqRTRuU1RwUExwa216cCtJSWs3aFpIMzdUVVNnQ1J4?=
 =?utf-8?B?M3laY1orWmV1djk0dGE2N25GUTlGWk9xeDRzNHk0dnFHajViL1MrVmZtazJq?=
 =?utf-8?B?WTZseHU0MjZHWEljWHZ5ZUxQRjFOa041eXZaZDhLZktrY0xSL0JNQU9FYzFh?=
 =?utf-8?B?RWRNUFVTSHhDMWdnbkdtUm5HT1FKQkpZU0VMdko4TTluSE92NWRFTG5SZEhZ?=
 =?utf-8?B?UTdkZ0pNbjJDRXgrbnRzZ1l3dmdBY0didWFNSTJ3dStaSVp5VGFYWGl4RDFn?=
 =?utf-8?B?NjJoTDBEYStBT1hhSzdSNlBSQkpLVnE0TStrYWRHL3NYUWl3QnFJV2FLSGp5?=
 =?utf-8?B?akFWYVpNdDNqd25vZjlpaXhsYXRhc3ZGZHRQNEd3emtPdjJmM0FhMjhidERK?=
 =?utf-8?B?UGhyY1NwOElJTGtwNW4vT2d5SlQzVmRGMUxLNjVFZXVuYlZCeThsRFF6T3Y5?=
 =?utf-8?B?OUVsbU4vNmtQY1ZEdEhYSm55RnVVNGM0TUpULzZQVjJRRENJQ1BzZUFRK3p5?=
 =?utf-8?B?TFNTbXJJaU1yWXZEZjRLNmVBRUV1KzhYMFRnL25aRkJZMWhoMEtWVmUwaFI2?=
 =?utf-8?B?bW9FN2Q5bXY0MElZeTFXRnNyOGl6RkZTS0RZNDV0c1hCcCt6dndjOCtPdXk4?=
 =?utf-8?B?SHoraEMzaGdVUXFpVk1kNWlTZDd1K3ErZjN0RERjbUgrK0dIYm96aDJXZUhY?=
 =?utf-8?B?UkxPcldlSlZ4aWVBS015T2h5dVRVMStjb2VPcEd1eGV0L3hZTzhoMnJvOEww?=
 =?utf-8?B?bGl3bWRXekl5dkRjTDZKYmNXZ0VMYlh2aGszSXlsS3E0NWhmZDNZRkhOTTQ3?=
 =?utf-8?B?UHowMHBOdExNSXkzRUYxaDBCeGRWTk1ITDZES0JzWThNSkloVnZ0cDdRU1VN?=
 =?utf-8?B?MVZCemtPQTZ1dVBNTGFWRTE0cU1qNXd2eHpvTHFmVEI1VS9pcXNpdnY4RlFF?=
 =?utf-8?B?N3p6UFRBaFBiclkwdForWDgzcVJCZmtLRDFSMmJCS0wrUnZyL1l6M05nOXhR?=
 =?utf-8?B?WG9Ca1RudTFHc0lsN0RodStoVkIzcUM5a2lFdTduOGJsTDZGNTdjWHF2M0JS?=
 =?utf-8?B?eHQ1NlB0aWZUWDhOZDVjZlVzd3phNFpmcFIzZDNETU16MzZKYStvNW52SXp3?=
 =?utf-8?B?cnBLSHRscVJEd3VtUG9FcFRNb0lCS0dvYXgvSVhFYUxoZ2l1ck9JZ0tldkhD?=
 =?utf-8?B?ektEQ3FJVmNhbldjL3dHU2lITlpmQkI0YjVhTzFlbkNrNnU5czV4QnVGUzUw?=
 =?utf-8?B?Z0dOY0o1NXV6NGIwWldWeTduMEpTRnZUVXNSR1VUS3Z0bVcrM2JESVVMeldo?=
 =?utf-8?B?NzBnYlNzOWlPYnpQVGh6ZFJmajhVaUp3NnBSaUkvQ3BYaTBTMzhFbXJYbHlE?=
 =?utf-8?B?RnhWT1IzbFJJekRyYWRMbCtXNUFxMDhaVXhQOGNjaDVpaFMxWXJYd1pUWlp6?=
 =?utf-8?B?WE9FTncraFEvU3g5cG83S28rbDlxd3hjWVZaODV6aUdBeWkxS3RMYXR3ZUlw?=
 =?utf-8?B?dENVNTNkUm9DUks4R0V6NDBqS0pBQjBkVmlzRkt0T1RSY2wyR3NvdXJPc0kr?=
 =?utf-8?Q?B1TXjz4Fb2X0p31stPkLO/o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C963812731E114480DCDABF400DEEB4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a1acbc-7bfe-4b46-0b00-08dcf259528a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 05:21:03.0125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeiavvWcR2G/EwsV4mZb7K/57djx+0UQy5A9DSPs9Lum0XRhWTjatUQoJC2yq5o1rBV4+3BrcbZAhTn3HxdsGNQncPd783QLOs0/X0xgSCcZsv4cVlueWS7quVGAGDcA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8986
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tPg0KDQoNCk9uIDE0LzEwLzIwMjQgMTc6MjQsIFJvbWFuIFBlbnlhZXYgd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gVGhvc2UgYXJlIGJv
b2xlYW4gdmFyaWFibGVzLCBub3Qgc2lnbmVkIGludGVnZXJzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBSb21hbiBQZW55YWV2IDxyLnBlbmlhZXZAZ21haWwuY29tPg0KPiBDYzogIk1hcmMtQW5kcsOp
IEx1cmVhdSIgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KPiAtLS0NCj4gICBjaGFyZGV2L2NoYXItbXV4LmMgICAgICAgICB8IDEwICsr
KysrLS0tLS0NCj4gICBjaGFyZGV2L2NoYXJkZXYtaW50ZXJuYWwuaCB8ICA0ICsrLS0NCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2NoYXJkZXYvY2hhci1tdXguYyBiL2NoYXJkZXYvY2hhci1tdXguYw0KPiBpbmRl
eCBlZTJkNDdiMjBkOWIuLjcyODU5NmM2ZjM0NiAxMDA2NDQNCj4gLS0tIGEvY2hhcmRldi9jaGFy
LW11eC5jDQo+ICsrKyBiL2NoYXJkZXYvY2hhci1tdXguYw0KPiBAQCAtNzMsMTEgKzczLDExIEBA
IHN0YXRpYyBpbnQgbXV4X2Nocl93cml0ZShDaGFyZGV2ICpjaHIsIGNvbnN0IHVpbnQ4X3QgKmJ1
ZiwgaW50IGxlbikNCj4gICAgICAgICAgICAgICAgICAgICogcWVtdV9jaHJfZmVfd3JpdGUgYW5k
IGJhY2tncm91bmQgSS9PIGNhbGxiYWNrcyAqLw0KPiAgICAgICAgICAgICAgICAgICBxZW11X2No
cl9mZV93cml0ZV9hbGwoJmQtPmNociwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICh1aW50OF90ICopYnVmMSwgc3RybGVuKGJ1ZjEpKTsNCj4gLSAgICAgICAgICAg
ICAgICBkLT5saW5lc3RhcnQgPSAwOw0KPiArICAgICAgICAgICAgICAgIGQtPmxpbmVzdGFydCA9
IGZhbHNlOw0KPiAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICByZXQgKz0gcWVtdV9j
aHJfZmVfd3JpdGUoJmQtPmNociwgYnVmICsgaSwgMSk7DQo+ICAgICAgICAgICAgICAgaWYgKGJ1
ZltpXSA9PSAnXG4nKSB7DQo+IC0gICAgICAgICAgICAgICAgZC0+bGluZXN0YXJ0ID0gMTsNCj4g
KyAgICAgICAgICAgICAgICBkLT5saW5lc3RhcnQgPSB0cnVlOw0KPiAgICAgICAgICAgICAgIH0N
Cj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiBAQCAtMTQ1LDcgKzE0NSw3IEBAIHN0YXRpYyB2
b2lkIG11eF9jaHJfYmVfZXZlbnQoQ2hhcmRldiAqY2hyLCBRRU1VQ2hyRXZlbnQgZXZlbnQpDQo+
ICAgc3RhdGljIGludCBtdXhfcHJvY19ieXRlKENoYXJkZXYgKmNociwgTXV4Q2hhcmRldiAqZCwg
aW50IGNoKQ0KPiAgIHsNCj4gICAgICAgaWYgKGQtPnRlcm1fZ290X2VzY2FwZSkgew0KPiAtICAg
ICAgICBkLT50ZXJtX2dvdF9lc2NhcGUgPSAwOw0KPiArICAgICAgICBkLT50ZXJtX2dvdF9lc2Nh
cGUgPSBmYWxzZTsNCj4gICAgICAgICAgIGlmIChjaCA9PSB0ZXJtX2VzY2FwZV9jaGFyKSB7DQo+
ICAgICAgICAgICAgICAgZ290byBzZW5kX2NoYXI7DQo+ICAgICAgICAgICB9DQo+IEBAIC0xNzUs
MTEgKzE3NSwxMSBAQCBzdGF0aWMgaW50IG11eF9wcm9jX2J5dGUoQ2hhcmRldiAqY2hyLCBNdXhD
aGFyZGV2ICpkLCBpbnQgY2gpDQo+ICAgICAgICAgICBjYXNlICd0JzoNCj4gICAgICAgICAgICAg
ICBkLT50aW1lc3RhbXBzID0gIWQtPnRpbWVzdGFtcHM7DQo+ICAgICAgICAgICAgICAgZC0+dGlt
ZXN0YW1wc19zdGFydCA9IC0xOw0KPiAtICAgICAgICAgICAgZC0+bGluZXN0YXJ0ID0gMDsNCj4g
KyAgICAgICAgICAgIGQtPmxpbmVzdGFydCA9IGZhbHNlOw0KPiAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9IGVsc2UgaWYgKGNoID09IHRlcm1fZXNjYXBlX2No
YXIpIHsNCj4gLSAgICAgICAgZC0+dGVybV9nb3RfZXNjYXBlID0gMTsNCj4gKyAgICAgICAgZC0+
dGVybV9nb3RfZXNjYXBlID0gdHJ1ZTsNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgc2VuZF9j
aGFyOg0KPiAgICAgICAgICAgcmV0dXJuIDE7DQo+IGRpZmYgLS1naXQgYS9jaGFyZGV2L2NoYXJk
ZXYtaW50ZXJuYWwuaCBiL2NoYXJkZXYvY2hhcmRldi1pbnRlcm5hbC5oDQo+IGluZGV4IGMzMDI0
YjUxZmRkYS4uOTc1YzE2ZGU4MDNlIDEwMDY0NA0KPiAtLS0gYS9jaGFyZGV2L2NoYXJkZXYtaW50
ZXJuYWwuaA0KPiArKysgYi9jaGFyZGV2L2NoYXJkZXYtaW50ZXJuYWwuaA0KPiBAQCAtMzksNyAr
MzksNyBAQCBzdHJ1Y3QgTXV4Q2hhcmRldiB7DQo+ICAgICAgIENoYXJCYWNrZW5kIGNocjsNCj4g
ICAgICAgaW50IGZvY3VzOw0KPiAgICAgICBpbnQgbXV4X2NudDsNCj4gLSAgICBpbnQgdGVybV9n
b3RfZXNjYXBlOw0KPiArICAgIGJvb2wgdGVybV9nb3RfZXNjYXBlOw0KPiAgICAgICAvKiBJbnRl
cm1lZGlhdGUgaW5wdXQgYnVmZmVyIGNhdGNoZXMgZXNjYXBlIHNlcXVlbmNlcyBldmVuIGlmIHRo
ZQ0KPiAgICAgICAgICBjdXJyZW50bHkgYWN0aXZlIGRldmljZSBpcyBub3QgYWNjZXB0aW5nIGFu
eSBpbnB1dCAtIGJ1dCBvbmx5IHVudGlsIGl0DQo+ICAgICAgICAgIGlzIGZ1bGwgYXMgd2VsbC4g
Ki8NCj4gQEAgLTQ5LDcgKzQ5LDcgQEAgc3RydWN0IE11eENoYXJkZXYgew0KPiAgICAgICBpbnQg
dGltZXN0YW1wczsNCj4NCj4gICAgICAgLyogUHJvdGVjdGVkIGJ5IHRoZSBDaGFyZGV2IGNocl93
cml0ZV9sb2NrLiAgKi8NCj4gLSAgICBpbnQgbGluZXN0YXJ0Ow0KPiArICAgIGJvb2wgbGluZXN0
YXJ0Ow0KPiAgICAgICBpbnQ2NF90IHRpbWVzdGFtcHNfc3RhcnQ7DQo+ICAgfTsNCj4gICB0eXBl
ZGVmIHN0cnVjdCBNdXhDaGFyZGV2IE11eENoYXJkZXY7DQo+IC0tDQo+IDIuMzQuMQ0KPg0KPg0K

