Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204E606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=QxKjB8Ta;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=N3r8OKgV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJiRJ-0008Hz-S3; Wed, 21 Oct 2026 22:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiRI-0008H1-52; Wed, 21 Oct 2026 22:21:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiRG-00032E-8j; Wed, 21 Oct 2026 22:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792635714; x=1824171714;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UdgQSVhTsSDGeEWrvuEPvDgvEZf5rT1ks0KgrvwwIJ8=;
 b=QxKjB8TaLobJihZ91/IVoZ8jlxJfEIevbGiBoHYtjX3crUUa+LB4BmWj
 VBBWbMeqlLcu80rE9Q6D2+Wpwe0AiR77oxjf14C029qXE18Waii+j+m8A
 JV4g3c1NAqm/DXibck3CUlTIEADQhYFh2+R3YYeWuzGPle7kKxcg3UQ8y
 SJylxeRtrccQxdqAY6UzJYgB1zOJUtQH0GhKbQBTlnVZo1om7WoieORWc
 e2KXU1VrPMjI2wcUYYzLZSrTxNalVfyzDYHop+qo5LpWTAUsVUYBga7yc
 TqRJ8u7wmPlmgQ2k0NZ8ZrqG2q/niY0wFbuKm0Li27mzx4mOKQIkKFm9G Q==;
X-CSE-ConnectionGUID: saCONa8iTJiATulCt7tukg==
X-CSE-MsgGUID: 22jQZcChT3eSjx5J4l8riA==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="154472132"
Received: from mail-westus3azon11012055.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.55])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:21:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2Xy/CQJh9gGtJX/aqJXJBLbTqpBaVeh/Hnvsp3D1it7NRxtsrhszsbyrCBVUM0g0zBxQ3Tvzru2S7/LilOb4SisA2IC6xYkeiRFjY2JPvMOdE9T+9tx3EtS18f8o50jCAwcrequF4YNv+rh7FpmZRPdZogAaFRIAsuxz47UG0wPYMZNn9iCg2jrhcbEOn62FMKKu52GBifLFyLQHNEYFL76+so8vsj7ZPiFCbmjOFU3P1Ra9ma3de8hmLeBCJYcDrGw+hespIb1vN0USg4+GoqjQ4l+g3bHrTe3nLi/T0hVY5reqmmrba2QvkiXu1ZKdqhoavv+i/QPUP2bWyY5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdgQSVhTsSDGeEWrvuEPvDgvEZf5rT1ks0KgrvwwIJ8=;
 b=AjWLmLS1jdhYYvYFbBdhnSA31RW7jQ/fa884gltdoCiRrprS86C3vkCAJiot3ScDxMREChpH7oGEY/DGWfGV7FBnbTwJVbSPdhzy01IX0cmn5aFqrHMurU7pBFLOjpUBmDdUSHvVwVEPG1aMX2x1xshf+50sNeEcnX/cIok0gA7UpQDKOkVjt+09PmH05caZ5u751xcLBHvuIZWIj5ZMqgwvOh4IvjoYQApClojSGg4p/Cn3xmZX/tVP7n2kh6yrB4l4B9kjJ0GK+3NoDQhL1Uq/FHKBVN3ti5gMq2yVjUOw1j7cW8LzoX7fd7PSzNB1UeQ1+lA7XGeQOlc9gF+zRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdgQSVhTsSDGeEWrvuEPvDgvEZf5rT1ks0KgrvwwIJ8=;
 b=N3r8OKgVWBvOgFho4h69J1nVUmCx3nYDS3gek03RR5FDClECeagWrZMgLVk5gx4aNhlQ15ufdfPySA4yTvl0UrJ+yaMcbbKuVt5ThdQlMpCx5NBPPrGNotqVMhy0iIQ5AKTW2p1hC57jDiS6NzvEC3umQnjekWWJSnbZM6MC5s0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH8PR04MB994036.namprd04.prod.outlook.com (2603:10b6:510:705::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 02:21:51 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:21:49 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PULL 13/47] tests/tcg/riscv64: Add tests for rv128 [ms]status
Thread-Topic: [PULL 13/47] tests/tcg/riscv64: Add tests for rv128 [ms]status
Thread-Index: AQHdPC0f+gaPpphQdUO2Jb/t8yjcGbcGzp6AgAF0AYCAAN0zgA==
Date: Thu, 22 Oct 2026 02:21:49 +0000
Message-ID: <dc5d1de74f57edf5c30062f0cb8047724308641c.camel@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
 <20260904051943.799041-14-alistair.francis@wdc.com>
 <CAFEAcA8O9afywUSoju8ozvSP0q-TG2A1Y0Daij-LLhJFRy-dzg@mail.gmail.com>
 <6645e971-3fd3-48f8-93b7-bfe996b37608@univ-grenoble-alpes.fr>
In-Reply-To: <6645e971-3fd3-48f8-93b7-bfe996b37608@univ-grenoble-alpes.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH8PR04MB994036:EE_
x-ms-office365-filtering-correlation-id: 583a0173-894b-438f-22ea-08df2fe33a58
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10070799003|19092799006|261021123027099003|56012099006|38070700021|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007|261021121427099003;
x-microsoft-antispam-message-info: ltYrsTJh4/Bv807PIlY8Z3PYUg9q6ikYr60x7vY5SWKRwqz5IIGKxUr7wL6diMxyUKGsQMiVKmvfDNPb7oTgu5zxBW2yAwZ3of/hKCYVv567XIOoDsje7wtRzhWRd77/ZGrjsPsuRDB8vyx7BfxmmNdk3t8Q+CueUkKJ3eo44HOoicv9hcNbABKXQfQezI371a/pICRv+qsP0hUM8J8AauD9HJJ+8H0rYQflUvxfufl/zoiE+YURd2c1FFxGHvVbdQWQ74AYh5Kg9vFcZB41BxWxo0pyfVhL+w4kdiZ3txkLpSXrFYvxA1EpklhjRkJBZZHBIfJzGz9GSmBifnihPEAgl/Ctsje3J1jEAeRkJSYs+nc+dXvCSR4EWTkYWavDHGueF6PbTvdF2bF0XzEoZD/qYwICJNSTQ5Ej22MUFwNj0qRRM5Kx94wS6MdDjlg2rK1FeLtm4rfuZlvI5gHWtcPTccME5OEp6z9LxqAPLzkBu8COLYeaUyOAH72nRSt06ZyPnh+PpVXjUeQS8Arf8PKvmqR2SUaf8qAfTLqy2BO8sBae2jC5VV7AzIbIsAlhsioej/MWx4Q9/PT8bhLQcZB4ilKRHIIs2Gj99FO1/c6vcGiwPNuswGzLE+LjVXmssZ1CY64qnU+pMYJMrXo574jmkPNVq44F3agz+OqIXS6TdndDAFT5X8fmecIasyJ86/XjOZ4+Ir+k8pUgmSAE0y+CWyJoIBWPAjTC6Gnuld4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(19092799006)(261021123027099003)(56012099006)(38070700021)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007)(261021121427099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWh2YmhkMlRiblg0ZnliZW1nZlE1dWRvaEM4VWNnTXJsRlcwYUJFMy83VHJ2?=
 =?utf-8?B?K2xRYStKYnR2ajB0U2QvUUduazhKNHVHaEM3MmJJZWRBd2g4bU55VlBMN05L?=
 =?utf-8?B?eFBueDlFeDBmZFVCTU0rRnVNWnJKdjBWZktqRHBMYXVRWFZjUjJzVk8rUGFl?=
 =?utf-8?B?KzVhK1pnU3ZaM0syTTdCbHJQRUptMHZxNEZTYkJiN3pYdVJYUUs5RjArRWNu?=
 =?utf-8?B?bXMwUUw3cjZwTTlXNThuTnFOQjgyQ3dkZWwyVDBrbXpRNUQwdmlYYzBJQ0F1?=
 =?utf-8?B?SXBCbnNpYlhwQXBNSXJTeDEyNHo2WDd4b2pZaG1VQXFKd0VGVXpVVmRMd2VF?=
 =?utf-8?B?RHNXR2JqelhzMVM4MktYMlpkOUc5MTNVbFZORVFhYStna0hON0RKU3JLUmw5?=
 =?utf-8?B?N2lWQlZwMkU1c1Q4R00welVaK0ZDb0dvVXUyN054MDVzYWE2NFBhREZwampp?=
 =?utf-8?B?bzBTam9IYmxrdUlZUDVmYVdMaUlSdWFQMUFhalJ6YWpKS2tPN1pQbE5WbUVJ?=
 =?utf-8?B?Ukt3RktBVytqZS9BY25xbzdjSlUrb3l6TFFWSU5rVCtqOVBqSFRRT1drdEhp?=
 =?utf-8?B?TGZ4azc5bDhHL0tIK2pEbUVZNy9RS3hPaDFsWGFZMWNZd0twV2ZUaWt2L2dn?=
 =?utf-8?B?U2hnUDlQVGcxWWNxMVVVdUVXQWZMZzZ3UThUdHlKNWwxS3ZZamZrOVBVdmwy?=
 =?utf-8?B?Q0FNbU5YQ0xBS2lINEhpS2pNWW52U3ZBbE8zMTJWYjltUE9oYWlsMzBmVk1n?=
 =?utf-8?B?blcrbmc4SmtEMDlqZnJXY0VtTitIQllYeEEyenk1SktheUtkREhBcjdkZG1L?=
 =?utf-8?B?ZytTT3F4em5nZi9qenB3UUFUTXRIb0FzOU1qU1dodHVmbGhRMDdMaC9UZmJ5?=
 =?utf-8?B?UW9GeEVjMjFrQXgvNW8rQUlyVlNHTG8rZW0zS2F4bGsvQ2pUcGlEb2VWWEVk?=
 =?utf-8?B?emFLQlRHUWNoNkFBRGpTSlVXWTBkSDdaR3lPaEtVQzVYU2dnV1k4NWU3SzZz?=
 =?utf-8?B?d3hSWmoxakZyYXV6YVdXU29JTjZNMnhiTXVlQkh6dHRUN2hhYUJLa1hYVjN5?=
 =?utf-8?B?b0dRY0dZMHhqTEJqNEQ3ZTkvbFBoOHh1UERhOEJWazhONlBVTmRaWmljRVNV?=
 =?utf-8?B?ZGdTN1pRVTlwdm5JOVBsdDIyS0dNYXlkOVlZVXd0Rk5wbjlOOXUzODF4OXpa?=
 =?utf-8?B?KzhDYW83a2tNTFdCc0Mxa1kxbHZqV0tGWVpJQUduRVI3NmFmSjVYdHh2aHo2?=
 =?utf-8?B?WisyTGMyVDhPaEFTQXdYaU1qdnRpeVJaaXhpZFRoZ1Fvb3dweGl5bG9neFVB?=
 =?utf-8?B?L1Jwb0FsS090Z2pVQ1hsb0kraDFrVGNGZWZubzhHUGhXd1ZIWm9aemVyV1lW?=
 =?utf-8?B?UzhXeHNadGlFMUE1aEZiS0duR1F3dy9tREtFcVpZaS9JZW1QQm5WdEY5bXk2?=
 =?utf-8?B?Y3R1aWNYS0dRVjFsa3k0bUt3MXp6WldDRzd0K1krWSsyZFNEUXVVcEpWVll3?=
 =?utf-8?B?SjJ5b0g0Q0UvWHMrREJNREJNMUM0VFpBbzdwUmQ1eXByVS9mQTFLbHNycEJT?=
 =?utf-8?B?eHRiNWtsd09vWFdOZHpLY3BsWEE4STlKaCtHTDBPbG5BZTEzOFVaOTFSK1dZ?=
 =?utf-8?B?WG9vK1RHRW0ycDNJak1UKzh4cXRuV2lXNHRvMEMvSWhPeDIvYlN4K3JLWmwy?=
 =?utf-8?B?a1hQaURFd1ptMTQwdi9QS0JscExKN25TVHdnbkFXRzRGdllySmxBSGVONEhl?=
 =?utf-8?B?UnNLZHE5M0Y5bjlwZ2xnbFNiemxTdGJQTUJXTjcyNXJ1a0xoV2xTbnNQUmUx?=
 =?utf-8?B?SEYyYVBNSjE0eGpNRGtLNkIvZnlUVzZlb09yTS9rQS9VcVJ3WGE0WiszaDZD?=
 =?utf-8?B?Z2YzRHlLWFpuekJnQ2dFa0xzY2FVR1AxWXhhRjhiSlFTc2xGYUpNOXMzSUFN?=
 =?utf-8?B?RTAxSlovWi90YzNSSi90bElEK3czWGNYSVdNQ2tnZVFrS1NSZWFwbm9ncEFJ?=
 =?utf-8?B?ZWFhMEs3UDVmYnBFN2h6K2lxVnBhTnVPVHBGYzAwSSszSDdSUmZ5TDBtNnJk?=
 =?utf-8?B?Wm5vS1J2MFBjSWVscDRPOU1ETi9pcy9tN0NYdVBiMzdiVExNN0ErdzJxNlZM?=
 =?utf-8?B?bWpDNjdxbldCQ0UrN1F5aXJvRFNHSXRvY0dXR2cwaUtIaE93NEluaGpTaWY3?=
 =?utf-8?B?KzhBMjFyMUhiU0hXZlhneUtncXBFSTNocFVyS1FRdmQ3TGVKbW9QeXB5U3Qy?=
 =?utf-8?B?OG1QSHhwZHNGY1M2TDc0TnY4UXRoZEZ0MnNyMFVnRGZSOXlaRUdxYUR5MzdH?=
 =?utf-8?B?ejVuR1FpdE9xSW9FRnVKOXpUOHdMNzZmanpKeUlaQ0ZyWGxWanpkOW11WkJ2?=
 =?utf-8?Q?SUYOs17AaQlfN+ibQzJMuvCUcVwirx2bW9pZBTP6NS0lv?=
x-ms-exchange-antispam-messagedata-1: i1YLgvxHm53MCXB5TPjm2jaj03BBzyDRqpo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FFAFFD26409E6439B560144FDDF259C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0lb8vf1N3zAoEGLp3uaQA+DBEC1tcHenRPzF5fvAdU5JsBL5pe1LmQOqi8ITQndJlO1AmDmy36oWPBlMzM3nX0nMeT85AatoUp2vCV+I/YfcwNu4xIc1mCXqBlY2ZRBoHsHis/fwPpkU4Hb4rU4rgcHcTcHIzOHz2fRfSIrkldQhg/t/G48x7j3IUk7N6tvxhs807gF+SbFgkcF6/TPNMxfElVaNtPqZeR0mnFuEZPGvngS2RuRp6ffGsFZR/5WQFo34mb+nuZV16OFNOS5K+5pVSM/rxQnZjuOFNqid6st4JTavHjNw8PWMjaGYRWIwfW0YXEw+AS0upcB1ciC/SQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8Ue2gRQSw+6C9TsEeQbK97MCbp1Y/JBmy9B07w7zQ1ON1qJLSqqn4rwVlzPnmgFkGSB3HbvIYj8UjP7B2DO7hU7V3WLiDvxAU9Dx0QhBxv3Bzm0cgAxGtRO5SckS4hi02W0kFphjaIdVEmg22kmqp7tr/E3d7DdnRSZ0xcMneFfq2UF/kAMQecEoBzpApDNfVzQ9wiZd84tDvhWEPk6oWRQZetVsYmi5mFeyDniqJ4O8IttxUAHvFNyzQHTnh5EGjxGjxHlEtpg258Kj/7D1D6x6dHlvbCtyqf1Giz0P6oY+ereBXU6wpftA/rfF5dNmBDBz7ExDlcj0xFsRGrCkMs8RroNgL0HzfBpMo8YV5+qBgSne6+t1CjrT43BHPX+pBTnsdaOXkoBNGGnrB4OTNxZ452H6hDsSk5q9RVH6GphK2RVaUgeIIUnSUQBgMlAAxQoyAzuOa5YaFCW3NTy3OnW8VTqQaQpeY9RZSue2RaifxwrGyMo/AD0HjS9ZtNY6w4x5xShHekp3zFmqnPJeDCyptmn6eyqVT2hBx0T/Gipdts5XLy+amUpXGedOdiDQonF97medfCRLBSRdhr7MqqKulFl/L0R1x+9bHF690QIdNE8qIKc/Da0FO6zS1wXj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a0173-894b-438f-22ea-08df2fe33a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:21:49.1598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiKHnFLtX15pZa7LeMoIWeuwfUQ5efTX9SJ7b/aOE7N1CLTWorQKHGLtXJQkv5Zrp1PhjGgNMtCd1QRyYY1yzFbU7NZK92GRaky3SlhAQYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB994036
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDE1OjEwICswMjAwLCBGcsOpZMOpcmljIFDDqXRyb3Qgd3Jv
dGU6DQo+IE9uIDEwLzIwLzI2IDE2OjU4LCBQZXRlciBNYXlkZWxsIHdyb3RlOg0KPiA+IE9uIEZy
aSwgNCBTZXB0IDIwMjYgYXQgMDY6MjMsIDxhbGlzdGFpcjIzQGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4gPiANCj4gPiA+IEZyb206IEZyw6lkw6lyaWMgUMOpdHJvdCA8ZnJlZGVyaWMucGV0cm90QHVu
aXYtZ3Jlbm9ibGUtYWxwZXMuZnI+DQo+ID4gPiANCj4gPiA+IEFkZGluZyBhc20gdGVzdHMgdG8g
Y2hlY2sgdGhhdCBtc3RhdHVzIGFuZCBzc3RhdHVzIGFyZSB1cGRhdGVkIGFzDQo+ID4gPiBleHBl
Y3RlZCBpbiBhbiBydjEyOCBjcHUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyw6lk
w6lyaWMgUMOpdHJvdA0KPiA+ID4gPGZyZWRlcmljLnBldHJvdEB1bml2LWdyZW5vYmxlLWFscGVz
LmZyPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+ID4gPiA8
ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCj4gPiA+IE1lc3NhZ2UtSUQ6DQo+ID4g
PiA8MjAyNjA4MjQxNzQyNDYuMjAyMTUwLTEtZnJlZGVyaWMucGV0cm90QHVuaXYtZ3Jlbm9ibGUt
YWxwZXMuZnI+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQo+ID4gDQo+ID4gSGk7IHRoaXMgdGVzdCBjYXNlIHByb3Zva2Vz
IHVuZGVmaW5lZCBiZWhhdmlvdXIgd2hpY2ggdHJpcHMgdGhlDQo+ID4gY2xhbmcgc2FuaXRpemVy
IGlmIHlvdSBydW4gJ21ha2UgY2hlY2stdGNnJyBvbiBhIGJ1aWxkIHdpdGggaXQNCj4gPiBlbmFi
bGVkDQo+ID4gKGkuZS4gY29uZmlndXJlIHdpdGggIi0tY2M9Y2xhbmcgLS1jeHg9Y2xhbmcrKyAt
LWVuYWJsZS11YnNhbiIpLg0KPiA+IA0KPiA+IFJ1bm5pbmcgdGhlIHRlc3QgY2FzZSBvbiBpdHMg
b3duOg0KPiA+IA0KPiA+ICQNCj4gPiBVQlNBTl9PUFRJT05TPWhhbHRfb25fZXJyb3I9MTphYm9y
dF9vbl9lcnJvcj0xOnByaW50X3N1bW1hcnk9MTpwcmluDQo+ID4gdF9zdGFja3RyYWNlPTENCj4g
PiAuL2J1aWxkL3Jpc2N2LXNhbi1kYmcvcWVtdS1zeXN0ZW0tcmlzY3Y2NCAtY3B1IHgtcnYxMjgg
LU0gdmlydA0KPiA+IC1kaXNwbGF5IG5vbmUgLXNlcmlhbCBzdGRpbyAtc2VtaWhvc3RpbmcgLWJp
b3MNCj4gPiAuL2J1aWxkL3Jpc2N2LXNhbi1kYmcvdGVzdHMvdGNnL3Jpc2N2NjQtc29mdG1tdS10
ZXN0LXJ2MTI4LQ0KPiA+IHNzdGF0dXMudGVzdA0KPiA+IC4uLy4uL3RhcmdldC9yaXNjdi90Y2cv
cG1wLmM6NTcyOjI1OiBydW50aW1lIGVycm9yOiBzaGlmdCBleHBvbmVudA0KPiA+IDY0DQo+ID4g
aXMgdG9vIGxhcmdlIGZvciA2NC1iaXQgdHlwZSAndGFyZ2V0X3Vsb25nJyAoYWthICd1bnNpZ25l
ZCBsb25nJykNCj4gPiAvdXNyL2Jpbi9sbHZtLXN5bWJvbGl6ZXItMTg6IGVycm9yOiAnL21lbWZk
OnRjZy1qaXQgKGRlbGV0ZWQpJzogTm8NCj4gPiBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4g
wqDCoMKgwqAgIzAgMHg1YWI5ZDVlOGI1NjkgaW4gcG1wY2ZnX2Nzcl9yZWFkDQo+ID4gL2hvbWUv
cG0yMTUvcWVtdS9idWlsZC9yaXNjdi1zYW4tDQo+ID4gZGJnLy4uLy4uL3RhcmdldC9yaXNjdi90
Y2cvcG1wLmM6NTcyOjI1DQo+ID4gwqDCoMKgwqAgIzEgMHg1YWI5ZDVmOTE0NDAgaW4gcmVhZF9w
bXBjZmcNCj4gPiAvaG9tZS9wbTIxNS9xZW11L2J1aWxkL3Jpc2N2LXNhbi0NCj4gPiBkYmcvLi4v
Li4vdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYzo1NTg4OjEyDQo+ID4gwqDCoMKgwqAgIzIgMHg1YWI5
ZDVmNzkwODUgaW4gcmlzY3ZfY3NycndfZG82NA0KPiA+IC9ob21lL3BtMjE1L3FlbXUvYnVpbGQv
cmlzY3Ytc2FuLQ0KPiA+IGRiZy8uLi8uLi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jOjU4ODk6MTUN
Cj4gPiDCoMKgwqDCoCAjMyAweDVhYjlkNWY3YTI3NCBpbiByaXNjdl9jc3Jyd19pMTI4DQo+ID4g
L2hvbWUvcG0yMTUvcWVtdS9idWlsZC9yaXNjdi1zYW4tDQo+ID4gZGJnLy4uLy4uL3RhcmdldC9y
aXNjdi90Y2cvY3NyLmM6NjA0NjoxMQ0KPiA+IMKgwqDCoMKgICM0IDB4NWFiOWQ1ZmI3YjExIGlu
IGhlbHBlcl9jc3J3X2kxMjgNCj4gPiAvaG9tZS9wbTIxNS9xZW11L2J1aWxkL3Jpc2N2LXNhbi0N
Cj4gPiBkYmcvLi4vLi4vdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYzoxMTc6MjYNCj4gPiDC
oMKgwqDCoCAjNSAweDc3NTY4YzAwMDhiYcKgICgvbWVtZmQ6dGNnLWppdCAoZGVsZXRlZCkrMHg4
YmEpDQo+ID4gDQo+ID4gU1VNTUFSWTogVW5kZWZpbmVkQmVoYXZpb3JTYW5pdGl6ZXI6IHVuZGVm
aW5lZC1iZWhhdmlvcg0KPiA+IC4uLy4uL3RhcmdldC9yaXNjdi90Y2cvcG1wLmM6NTcyOjI1DQo+
ID4gQWJvcnRlZCAoY29yZSBkdW1wZWQpDQo+ID4gDQo+ID4gV2hhdCBoYXBwZW5zIGlzIHRoYXQg
aW4gcG1wY2ZnX2Nzcl9yZWFkKCkgd2UgZG8gdGhpczoNCj4gPiANCj4gPiDCoMKgwqDCoCBpbnQg
cG1wY2ZnX251bXMgPSAyIDw8IHJpc2N2X2NwdV9teGwoZW52KTsNCj4gPiANCj4gPiDCoMKgwqDC
oCBmb3IgKGkgPSAwOyBpIDwgcG1wY2ZnX251bXM7IGkrKykgew0KPiA+IMKgwqDCoMKgwqDCoMKg
wqAgdmFsID0gcG1wX3JlYWRfY2ZnKGVudiwgKHJlZ19pbmRleCAqIDQpICsgaSk7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoCBjZmdfdmFsIHw9ICh2YWwgPDwgKGkgKiA4KSk7DQo+ID4gwqDCoMKgwqAg
fQ0KPiA+IA0KPiA+IEZvciB0aGUgeC1ydjEyOCBDUFUgcG1wY2ZnX251bXMgY29tZXMgb3V0IGFz
IDE2LCBhbmQgdGhlbg0KPiA+IHdlIHRyeSB0byBhc3NlbWJsZSAxNiBieXRlcyBpbnRvIGFuIDgt
Yml0IHRhcmdldF91bG9uZyB2YXJpYWJsZSwNCj4gPiBhbmQgZm9yIGJ5dGVzIDguLjE1IHRoZSBz
aGlmdCBhbW91bnQgaXMgbGFyZ2VyIHRoYW4gdGhlDQo+ID4gdHlwZSwgd2hpY2ggaXMgVUIuDQo+
ID4gDQo+ID4gSSdtIG5vdCBzdXJlIGhvdyB0aGlzIGlzIGludGVuZGVkIHRvIHdvcms7IGNvdWxk
IHlvdSBoYXZlDQo+ID4gYSBsb29rIGF0IGl0LCBwbGVhc2U/DQo+IA0KPiDCoMKgIE91dGNoIQ0K
PiDCoMKgIFRoaXMgdW5mb2xkcyBhIGRhcmsgc2lkZSBvZiB4LXJ2MTI4OiB0aGUgYWJzb2x1dGUg
bWluaW1hbCBjc3INCj4gc3VwcG9ydA0KPiDCoMKgIGFzIG9mIG5vdyAoaGVuY2UgdGhlIHgtKS4N
Cj4gwqDCoCBNb3N0IGNzcnMgY2FuIGxpdmUgd2l0aCA2NC1iaXQsIGJ1dCB0aGUgcG1wcywgW21z
XWNhdXNlLCBhbmQNCj4gcHJvYmFibHkgYQ0KPiDCoMKgIGZldywgb3RoZXJzIGNhbm5vdC4NCj4g
wqDCoCBJbiBlc3NlbmNlLCB0aGlzIGJvaWxzIGRvd24gdG8gaW50cm9kdWNpbmcgdGhlICJfaTEy
OCIgdmVyc2lvbiBvZg0KPiB0aGVzZQ0KPiDCoMKgIGNzcnMgZ2V0dGVyL3NldHRlciBmb3IgdGhl
IGluc3RydWN0aW9ucywgYnV0IHRoZW4gaXQgcmFpc2VzIGxhdGVyDQo+IGlzc3Vlcw0KPiDCoMKg
IG9uIGltcGxpY2l0IGFjY2Vzc2VzwqBkb25lIHdpdGhpbiByaXNjdl9jcHVfZG9faW50ZXJydXB0
IGluIHdoaWNoDQo+IHdlIGhhdmUNCj4gwqDCoCB0byBzZXQgdGhlIHVwcGVyIGJpdCBvZiBbbXNd
Y2F1c2UuDQo+IMKgwqAgSGVyZSB3ZSdsbCBoYXZlIHRvIGNoZWNrIFttc114bCBhdCBydW50aW1l
LCBJJ20gYWZyYWlkLg0KPiANCj4gwqDCoCBJJ2xsIHNlbmQgYW4gUkZDIHBhdGNoIHRoYXQgc29s
dmVzIHRoZSBpc3N1ZSB5b3UgcmFpc2VkLCB0byBzZWUgaWYNCj4gdGhpcw0KPiDCoMKgIHNlZW1z
IGxpa2UgYSBwcm9wZXIgcGF0aCB0byBmb2xsb3cgZm9yIGxhcmdlciBjc3Igc3VwcG9ydC4NCg0K
LUFSTSBwZW9wbGUgYW5kICtSSVNDLVYgcGVvcGxlDQoNCldoYXQncyB0aGUgc3RhdHVzIG9mIFJW
MTI4PyBXaGVuIHdlIGluaXRpYWxseSBhZGRlZCBleHBlcmltZW50YWwNCnN1cHBvcnQgdGhlcmUg
d2FzIFJWMTI4IG1lbnRpb25lZCBpbiB0aGUgc3BlYy4gSXQgaGFzIHNpbmNlIGJlZW4NCnJlbW92
ZWQgYW5kIGl0IGRvZXNuJ3Qgc2VlbSBsaWtlIGFueXRoaW5nIGlzIGhhcHBlbmluZyBpbiB0ZXJt
cyBvZiBtb3JlDQpzdXBwb3J0Lg0KDQpUaGVyZSBpcyBvdmVyaGVhZCBpbiBrZWVwaW5nIGl0LCBz
aG91bGQgd2UgdGhpbmsgYWJvdXQgcmVtb3ZpbmcgaXQ/DQoNCkFsaXN0YWlyDQoNCg0KPiANCj4g
wqDCoCBUaGFua3MsDQo+IMKgwqAgRnLDqWTDqXJpYw0KPiA+IHRoYW5rcw0KPiA+IC0tIFBNTQ0K

