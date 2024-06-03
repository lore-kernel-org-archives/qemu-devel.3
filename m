Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270BC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jj-0006jO-Rm; Mon, 03 Jun 2024 02:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jd-0006fp-Dd
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:57 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jb-00071T-K4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394395; x=1748930395;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=203ROX01K1oZ6NurPajI+Um1ICvecqjwliaqm20TbZQ=;
 b=mOSCSaXANm2TviAb3Od1PoQLxyUuJYIwnTFHAo5FdhvXEDwiRbscsDii
 1nCpvS7EUpkFxXDzaZAhlHvrZ33LucWd4lTm4bKO1c+s9EbuGvo12zpjD
 9IMprGeKPU4g0emeEpxs3gQJMcDlDkIQLf4TVrq0GnUjp98aYHjxoKx/V
 ccx1eD5FIs5Qn96xwk7ieXyCUE+06kNDS5rvnb6YWHQ1HDIBYvoACEFrR
 VouwQPMfTVKK2/xiK/fzsgCR7N7NoxCRW6+5sXkCAm4/CnEKNJhexlRMN
 pAX0RffUAPt6bZ4Zbz8X8K4J6CrDqzqrMQA/2dw4GetClh8lQ/GD4HSgn A==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13815876"
X-MGA-submission: =?us-ascii?q?MDFIMSir7WyOvmNlNCMWQuHO8ua305Yft/0rJt?=
 =?us-ascii?q?q9gCn1w9wUj6Iiev3w7qwllUExa2KV3cbDPJ6jnSbIX9P2onjK5XE1iz?=
 =?us-ascii?q?3Rtjs5vfUgF9Jy4jK8fU4XQdIodyC+eom0DUsDCFZeay7DK6EdkrT1n4?=
 =?us-ascii?q?VxgtmpdmAZ3IwpJmwfVO8QvQ=3D=3D?=
Received: from mail-he1eur01lp2050.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3jFefsWBXGpD4A1LnlZUIHkdHhLE0YQEnOHvrLh9UFYfa37LK9zSvyZOuzJ00wi/5HcOkwSR/f6/tqtZNPrAqCQgOcPdarAlj7DaBAU+mTQFwYCryLtIeNesjKthFJnSFfsHHUKlM62BveRZUfJOjfpu7V3N4EzbmLfkEuOEmrEqsbYhyOWF/cEEKr+IuFNmO8CSH+rs+TC987mqu0kASyHMXTS3gNppfJoifjP/h3Svm26mw1kNBm7FBnRbVoj+JwFZp5sArqVHTv4DOdWF/2YdiQ7JdM/ZoVB9OjTQKRvaA8oR6Bkgl+GE1Ut5OsTN91Wx20qFXrKfqHTYKznJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=203ROX01K1oZ6NurPajI+Um1ICvecqjwliaqm20TbZQ=;
 b=LwmKp2KAwidt8A728pxyBtBMNsx7j0r18ZW7YTP7uo/3ccArOUQiISUxHhSyUHaUDNW0S15uZ2AZASJq5jscFaQ/HpHC/llV32DOfdWTYvn9uAhMbjA8Yz1h6Ct+6vSDLheYBRIYCaCDxMoKdQrFdAnD7/jwG8jWE3kcLnpZX3XIJfKD0thmF6JawT4KAP/pzfIRXki5NYgxHPZ0grnCuCq/hAGSMp+3l4uzOnOAMwoIsCf+B6Ypp03TZB8IRUBxbLrVatNLv+mcAZgdR1r5HuDoeBvxLbdTu2SfFbmpEfSzwyW2A6Fa6GnYsCWkSCbegDK3PmeGIyI9dar599QP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=203ROX01K1oZ6NurPajI+Um1ICvecqjwliaqm20TbZQ=;
 b=mEcGzkFjwBbzDT2BGhGxaWYu/vplKbeYj18gSXYuAYLNF3QzNf2w7QtEhuQ2vcMOXfc+3MhoD0EetEIKF1h4k38lHMoLsTIH4sMPNbMcJs4q3NAoMn7H3LeT9RV/03YU7kXoLmLRiw5XzrtYaCOHHWiyNkruhQ0FBjMTmdrdA1mqxp90VGXNiHTqh9+z/vPmqTW7RTYorixyPvsIZOgOga+ZKWr/kE+IxfduiHGQ8aYGJE5R1TuXusSJRXEVRoKJAq4ryKDgIGkohvhdtNZlMgp+RQ+WFRdbMmlcuw1QE5zQbQDMq/79dQQN7FyxbyigxHvLGuoSkOSt+/ecMHNA9g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 05/22] memory: add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH ats_vtd v5 05/22] memory: add permissions in
 IOMMUAccessFlags
Thread-Index: AQHatXs7UOkkuRjbokmLCeDI0yIErQ==
Date: Mon, 3 Jun 2024 05:59:43 +0000
Message-ID: <20240603055917.18735-6-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: 804830d2-5778-415c-d827-08dc83925d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NDhzWUV2Z0pTTSs4dHBNTHlhWXBkTUZ3ZW9pRlR2UlAwd21mZ1hlNU50V3Vv?=
 =?utf-8?B?K2V2dHBwNjNqRG1ZYU5vTkhFSjIyUitGU1FkRzdZOVlHb0hwZ3F4cy9lOVUy?=
 =?utf-8?B?TVhCQmwwWGovcFFDTFQ4cXVEYXFuakMyUG5scU1nWjFxZmlzTXlVdWlzRHNv?=
 =?utf-8?B?MWpJV0lLOURrU1JPM01OYU9RZXAvcFZ3TnB1OXc3QytWUFI2aCtPRDVPNVlV?=
 =?utf-8?B?bmNoZEFjTkpXbFdRakdtWnlJNmdXSEczcFova0NzOWI4NGIwVGx1S1EyVUhZ?=
 =?utf-8?B?ZlQwZ2FVM0gvakVCREdIWC93Tk9JUHRVTFMyYUg4S1A1WnJoNTVHa01JazhY?=
 =?utf-8?B?WkhvQm15cEp5S3lzeGE1NnVIVTQ3dzhpZVlLck83QzRKTnMwS2UxdDdLY1Jr?=
 =?utf-8?B?Ymo2YlpjWHBmTm95MlEvemxmMDljbjIybkRTaXZpZFEvRlJUWG83THI2Szlz?=
 =?utf-8?B?cUtnNnArZ1BMbmh2dmM0NHJGNjBweW95Q3JJdjN4cCtkWm5qY3R0ZTNGek1J?=
 =?utf-8?B?cEhyWklscUh2d0QrdU5TYlNyTDJTVDJFSFBCQnFHUG5MVjI5Rm9JM2RCU2tl?=
 =?utf-8?B?b2xTcUhXSzN4RnhEdnhaU25ya3RldElhbmcyZVhRcGpWY2RoemNCZXduSEJO?=
 =?utf-8?B?RGVPTUJ5VjgraEZ4ODF1YWRpVkNIZmdtbXI4Z1I0N1JPUjlwSlZ6ZnQ2dHpq?=
 =?utf-8?B?b1JkdmJLMGdJWlA1Ti9NNGo4KzhrdkhScjE3Z2JJeFBaZjRaRXdBeDZFZVlo?=
 =?utf-8?B?UkRVZXdBY3FENzBvQUx1cEhpUXpJcDU1TFIzQlBZN1VJYjVPZEh0ZktSekJT?=
 =?utf-8?B?dGZoZERLZ3BwOFB1Q1AyK080L1kvVmxqd3FSN2dxUlFZejFVQ3RLQUVzRGta?=
 =?utf-8?B?ZVNSNEtGK3RzUU82L0daUGQ0R01IU0NaQ0xLMzZQUU5Uc3BjN1llUHh6WGxG?=
 =?utf-8?B?cUQ5LzRIL0RVa2xZWWVmUldQQzV5T2lyL0t6NmZjcU8zVjNBcFc4RFErSHVV?=
 =?utf-8?B?VEpIQ2NET3dSMHhsNmdpZVNSMWtHREtVSUI2blBhbDBGdjZLYTNzOHBFUWFv?=
 =?utf-8?B?VWE3QUhxWkRwNlJaZzVpdXRSdXQwR0xZWFFiaVhhWU1uWHFDVlZxYmUyNjhE?=
 =?utf-8?B?bEhjZ0EzY3hjR21Mb0h3ek9WVXJqMldOeGJMZnRGdmZYc2F4U24rTE40Vmcv?=
 =?utf-8?B?R1hMYk50QmU5U1FJd3dUN1g5NnhzNmdCMThzSWxrdDExK2R4UHJqSGN1NHFT?=
 =?utf-8?B?SklSR1hGWmt2QkVyVlkzNGFrTTNCMGJhQXN5ZUlTMTk5WTZteTlXV2huVDU2?=
 =?utf-8?B?TVZxWHV1Uy9TWmFNNzNOSGNVRGpYWFcyb2pBZ3VsN3diR05vQ3U3WndNNy9V?=
 =?utf-8?B?TTNtM1pXZGlVQ2pFQVBZUEd0ZzV4WGRvSU02Z1VHSWg3V1dOc0p5NTVRN09Z?=
 =?utf-8?B?SWt1OTlMZEhwdVFheEh3NitnTmh2RS9iemJGSzRPQU84T1RRMDJOZVVhMjV3?=
 =?utf-8?B?Wk8xT3AzM2loaXMwRE43U0MrLzFQK080SkFmZ05admZVbWlOMDZCaG9TTFF4?=
 =?utf-8?B?M0ljcWljeUNMYkczTlB3bUlnWjJSQlNaQnNBek9McmV3aVQ4TjZYWnZFT1JF?=
 =?utf-8?B?MFdoZjM5TkQzVUt2TWZVbGlSeGZtdmdCUGJtaWNWdm5qbTY5cFlUYmN1RGJS?=
 =?utf-8?B?SzAyUEpkR0lUVzZxWEt1OXFpNFdVelBIdjkvVEFKTzlZT0VFN3hCQjdhRVlu?=
 =?utf-8?B?ZW5xNllyS0NvNnZjODdlc28vVmF3dTNZMXg0ZUsrZWIxMzZFTGNFYWpSYnpI?=
 =?utf-8?B?VzNqN3JGRlh1dzNlY1YrZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEtEYmpZa09Rc1hQZGNrNUR2YnVkbTRibWkrMUNlajl0YmZSQU1PalZIWGJx?=
 =?utf-8?B?Myt4cTBUV1h1STJZQWhpa0t5NHVCd1NSWGloclphaWRzS1pZVE4vZmZhQURj?=
 =?utf-8?B?M3dKTEUvTnRPcGREZGtKL1AvZWNtWnF2VHVoQXkvUWJmcDNtOFEvRWw0K09u?=
 =?utf-8?B?OXh2cHhtMDlyUG1rcXEwN2hnKzMzWHRrSzJFY0tSeUMzaGNlOE1NMFg4RGNQ?=
 =?utf-8?B?UEgrWUJ2ZU5wTWFRVWJTMUxPeVk2M2JkdGhraFBqRFU2NmVBN1ZER0RrNlF0?=
 =?utf-8?B?Y09yWXpWWlpCWnJ2cXpHTkh2SzF1ZFpxckVkUGhtRUZVRVh3S3ZjcGZvTlJZ?=
 =?utf-8?B?TzFOeXRpTVF3YzNIT0E5cEtnOVJPYkFHdzJWTU83dERwN0lRSnpmVThOSkla?=
 =?utf-8?B?VlphNzY4dlpOdUZ0L1RxYlZ0NTRzc3RwZ25TKzk0MzFWUCtPMEFXcmt4TjBh?=
 =?utf-8?B?aTFWYzJBMFVlR1NvSS9hbW94NkNJQzE5UHVjRmx2WHE1Zm1nUGhxVTdFQTRk?=
 =?utf-8?B?ZkxPeTE4Vm5MeFBuQ1VoNUhUQktQN2xWVm9ja0JJMGhhT1k0WUJ2RWptbzZp?=
 =?utf-8?B?UzA0cTFvWlZ3Ukowc09yZXNKU2pZTCt0ckpBUU1DQ1hKWGlPT0pqbW1wVEhD?=
 =?utf-8?B?SzNHZzNscmF3SHB3TWxvUG55c3NKSVlvSDRhMlVHQkRsT0NiOEZodHUzYlUx?=
 =?utf-8?B?SXl5dStrQUVvdUUvdkJFdlVuVEZyanZGdHl3ajlPNVFIMzBBUnh6blVENncz?=
 =?utf-8?B?cjlKNmc5eTdacTNKNGl4cHZTcFVaUE1NcldkeXlISW50NzNMV24vekpsdzA1?=
 =?utf-8?B?TThPR3ltVDk0MjVQRGtWNnZmVlFNc2RVTUVsMG15cC9pZ0ora1VhOXNtdmZv?=
 =?utf-8?B?aEdKM3Izc2h6S2hPL3l5MkFDUkk4MXE5OTV0Z1RzcGU3M0Y5dHFockpQWDJH?=
 =?utf-8?B?YlhZUVkvOXZhVEZYRk9UREpUdkY5YnVTZjVvTVN2MytROTFkRFdhM2xGeGd0?=
 =?utf-8?B?SnNjdzE0M0h4VUFYeUZwNENudVFsVkxBQTRCNFIvSWtmRkZTSUtZMWlzN2Nw?=
 =?utf-8?B?ZEFWdGJJK1hhbXY3QlMvVlNIV2g3TThxdWxNS2d2MXhSQUJXcVQ1VkdkR1RJ?=
 =?utf-8?B?QmhIaEpvdDlBd1d5UWNEOWdmWVNMVjZ3WjJRb1VRNC9iUGNlUXU2Wi9zaTFC?=
 =?utf-8?B?alEraVh0eklHanJYUW1HNlEvcVc1VXpGNVlMQ0ZNOTdta1ZGTUZJdVZ5cnFX?=
 =?utf-8?B?OUFRUWRBTEVEaU9LR0tnUXJXWGY1US9Eb25Eb1lXM09qbjk3YVdyeGY1bito?=
 =?utf-8?B?ZXllVHo1TDdqQzQzcEIraXpDRDBkWDIrN1M3WGo4MkhqRmQrTjY2akMxdVJL?=
 =?utf-8?B?ZUZVdDEyd3VmNEptL3dDUVNPbzM4MngrOHBVUXhKWWVXMWF1QndXM0FDTVhU?=
 =?utf-8?B?Ulk2UmpvSlpsZ3F1cTJOa0lLM1FmVnVwd0FtaG9veXBzdHM5aytoaFMzMjZM?=
 =?utf-8?B?Q3h5RlBnc2wwSDdFY21VbHhUaWZaMC9XK2ozSEFJMlg4QlErcjdCY3Vta1lF?=
 =?utf-8?B?b3FieWNhUVJ6WTV0OHFtd1NBajFQVkt5YlptblNLYnorcWlaem5CRmQ1eEJW?=
 =?utf-8?B?T2JYQzh4dTdpaWVnWXJhb3M1ZWRCTXRpOFdrdUhBUWh3bzJBczNoQkRDQjdv?=
 =?utf-8?B?TzFMN0loWTJEMS9nQytnRjMyWGlsakxTMWZvakJmT3FUd1dYQUI4blhZM3Vn?=
 =?utf-8?B?NHVUbGl4TEtxK1NBcjZaWDB1L2pvVVlFWjhicDloQS9rTFRJY3F6QXA4ZFJl?=
 =?utf-8?B?bWJUaTNNaHVlKzlSc0w4bDhvQWVzVjdXSThIbWh1ai9GaWpHc2FTS1IvZ3BK?=
 =?utf-8?B?MFBWK3F5K1FPV0FoR3pSMWw4bEdXV0xQdVdSTDZ2MG1WR0NjWWh1RFJKaERo?=
 =?utf-8?B?NFI3cEJOOGp3TC84UjdqczlaV3FxRWF4RnNieXNZQ05YZG9yMTRQSm81SzhH?=
 =?utf-8?B?VW1saWhsR01USWl5VjlCbFY3VXNGMGZsSnhLMllyT0RsY2VNdVB2U2duSlVw?=
 =?utf-8?B?QUNIT2RpcmVUayt5ZXp2VXIwZEp1UzZ4Y1U2SXB1b1JucHNEYjVieTVPR3NI?=
 =?utf-8?B?d0M5bmVMSDZYaS9ITm92cXArVWpRSXJYMDRhQkFYUktOKzNvd3BwTWtGeGk5?=
 =?utf-8?Q?Vc7U2PrHQSrQussPLl7whtA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE9234D91C23FF48802DB9A2A92422E2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804830d2-5778-415c-d827-08dc83925d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:43.7160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xm9QNxmm6BXizoxGNq4C8Tx0XYtxcDWPhwYAmOYhkU5MYnRZHcVENnmi50RtvPP/5lefcetgQiewf2KXEzYA0Rdhp1q8pB1rSSt+9AOjAX49RB9VDjHVTRJjlDjpuFVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoaXMgd2lsbCBiZSBuZWNlc3NhcnkgZm9yIGRldmljZXMgaW1wbGVtZW50aW5n
IEFUUy4NCldlIGFsc28gZGVmaW5lIGEgbmV3IG1hY3JvIElPTU1VX0FDQ0VTU19GTEFHX0ZVTEwg
aW4gYWRkaXRpb24gdG8NCklPTU1VX0FDQ0VTU19GTEFHIHRvIHN1cHBvcnQgbW9yZSBhY2Nlc3Mg
ZmxhZ3MuDQpJT01NVV9BQ0NFU1NfRkxBRyBpcyBrZXB0IGZvciBjb252ZW5pZW5jZSBhbmQgYmFj
a3dhcmQgY29tcGF0aWJpbGl0eS4NCg0KSGVyZSBhcmUgdGhlIGZsYWdzIGFkZGVkIChkZWZpbmVk
IGJ5IHRoZSBQQ0llIDUgc3BlY2lmaWNhdGlvbikgOg0KICAgIC0gRXhlY3V0ZSBSZXF1ZXN0ZWQN
CiAgICAtIFByaXZpbGVnZWQgTW9kZSBSZXF1ZXN0ZWQNCiAgICAtIEdsb2JhbA0KICAgIC0gVW50
cmFuc2xhdGVkIE9ubHkNCg0KSU9NTVVfQUNDRVNTX0ZMQUcgc2V0cyB0aGUgYWRkaXRpb25hbCBm
bGFncyB0byAwDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5o
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggZGFkYjVjZDY1YS4uMDA2N2IyMjY2
YSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVj
L21lbW9yeS5oDQpAQCAtMTEwLDE1ICsxMTAsMzQgQEAgc3RydWN0IE1lbW9yeVJlZ2lvblNlY3Rp
b24gew0KIA0KIHR5cGVkZWYgc3RydWN0IElPTU1VVExCRW50cnkgSU9NTVVUTEJFbnRyeTsNCiAN
Ci0vKiBTZWUgYWRkcmVzc19zcGFjZV90cmFuc2xhdGU6IGJpdCAwIGlzIHJlYWQsIGJpdCAxIGlz
IHdyaXRlLiAgKi8NCisvKg0KKyAqIFNlZSBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZToNCisgKiAg
ICAgIC0gYml0IDAgOiByZWFkDQorICogICAgICAtIGJpdCAxIDogd3JpdGUNCisgKiAgICAgIC0g
Yml0IDIgOiBleGVjDQorICogICAgICAtIGJpdCAzIDogcHJpdg0KKyAqICAgICAgLSBiaXQgNCA6
IGdsb2JhbA0KKyAqICAgICAgLSBiaXQgNSA6IHVudHJhbnNsYXRlZCBvbmx5DQorICovDQogdHlw
ZWRlZiBlbnVtIHsNCiAgICAgSU9NTVVfTk9ORSA9IDAsDQogICAgIElPTU1VX1JPICAgPSAxLA0K
ICAgICBJT01NVV9XTyAgID0gMiwNCiAgICAgSU9NTVVfUlcgICA9IDMsDQorICAgIElPTU1VX0VY
RUMgPSA0LA0KKyAgICBJT01NVV9QUklWID0gOCwNCisgICAgSU9NTVVfR0xPQkFMID0gMTYsDQor
ICAgIElPTU1VX1VOVFJBTlNMQVRFRF9PTkxZID0gMzIsDQogfSBJT01NVUFjY2Vzc0ZsYWdzOw0K
IA0KLSNkZWZpbmUgSU9NTVVfQUNDRVNTX0ZMQUcociwgdykgKCgocikgPyBJT01NVV9STyA6IDAp
IHwgKCh3KSA/IElPTU1VX1dPIDogMCkpDQorI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBRyhyLCB3
KSAgICAgKCgocikgPyBJT01NVV9STyA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgodykgPyBJT01NVV9XTyA6IDApKQ0KKyNkZWZpbmUgSU9NTVVfQUNDRVNT
X0ZMQUdfRlVMTChyLCB3LCB4LCBwLCBnLCB1bykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIChJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSB8IFwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoKHgpID8gSU9NTVVfRVhFQyA6IDApIHwgXA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgocCkgPyBJT01NVV9QUklWIDogMCkgfCBc
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChnKSA/IElPTU1VX0dMT0JB
TCA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodW8pID8g
SU9NTVVfVU5UUkFOU0xBVEVEX09OTFkgOiAwKSkNCiANCiBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7
DQogICAgIEFkZHJlc3NTcGFjZSAgICAqdGFyZ2V0X2FzOw0KLS0gDQoyLjQ1LjENCg==

