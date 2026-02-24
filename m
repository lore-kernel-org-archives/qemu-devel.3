Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B5EA4FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuog8-00008j-W8; Tue, 24 Feb 2026 04:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuofs-0008Qw-Tr; Tue, 24 Feb 2026 04:25:49 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vuofq-00066C-Gv; Tue, 24 Feb 2026 04:25:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZlWVV1fscwqjcc2F8NNvLuc1AFzfytKpxdJXy+zD5PDJoWlQxBrQtLcDOsmoiD/EidaXRHPZ3wcCC9YJfg/b9b2eJ7hb1nCxMudKeCbuhRj0AvFawzOrPKJ1z6Cflx0s36+BlCvcSzKXh3xvbald1Grk+VLok0jo3cob3b/gF81eYxqnq33IOqOGZNzH9tU/WWpA9Ldmrxkpp1SD6ORTldKIJccRnB99Vjee58iImEdPYhR9ZLdMYC0qOFBCdKuVcf3QVmjufzSFUFI9n/w9zVg+Ywafet1qeADDYWbockG9UrT8KrRB53U/WWfRKCLg5o6NYi7CqF11AQ8geYdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTYBsHPE0ievesmJKnBLlYehEryb3+5fX5rMrrw3a+s=;
 b=rWYIR2Qk5DzJ4G6c6R/I8RCUF+p8eYPIdCutNGvHOamljGRledN9JH+Zq6FUjZo4venbwZa228wBASYehASBogdNXLISkqwpdykEErTY2WxShmLDR3+UidjF+ZMYCCyWoOxGKGGPaG4nqEmfFkk1bGMErgCMNgiv7CJEJ6XfB74wG2PELCM9qN0eM1aQTawKd6Sa6G4qn88sn4ePjrlxMAWdwzzInNXRx/NOztuUVUWXIO5Ll3MgPymXjTsKoKC7DCtytqdqFwoVGCpLLmQJNeG8NV2v6bUOeVx+NVJckt7PZgvVN8Dh3q6L0+ql/Ql6duDAhuOx8UqtYA4otYN8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTYBsHPE0ievesmJKnBLlYehEryb3+5fX5rMrrw3a+s=;
 b=KwvZ3nzmdNM68n6K8CZdyrLnBY3fylmHnZQET2IinyNVtaPzR6nkZcTH7KNiWa4HgWHODsbUTgrcgjfhJ+K2bcGF6fOhYtkmPuc68GShJu92ni8pgZqzKZP9x4kYB6NHssEydjaeWU5UojzdYei+wpVASNSHIhIJPmH8E0J1QKEVf4uVQpIrQqyhixgz6LuI28Mn2+7G+MzKt/B8qwtmBEdZox83e7YAPxAJfblhcL/nQSsONOsB38zc5v8Y821qArTDpNogHF+zJ9fc4RNgRbppVq558KCjopyzDk/dTPuqwOCyUuhu+EpNjr+ZTUlEvTDgZRhOvxXjA2h9TCdPsg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6335.apcprd06.prod.outlook.com (2603:1096:101:13c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 09:25:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:25:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
Subject: RE: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Index: AQHcmm0UcQRs4EPMvkyppE8BhlWZ87WAmiyAgBCI2OCAAIZzAIAAAJQQ
Date: Tue, 24 Feb 2026 09:25:38 +0000
Message-ID: <TYPPR06MB8206BD446615A0062DC0A462FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <b6ad55df-e6ef-443b-a075-ab6959cefd46@kaod.org>
 <TYPPR06MB82061ECF268DE4C88A7641B4FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <7c6d421b-413a-4908-8e02-a9ccec4e42e5@kaod.org>
In-Reply-To: <7c6d421b-413a-4908-8e02-a9ccec4e42e5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6335:EE_
x-ms-office365-filtering-correlation-id: 9f31ff63-c8c9-4349-7934-08de7386ac3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WkkwTGJOUTdBVTFkLzlzZTZ5cDBkRjI4VUQwbG5RZ3pHNUxEUENNU0FzbFFG?=
 =?utf-8?B?LzZoTXg2d2hIemZUbkdkTW5PREJLQUFXZCsxQk9jOStWQys1YXQ3VldSakZk?=
 =?utf-8?B?OTh5UERKYnU3Y1UwcjBMSkZ1cDNFVWdBaEVCcFlBdzZtNEt5SVpkWkVIWTFm?=
 =?utf-8?B?UDFXL0grd1FueVhKVWVwVm9OVnFDYy9kdTlraWlGMGNpY0Y2Z0NOS0VJYVAw?=
 =?utf-8?B?QXNwc3RvRUNESktOREg4WkVUVFFsWXhOcDRHMG9EVnBYNnh0VFdlOERrOEth?=
 =?utf-8?B?VGlsb1hmRE5kOTkvM2JvTXdGbUpHdkI4L3Z5OWVTUzh1aUU0TnpVUTBub01H?=
 =?utf-8?B?U2NNVnhOUFZwSjJoYUdMZ1ZsYlB6elJxdFBoVlBiTmlsRE05SWFqWEd5Ry8r?=
 =?utf-8?B?WHpYaENlMUVLa21kTnZXVUgvUGtmaGwxQ3pTRVNiamtPaCtESk5QODMzQ2xR?=
 =?utf-8?B?YXNMRXNmWmlQTmlTY1FGT2NQZnJzM1RYcjdDT3hJZitZUHhqcXB3MjJORDZy?=
 =?utf-8?B?UytDeUEycU4wUWxxeVdGUmJ1V1JDclFEVVp3ZVB3SVg5bmpBc2VqMmJzeWR0?=
 =?utf-8?B?eS9hZ3R2NU12YlRyNVBkKzB1UUlWeWtWYnpybkk3UnZZL2lDcUdLaVhBUzJy?=
 =?utf-8?B?d0tIMmNUS0JqSUxkSkNHbFNCVE1ZYk1odjBYanl1eEJZQ2NMcHlma0lHV0Nv?=
 =?utf-8?B?Vk9tMjM3Wkt1Rmx2cmdHRCtVdkFoNGpVTHhLOFU4bGdnd2JrTGZHcUJhNjhV?=
 =?utf-8?B?OXdyMWFsUWx1K2xKQkYxOXljZDdDb05VQXNHcGdEdEZPVXhVU0t3aWljMTNk?=
 =?utf-8?B?MXZ2Ky9ZSkNoUjdqcVlsYi9uM05YUlJnRk1TVXhpc2dSbDlpU0xSS1RBYXdj?=
 =?utf-8?B?L28zdGphUjk4QURpZWdYOGJDZGx5QlFyTVpNeDN0dE02SXBCQ0IzV2l3VFlv?=
 =?utf-8?B?T0hrSUQxYmpvMUpRbkFhSTc2VlhrbDJSdyttTmk1YStSL052VXpvUkNDSDB3?=
 =?utf-8?B?SlBsLzZVQ3paUmNJZWZBdk9tS0dLTTBxREw1bGV1Ulpvb0ZJZk1WSW5LK3pE?=
 =?utf-8?B?c3N5R3dqaVo0UmtHT1hRY0d2c0JBbWhBbkNoSWJNT213VEF2K3dIa2tQUWxy?=
 =?utf-8?B?UHE4QmhMNHpyLzM5aFBwckJQYklGQmpNSU44VGFaR0N4Mjh3bVN0cEpaL0ZR?=
 =?utf-8?B?MlI0bnpEVzkzdlJXUk5uMWJ4TWc3NUxDa3Q5S1UySHFoeUFYdmpiOHVmZnR6?=
 =?utf-8?B?MHpyK2FSby90U29IUnVVR2xUWDVrVU80d0ZNQVYzOVA4REpQby9jZkI4c012?=
 =?utf-8?B?dDgvSnhBbUVIQ3RyczFKV2dhTzdGOWhPL21rZ3VESDArb1RVZXNNV250ajI3?=
 =?utf-8?B?QnFsWTNTLzhES1VJYVhTNFFNTUFROHJnRjhmRUZXbEtVNTZyajVYbFJwN2xl?=
 =?utf-8?B?L3ZvMU9qUG41dXRoVVhwdmtqbkR4Y1pPdEFGcjBEeU1nOVB2VlAzRG1DT0dV?=
 =?utf-8?B?emRJbUVZc0V1WWI1ZzV0QlhBbWpZMGE4OHhRbks5d3VOQVAvTU9EdXhkY21W?=
 =?utf-8?B?TGxrak55RElpQkFDNGdkbzJlejl2UEt3WFArSG56QTFscnI3RFc0Ty9WOU1O?=
 =?utf-8?B?NFlLRFNJd1QzbE1tc2NubHpvK1ZTRnZJYTErS0VGTWxucnh0MGxSL1NPbmxO?=
 =?utf-8?B?VG9td3RabFNNcUwxQVNHdXVuYkxFbUZwR1d1cUU1cm1veVhlU0N0eGNtSHdy?=
 =?utf-8?B?bUV5RUEwOTQ1YmhTQnR4bXM3Y3ZrV3hEWlVaaGxxdVVVWGR2ZFJRNWdKeUFH?=
 =?utf-8?B?MHBRelJiL3ltZmVMNnowUkpRZzNYS1FtN3hlVnJmSk9aV0pON1MwSDg4ZXlU?=
 =?utf-8?B?WW1IRlNPRWl4V1F4T1RpUzJoZnhlZGJ6bkJGTXduc2hGdmZFc1RreHBhVmVa?=
 =?utf-8?B?a1BacG5kRlZTTGs2bStwbWNPMGF5ZGM3WEgwSDZCR0FmTG1tNDNPYlVFOFNR?=
 =?utf-8?B?YS84b042SDArSUZBYWlPVjRtZjI3eGVkdTl0aHhibmRBakh5OVpkK05sTDJa?=
 =?utf-8?B?ZXFyQlJhYkk4cDVoRkVMNVZ4UmVCWlcyaFM0UXdoYm8vUUIrc1V0QlRvaElN?=
 =?utf-8?B?czFKSG9PZFJPb1RwZDBhcVdOa2llYURDZWhjMEJpaEg4ZHlaRVZveHlweHNT?=
 =?utf-8?Q?yKSFBsOkGtnlStPRVTmYNM5RJMgHOgBhnZs3BQXk0JxW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlB0b3pJbTNwZURkNi83ZWNsY3VwaGx3dS9SUWxKaUN6MTd0dzZqZTRwa0Vt?=
 =?utf-8?B?U0VKSk9qRUsrUVFYSUc1RHUzZDM5SEtOZXJRUVM5UnJ2WERmeDFnRk84ZW1z?=
 =?utf-8?B?a2hGeEdBZGZCUDkySEhMb2N1T3JSNHM5YnpmQ1BKVE1kSlZFNDM2cnkxNmtB?=
 =?utf-8?B?NGVKbUZ4dHFSUmQ0aVVkUXl4bHd3OWwvQ2dOMVJRdjE5bTVsQWozTnRnN3Vn?=
 =?utf-8?B?MldhU09ZcU5Xa0laeVljeEdqYUJZTUlCUGk0QVpZRU5yV2lRdHllOHhjRlpT?=
 =?utf-8?B?aHlKR2NnanVTRWJPWFRrbFVvRFVpei9QOU1iK2h1K2h3UC9LNUVrYVNZT1Bk?=
 =?utf-8?B?bHRiRnd6OHYrR1Y0VFVSbzdPVHc4K3M0SnU5OGIwVXArOWVhRlJxdC9qM2c0?=
 =?utf-8?B?NXovUFg0NGxqeS9RZUdwLy85dWlBNEkrdGYwWmtsdnQ4ZVZFZHBnWEtIQXZa?=
 =?utf-8?B?ZkcwT1BQcEY1cGJGbkZCVzRidVZZSlRZQ01lZ1VmcFNWd2h3MFY4eE9yRERv?=
 =?utf-8?B?bnpwZVRiSUhBVDRJZUgyQ055UkRBQ3RlaW1qUWtlNmt3Q2lkbVI0VzdHeXhW?=
 =?utf-8?B?MTNwU1d0dXZCR1lkSDhXMzQzNHhUY3BPd1FxNTZLMzdzaUMwdmwwaDFYOTgy?=
 =?utf-8?B?MkE5Y2hJWW1CaDJMYmxIWHkrWTlCOFNMcnBNWm5BdHJMenZCK3E2RHhhV0VV?=
 =?utf-8?B?ZUtWbGEwS1hmeEZvMXFZNUJhTkdrRThQck43ZWJ0dDZYZGJodmFRNVFscDBF?=
 =?utf-8?B?VHNac0h1Y09mR2EwSGtEcGtwcWFIZ3h4ZGtIUjNkblRMREtTdTJkaXJFbElQ?=
 =?utf-8?B?ZXlWWENKVkRxRmVYNFllbWdGeEk5V2YxSWlDaUluaU5SRHVvVE5qMXAwVTd4?=
 =?utf-8?B?dGJSTld2YWNoTitTVmhJTk1yNzBnanVTNXRpYmpKejVBbzBOcHpYaG1mSmlN?=
 =?utf-8?B?bmxPMzk0MnA1QlVqQThnSU80WE1pNVVmc2xSMkZlNE5JUXhCUDl2RXhlNFg5?=
 =?utf-8?B?aEdxbUFueVVnLzZYdzU0UVVtMHM0c0lTdHQycSthWVIzaEk0RStiMEZpcEFi?=
 =?utf-8?B?YTM0VEdhdm1KMDBkcm5nUmxHSU5oRDhqUk44VXZBcnllVEVkdk9ncW9HckpN?=
 =?utf-8?B?RDREeS9nUVk1T2dBS0hGR2l5dFFSN1N1bFBpb0t5aGRDQkVnTEhlOGhrclVT?=
 =?utf-8?B?Y205cHk2bHFmL013ZEg5emkwdWVpQXVGcDZrQkRQY1o3M3kxM2ZjZmk4ay9m?=
 =?utf-8?B?S1hhaFdZVkhPZm1mRnEvcFVodU40ZEhwRElqRUZlbU82MlkzZmJVejlXSDIx?=
 =?utf-8?B?VHU4RDdhWXA5a2J4bWYzbE0vVVhQRE1hVENDS21ZM0tKekJCcHNHbHN5c05y?=
 =?utf-8?B?M0ZmSVUyUHVVRHZFRm42d0o4UVQ1ZHkzeEpnUW40bVlLeGR2YjZ2S1NWRVFq?=
 =?utf-8?B?V081clorNWZnM0tYUk1IZE1kdllDOUlrYmNTOHlNc2dObWdzOTdPckZxdm9H?=
 =?utf-8?B?MEVWNkx5SExiR1NFS3BPdm9qZnF5QmVXYmpaaTlYL092QzJML0dCUFo5UGMr?=
 =?utf-8?B?eVJBdUEyUE1Ca2VkU1NYeEZMTEN3eUFHemxpeHpYN0lwOW1ROVpicjBjL2pG?=
 =?utf-8?B?U2pjS3lxNTRlNVkvYXk5RDhXSWVXWGRVdXVBMHdxTWxYUFFqaG92WTk0RGpr?=
 =?utf-8?B?eXhPa2pXS2JzenRKdWxMaDc0bVJnTGY4QkYyUXQ4bDZNTU9XQmkzQVJQSXFS?=
 =?utf-8?B?bWZJSUtLTzY5UkZPdW4wMmthWkFvc3E1Wnd3YjNrNUppMEwxeGVuZyszZGFi?=
 =?utf-8?B?RUgrVjJidmU1aGpTeWxaN3BWNEUwck9PUzd2WmNaMXMrajBFdUZ5SXVQYlhG?=
 =?utf-8?B?MzVzOVZ3dGl6eDFoM1AxTXhqdmxLVjVBVVE1SnExRHF3YU8vUFBUdDFJNWZp?=
 =?utf-8?B?cW5yaFd6NGxMa3Z6OVRnUnhxcFRWQUJSd0dlYXhWdXVUbnlDbFd1dm8ycjFY?=
 =?utf-8?B?akhERkRmMUN5c1VmTmJNb2MrR0ZrK05iQVpPN2pldVhsMmxSZXRqL095bWlH?=
 =?utf-8?B?alU1dHZPR2Jod05TWHlxa3VxSlp6R0lDcjI4WTBWaUVCM2tkV0MvdHloOW0r?=
 =?utf-8?B?UEwyaWFiREVRbHdGZ3dZdUFKWnNhWVdBWFJjb1dkbWwwNFAybGtlcEZOYXZs?=
 =?utf-8?B?OVM5T0cxYVd1OGdMYVJXU3VtcWhVRms0bjJJTHVvZGgwM0Z1MGU0N25NNlNE?=
 =?utf-8?B?UjdJeGdWV0Q1aldlVDZyVCsrSGtjUWZSa2tPeXYvSTFDdlVSRG5ldEVwMDdY?=
 =?utf-8?B?dzFjL0VROEZWQUZJMnFhQUY3RmRiUU15blNTZjRJckQ3dzYzeUQ4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f31ff63-c8c9-4349-7934-08de7386ac3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 09:25:38.5226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGT457mUfg0CQikp7ZFlG6k+oievxLhgkc5Q+aSNH5RmNtPvqa+CAoar+mOVstGB5JGCjiqP9PROa0LbMd5zXsfAn1F4fj3NusX0rf2Nq+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6335
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAwLzIxXSBpM2M6IGFzcGVl
ZDogQWRkIEkzQyBzdXBwb3J0DQo+IA0KPiBPbiAyLzI0LzI2IDAyOjI5LCBKYW1pbiBMaW4gd3Jv
dGU6DQo+ID4gSGkgQ8OpZHJpYw0KPiA+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDAv
MjFdIGkzYzogYXNwZWVkOiBBZGQgSTNDIHN1cHBvcnQNCj4gPj4NCj4gPj4gT24gMi8xMC8yNiAx
MDoxMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4gdjE6DQo+ID4+PiAgICAgVGhlIGluaXRpYWwg
cGF0Y2ggc2VyaWVzIHdhcyBiYXNlZCBvbiB3b3JrIGJ5IEpvZSBLb21sb2RpDQo+ID4+IDxrb21s
b2RpQGdvb2dsZS5jb20+Lg0KPiA+Pj4NCj4gPj4+ICAgICBUaGlzIHNlcmllcyBhZGRzIEkzQyBi
dXMgc3VwcG9ydCB0byBRRU1VIGFuZCBhZGRzIG1vcmUNCj4gPj4+IGZ1bmN0aW9uYWxpdHkgdG8N
Cj4gPj4gdGhlDQo+ID4+PiAgICAgQXNwZWVkIEkzQyBjb250cm9sbGVyLg0KPiA+Pj4NCj4gPj4+
ICAgICBUaGlzIGltcGxlbWVudGF0aW9uIGlzIGEgYmFzaWMgaW1wbGVtZW50YXRpb24gdGhhdCBp
bnRyb2R1Y2VzIElCSXMNCj4gPj4+ICAgICAoaW5jbHVkaW5nIGhvdC1qb2luKSwgQ0NDcywgYW5k
IFNEUiBkYXRhIHRyYW5zZmVyLiBBcy1pcywgaXQgZG9lc24ndA0KPiBzdXBwb3J0DQo+ID4+PiAg
ICAgbXVsdGktY29udHJvbGxlciBidXNlcyBvciBIRFIgdHJhbnNmZXJzLg0KPiA+Pj4NCj4gPj4+
ICAgICBGaXJzdCB3ZSBhZGQgdGhlIEkzQyBidXMgYW5kIGNvbnRyb2xsZXIgbW9kZWwuIFdpdGgg
dGhhdCBhZGRlZA0KPiA+Pj4gd2UNCj4gPj4gZXh0ZW5kDQo+ID4+PiAgICAgdGhlIGZ1bmN0aW9u
YWxpdHkgb2YgdGhlIEFzcGVlZCBJM0MgY29udHJvbGxlciBzbyBpdCBjYW4gZG8gdHJhbnNmZXJz
DQo+ID4+PiAgICAgYW5kIGhhbmRsZSBJQklzLg0KPiA+Pj4NCj4gPj4+ICAgICBOZXh0LCB3ZSBh
ZGQgYSBtb2NrIEkzQyB0YXJnZXQuIEl0J3MgaW50ZW5kZWQgdG8gYmUgYSB2ZXJ5IHNpbXBsZQ0K
PiB0YXJnZXQNCj4gPj4+ICAgICBqdXN0IHRvIHZlcmlmeSB0aGF0IEkzQyBpcyB3b3JraW5nIG9u
IHRoZSBndWVzdC4gSW50ZXJuYWxseSwgd2UndmUgdXNlZA0KPiBpdA0KPiA+Pj4gICAgIG9uIExp
bnV4IHRvIHZlcmlmeSB0aGF0IGkzQyBkZXZpY2VzIGNhbiBiZSBwcm9iZWQgYW5kIGNhbg0KPiA+
Pj4gc2VuZC9yZWNlaXZlDQo+ID4+IGRhdGENCj4gPj4+ICAgICBhbmQgSUJJcy4NCj4gPj4+ICAg
ICBUaGlzIHRhcmdldCBpcyBzb3J0IG9mIGxpa2UgYW4gRUVQUk9NLCBhbmQgaXQgY2FuIGFsc28g
c2VuZCBJQklzIHVwb24NCj4gPj4+ICAgICByZWNlcHRpb24gb2YgYSB1c2VyLWRlZmluZWQgbWFn
aWMgbnVtYmVyLg0KPiA+Pj4NCj4gPj4+ICAgICBMYXN0bHkgd2UgYWRkICBob3RwbHVnZ2luZyBz
dXBwb3J0LiBUaGUgaG90cGx1Z2dpbmcgZG9lc24ndCBkbw0KPiA+PiBhbnl0aGluZyB0b28NCj4g
Pj4+ICAgICBjb21wbGljYXRlZCwgaXQganVzdCBhZGRzIHRoZSBkZXZpY2UgYXR0ZW1wdGluZyB0
byBob3RwbHVnIHRvIHRoZSBidXMuDQo+IEl0DQo+ID4+PiAgICAgaXMgdGhlIGRldmljZSdzIHJl
c3BvbnNpYmlsaXR5IHRvIGhvdC1qb2luIGFuZCBnbyB0aHJvdWdoIHRoZSBEQUENCj4gcHJvY2Vz
cw0KPiA+Pj4gICAgIHRvIHBhcnRpY2lwYXRlIG9uIHRoZSBidXMuDQo+ID4+Pg0KPiA+Pj4gdjI6
DQo+ID4+PiAgICAgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+IGhhcyB0YWtl
biBvd25lcnNoaXAgb2YgdGhlDQo+ID4+PiBJM0MNCj4gPj4gcGF0Y2gNCj4gPj4+ICAgICBzZXJp
ZXMgZm9yIHVwc3RyZWFtIHN1Ym1pc3Npb24uDQo+ID4+Pg0KPiA+Pj4gICAgIENoYW5nZXMgaW4g
dGhpcyB2ZXJzaW9uIGluY2x1ZGU6DQo+ID4+Pg0KPiA+Pj4gICAgIDEuIEFkZGVkIEkzQyBmdW5j
dGlvbmFsIHRlc3RzLg0KPiA+Pj4gICAgIDIuIFVwZGF0ZWQgcGF0Y2ggNCB0byByZWZpbmUgcmVn
aXN0ZXIgZmllbGQgZGVmaW5pdGlvbnMuDQo+ID4+PiAgICAgMy4gVXBkYXRlZCBwYXRjaCA3IHRv
IGNvcnJlY3QgcmVhZC1vbmx5IHJlZ2lzdGVyIGZpZWxkIG1hc2tzLg0KPiA+Pj4NCj4gPj4+IHYz
Og0KPiA+Pj4gICAgIDEuIEFkZCBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBh
c3BlZWR0ZWNoLmNvbT4NCj4gPj4+ICAgICAyLiBGaXggYSB0eXBvDQo+ID4+PiAgICAgMy4gRml4
IEFTUEVFRCBtYWlsIHNlcnZlciBpc3N1ZQ0KPiA+Pj4NCj4gPj4+IHY0Og0KPiA+Pj4gICAgIDEu
IEFkZCBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4g
YXQNCj4gPj4+IHRoZSBlbmQNCj4gPj4gb2YgZWFjaCBwYXRjaC4NCj4gPj4+DQo+ID4+PiB2NToN
Cj4gPj4+ICAgICAxLiBBZGRyZXNzIHJldmlldyBmZWVkYmFjayBieSB1cGRhdGluZyB0aGUgSTND
IGJ1cyBhbmQgZGV2aWNlIHRvIHVzZQ0KPiB0aGUNCj4gPj4+ICAgICAgREVGSU5FX1RZUEVTKCkg
bWFjcm8gaW5zdGVhZCBvZiBhbiBleHBsaWNpdCB0eXBlIHJlZ2lzdHJhdGlvbg0KPiBmdW5jdGlv
bi4NCj4gPj4+ICAgICAyLiBSZW5hbWUgdmFyaWFibGVzIHRvIGBwYXJlbnRfb2JqYCBmb3IgdGhl
IHBhcmVudCBvYmplY3QgYW5kDQo+ID4+IGBwYXJlbnRfY2xhc3NgDQo+ID4+PiAgICAgIGZvciB0
aGUgcGFyZW50IGNsYXNzIHRvIGNvbXBseSB3aXRoIFFFTVUgUU9NIGNvZGluZyBzdHlsZQ0KPiA+
PiBndWlkZWxpbmVzLg0KPiA+Pj4NCj4gPj4+IEphbWluIExpbiAoMik6DQo+ID4+PiAgICAgaHcv
aTNjL2FzcGVlZF9pM2M6IFN3aXRjaCB0byBERUZJTkVfVFlQRVMoKSBhbmQgYWxpZ24gcGFyZW50
X29iag0KPiA+Pj4gICAgICAgbmFtaW5nDQo+ID4+PiAgICAgdGVzdHMvZnVuY3Rpb25hbC9hcm0v
dGVzdF9hc3BlZWRfYXN0MjYwMF9zZGs6IEFkZCBpM2MgZnVuY3Rpb25hbA0KPiA+Pj4gdGVzdA0K
PiA+Pj4NCj4gPj4+IEpvZSBLb21sb2RpICgxOSk6DQo+ID4+PiAgICAgaHcvbWlzYy9hc3BlZWRf
aTNjOiBNb3ZlIHRvIGkzYyBkaXJlY3RvcnkNCj4gPj4+ICAgICBody9pM2M6IEFkZCBidXMgc3Vw
cG9ydA0KPiA+Pj4gICAgIGh3L2kzYzogU3BsaXQgRGVzaWduV2FyZSBJM0Mgb3V0IG9mIEFzcGVl
ZCBJM0MNCj4gPj4+ICAgICBody9pM2MvZHctaTNjOiBBZGQgbW9yZSByZWdpc3RlciBmaWVsZHMN
Cj4gPj4+ICAgICBody9pM2MvYXNwZWVkX2kzYzogQWRkIG1vcmUgcmVnaXN0ZXIgZmllbGRzDQo+
ID4+PiAgICAgaHcvaTNjL2R3LWkzYzogQWRkIG1vcmUgcmVzZXQgdmFsdWVzDQo+ID4+PiAgICAg
aHcvaTNjL2FzcGVlZF9pM2M6IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+Pj4gICAg
IGh3L2kzYy9kdy1pM2M6IEFkZCByZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiA+Pj4gICAgIGh3
L2kzYy9kdy1pM2M6IFRyZWF0IG1vcmUgcmVnaXN0ZXJzIGFzIHJlYWQtYXMtemVybw0KPiA+Pj4g
ICAgIGh3L2kzYy9kdy1pM2M6IFVzZSAzMiBiaXRzIG9uIE1NSU8gd3JpdGVzDQo+ID4+PiAgICAg
aHcvaTNjL2R3LWkzYzogQWRkIElSUSBNTUlPIGJlaGF2aW9yDQo+ID4+PiAgICAgaHcvaTNjL2R3
LWkzYzogQWRkIGRhdGEgVFggYW5kIFJYDQo+ID4+PiAgICAgaHcvaTNjL2R3LWkzYzogQWRkIElC
SSBoYW5kbGluZw0KPiA+Pj4gICAgIGh3L2kzYy9kdy1pM2M6IEFkZCBjdHJsIE1NSU8gaGFuZGxp
bmcNCj4gPj4+ICAgICBody9pM2MvZHctaTNjOiBBZGQgY29udHJvbGxlciByZXNldHMNCj4gPj4+
ICAgICBody9pM2MvYXNwZWVkOiBBZGQgSTNDIGJ1cyBnZXQgZnVuY3Rpb24NCj4gPj4+ICAgICBo
dy9pM2M6IEFkZCBNb2NrIHRhcmdldA0KPiA+Pj4gICAgIGh3L2FybS9hc3BlZWQ6IEJ1aWxkIHdp
dGggSTNDX0RFVklDRVMNCj4gPj4+ICAgICBody9pM2M6IEFkZCBob3RwbHVnIHN1cHBvcnQNCj4g
Pj4+DQo+ID4+PiAgICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAxICsNCj4gPj4+ICAgIGh3L2kzYy90cmFjZS5oICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgIDIgKw0KPiA+Pj4gICAgaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5o
ICAgICAgICAgICAgICAgICAgIHwgICAgMiArLQ0KPiA+Pj4gICAgaW5jbHVkZS9ody97bWlzYyA9
PiBpM2N9L2FzcGVlZF9pM2MuaCAgICAgICAgIHwgICAzMSArLQ0KPiA+Pj4gICAgaW5jbHVkZS9o
dy9pM2MvZHctaTNjLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDE5OSArKw0KPiA+Pj4gICAg
aW5jbHVkZS9ody9pM2MvaTNjLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI3NyArKysN
Cj4gPj4+ICAgIGluY2x1ZGUvaHcvaTNjL21vY2staTNjLXRhcmdldC5oICAgICAgICAgICAgICB8
ICAgNTIgKw0KPiA+Pj4gICAgaHcvaTNjL2FzcGVlZF9pM2MuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDI1OCArKysNCj4gPj4+ICAgIGh3L2kzYy9jb3JlLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICA2NjQgKysrKysrDQo+ID4+PiAgICBody9pM2MvZHctaTNjLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxODYyDQo+ID4+ICsrKysrKysrKysrKysr
KysrDQo+ID4+PiAgICBody9pM2MvbW9jay1pM2MtdGFyZ2V0LmMgICAgICAgICAgICAgICAgICAg
ICAgfCAgMjk4ICsrKw0KPiA+Pj4gICAgaHcvbWlzYy9hc3BlZWRfaTNjLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDM4MyAtLS0tDQo+ID4+PiAgICBody9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPj4+ICAgIGh3L2FybS9LY29uZmln
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDMgKw0KPiA+Pj4gICAgaHcvaTNj
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxNSArDQo+ID4+PiAg
ICBody9pM2MvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsN
Cj4gPj4+ICAgIGh3L2kzYy90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNDggKw0KPiA+Pj4gICAgaHcvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMSArDQo+ID4+PiAgICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAxIC0NCj4gPj4+ICAgIGh3L21pc2MvdHJhY2UtZXZlbnRzICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDYgLQ0KPiA+Pj4gICAgLi4uL2Z1bmN0aW9uYWwv
YXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrLnB5IHwgICAxMiArDQo+ID4+PiAgICAyMSBmaWxl
cyBjaGFuZ2VkLCAzNzEwIGluc2VydGlvbnMoKyksIDQxMiBkZWxldGlvbnMoLSkNCj4gPj4+ICAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pM2MvdHJhY2UuaA0KPiA+Pj4gICAgcmVuYW1lIGluY2x1
ZGUvaHcve21pc2MgPT4gaTNjfS9hc3BlZWRfaTNjLmggKDUzJSkNCj4gPj4+ICAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2h3L2kzYy9kdy1pM2MuaA0KPiA+Pj4gICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvaHcvaTNjL2kzYy5oDQo+ID4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9ody9pM2MvbW9jay1pM2MtdGFyZ2V0LmgNCj4gPj4+ICAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9pM2MvYXNwZWVkX2kzYy5jDQo+ID4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
aTNjL2NvcmUuYw0KPiA+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9kdy1pM2MuYw0K
PiA+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2kzYy9tb2NrLWkzYy10YXJnZXQuYw0KPiA+
Pj4gICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvYXNwZWVkX2kzYy5jDQo+ID4+PiAgICBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL0tjb25maWcNCj4gPj4+ICAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9pM2MvbWVzb24uYnVpbGQNCj4gPj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9p
M2MvdHJhY2UtZXZlbnRzDQo+ID4+DQo+ID4+DQo+ID4+IFdobyB3aWxsIGJlIHRoZSBtYWludGFp
bmVycyBhbmQgcmV2aWV3ZXJzID8NCj4gPj4NCj4gPg0KPiA+IEkgd2lsbCBhZGQgbXlzZWxmIChK
YW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4pIGFuZCBKb2UNCj4gPiBLb21sb2Rp
ICg8a29tbG9kaUBnb29nbGUuY29tPikgYXMgTWFpbnRhaW5lcnMgYW5kIE5hYmloIEVzdGVmYW4N
Cj4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPiBhcyBhIFJldmlld2VyIGZvciBJM0MgaW4gdGhl
IE1BSU5UQUlORVJTIGZpbGUgaW4NCj4gdjYuDQo+IA0KPiBPSy4gSSBjYW4gYmUgdGhlIHNwb25z
b3IgdGhlbg0KPiANCj4gPiBXb3VsZCBhbnlvbmUgZnJvbSB0aGUgUUVNVSBjb21tdW5pdHkgYmUg
d2lsbGluZyB0byBzZXJ2ZSBhcyBhDQo+IE1haW50YWluZXIgb3IgUmV2aWV3ZXIgZm9yIEkzQz8N
Cj4gDQo+IEFzIEkzQyBpcyBjdXJyZW50bHkgb25seSBhdmFpbGFibGUgZm9yIEFzcGVlZCBtYWNo
aW5lcywgcGxlYXNlIGFkZCBtZSBhcyBhDQo+IE1haW50YWluZXIuIEkgd2lsbCBoYW5kbGUgdGhl
IHB1bGwgcmVxdWVzdHMuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpPa2F5LCB3aWxsIHJl
c2VuZCB2Nw0K

