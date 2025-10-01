Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E273CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tCg-0007lq-LT; Wed, 01 Oct 2025 05:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tCd-0007ke-Dk; Wed, 01 Oct 2025 05:32:51 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tCV-0005OR-H5; Wed, 01 Oct 2025 05:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1J6Cp2wsRQFPf7rKYC/azSq9YNlTtMXgXHXHKMxFo0AEsQwxplr/ZhbAN0zhlo29+81khByC1FwACWxsIlHyr0h2RPe3XQ+seApf2BDe90XDbL+5MtSRv2Tt3qV0ROnDqrAHy85JWBdAyzo6RAyRMFfVqPTqzzclTwTGVSmMDoAdNqlij/GpJjpDRlEjmeo4brgbcB91AOwgtlKaADXALHwF5A16//YOblHbpIpfuSkNkgiSbn34Fm4z6lVaDFpSLAL0aMe/lptnl2Lc6zUufJupAlsqEr2QVq8MYaihsar3Z7OHxjqE4B5nnP+73dOO6+6ceD5HE7D5uLS22wjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtpH+OP1jjaAvktcc97+vSnOisHxfYa5vYRjAFM8uQs=;
 b=n759NIpUVRI+KJGXWs5zObNi5LvwouPRSIFd/gklohrOPjtMSYaZP26wllSOZXKRKAdVBM2art0Sl4GLD1ZAvNO1DcUb5Oo/rFKL1OWS+vxhYvv20iKGf65kl65kco7yj6FZEpFQKJ30F5hS1mjg1vi6LDdnnN3ZOgqOQEK39nMx/qhO+txfDHZi6DQgusUP9CBw3cVmIagIoIcD9y2eF9jJxkpk41zRRLmlvKYxjMrvftZIOE678xSeM72D9VLHEMmLg9ZEqnrgHLASVGJxqt37w1wt68++Hv7YvgxrRKGJF13wZUsGQSEB5DWeN7xKIvmBt5naQO1kxUGMucJPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtpH+OP1jjaAvktcc97+vSnOisHxfYa5vYRjAFM8uQs=;
 b=HRD0mYms2B4v07Swh7dpOcA6MTRzShDqeRkD4xaS1OzPkNtVrMlyjuRKAtZIBp384LTynday6cU6DuofWFsZ9KekjlNwh8VnGT9vI+Fdj642REDxzd3TpawkfUuY4WCwzg4LCaGkL0iivVlvEaO2PgnOhm9yC7Fof2+aNecEtNSbWIzbThwvgIrIw8UiU9HPkgrStyFmWFNTGSAC5Z8iPkdeuhwO7EIpZSStcjNywTCEs92P8fYzwPArIqzae5tfKRRAdWWYqq6AnJpUSZahcsfqTz+4istnqcQ4AqPJPgjq0PDf9X2uAtuDrpp3GrWK1Ci+ZoNnMIjjbiZPW+s7gA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM7PR09MB3653.eurprd09.prod.outlook.com (2603:10a6:20b:10d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:32:31 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:32:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v8 02/14] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v8 02/14] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcLTQnBBo2/HUoiUKPvlIyg82HWLSq8n+AgAIftgA=
Date: Wed, 1 Oct 2025 09:32:31 +0000
Message-ID: <ecb8bcbf-4445-4252-ad39-f2dde68cbff7@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-3-djordje.todorovic@htecgroup.com>
 <CAKmqyKM+FXe3EVR1Mzpq3pVCEFg_wG7qfgkrjFuQ1HiifdGyvA@mail.gmail.com>
In-Reply-To: <CAKmqyKM+FXe3EVR1Mzpq3pVCEFg_wG7qfgkrjFuQ1HiifdGyvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM7PR09MB3653:EE_
x-ms-office365-filtering-correlation-id: 7b51b794-a24d-4550-96e4-08de00cd71e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ek41QTNZODdlcXJTWVlxWXg4T1V3VVhuTXBCbnFscFlrbnBzcnNvRUtXUE9r?=
 =?utf-8?B?YldlZ0VFSUFmZGxZM1ZpdmJuOWZjQU96OFdrMWQ2dzcyd01sZTZ1OGJZbHp4?=
 =?utf-8?B?N010TkFacnhoZWw2T2RXMDBMRFZ1QzV1UythVWlEVHZmOFFyOWxOTGZzbHR5?=
 =?utf-8?B?bnh1c1pMMVNiNzdFbTg1TTdGRXA1ckVhNE1EUmhWbWtmeHIyd0w4dEpQYm9M?=
 =?utf-8?B?RHc4RWFOZXhEVkQxVU5EejZkREthQWxXU29xNlE0UjQvMDNWR1RZMUh1cm1G?=
 =?utf-8?B?Q3FkRVFLQXRFTU1QcjQzVmRKQmswMktUZmhXQnJaeTMzYXQ0bFFjRU45dTlj?=
 =?utf-8?B?aGNlMDNMb2R4OEEvZWRlZVJHZnF2dU9jVm13ajlTVURDck9OcFdnNUoxVEdI?=
 =?utf-8?B?bDVwSjNXeUlMM1NKaFZBNDVvNnZLME5Ia1cxNnRrRzZhN2ljWmlERjA5Q3Yx?=
 =?utf-8?B?ZjE0V29TQ3JNd2tlR2lzOFJ6OXF3WXhJUnVhQTJYN1NGNG40YWtDdUVVN2NG?=
 =?utf-8?B?NFRHQmlwaWt2Y0wyNERZVkdaSVI5aE5SK1g5MVJjcGxYaEFBSEdwUEtUcmts?=
 =?utf-8?B?Q25nWjFteE1xZFJvZjZxU1hWMnFFUVFlTWZvZGx2UVpXcndLdzAwbnllSUdw?=
 =?utf-8?B?SnRBdDhSdnB6UGpCVVltcHpqR2VWSi9SN0JuaTlORnBxcjVkZzRLR3A0ZzB3?=
 =?utf-8?B?Q0xBRGVIK21pejZDMkRYVGFSUjJCQW5VemM1ZWFFcEl1QzErTnJleUxESFEz?=
 =?utf-8?B?YkI0cHdTZEl5Rk94UGRVNjhjRCtjcEpNb2RnMjZmSGMxVWhNcWp3R28rT3kv?=
 =?utf-8?B?QXB5dlpRZllzVHgycE05OFNvOUVVY0VsbGk3eFRIUGNiNjN1d2Vld0h3c21G?=
 =?utf-8?B?M1M2NGIwK3dUOGNXT3U0KzJCczVyVG1yVHA0ZXB0R1VRS0ZLSzB2UXhoV1c1?=
 =?utf-8?B?TVYwRXZZaSt2SzcwUHlSaTVVajZHMTlObXp1eHEyVmh1Qjh4TjVSaE9JWEpz?=
 =?utf-8?B?aXRjZCtoY3dDMnFXMXlUVVhrRVB2dzlKbFFzK0RKQmkydjFVdWIvNWFsMjBL?=
 =?utf-8?B?cUZ1dkZ6YWdKOXc1SmRLRXlidG5QYlp0cU12Wld6Q091eEQvU3lUWk5SSy92?=
 =?utf-8?B?Mm1YaStNamRnSktxdW82NkFsY1ZLRUZ3cUQxdk51Y0l4V1ZZckplY05LeDRJ?=
 =?utf-8?B?R3EzZ3pxVW1yZGpRQjhwQlNmc0tkNDh4c0QwQ0lVQ0l2cUUwVjRSUjhWbnJO?=
 =?utf-8?B?K0Z2NlpPRUcwU2hwZHpsUEMyaXRvVXkycWtMVENWenI1NFdlRVRtdW1nRUts?=
 =?utf-8?B?RE9BMlorcDdlSHZmTUZBTUxGWm5UL2RlUkZJTHUwejJIL1hOVTV2Z3MzRWp4?=
 =?utf-8?B?T2JTTUZ5aVd0MjE4anlkSHBUbjFjc3RSNFpua24vYnBpWXBuWi9qV3BiWW82?=
 =?utf-8?B?M1dMaVR6TG5IS0w3bW11Mk1ITXgzMENmUE1BcC91Z0xQeEgxNTdVZGFDU1FY?=
 =?utf-8?B?WWNkVDQ4VUFTdWw1MkdNQnRsU245akxLaW1zVElUbjJNZnpLVEFXWTJsWE1E?=
 =?utf-8?B?WURjZ1hyN0hVR0xXWG0vcWwrYzg3ZFBtSFJWYmxZNFZjZjA1SkY1T0h4Vmoz?=
 =?utf-8?B?UVBjMEJlVTM3bklmRFduV3ZJSVBYYWxaV1htTXJjS1FFREExamNMSnFEZGcy?=
 =?utf-8?B?WmErNnIxNGhpaFhoeE0reG94YlJDMFhzYmdGQjlkeVQ5d1RSTnhtbkNCdTNV?=
 =?utf-8?B?K29MaGErU1dSMkx1TkhUTW5naUxSTCs0ZitXVGJBN2IzUC8wNXRvMjkzN3Jn?=
 =?utf-8?B?NzJaa1ZLZnNLU1VaaEprcmx6UzdmYmJobnVvMDFkRFJQZC9hMnFwTk4xcFEw?=
 =?utf-8?B?Yi9MNDBHQ0VFaWh2TnJPcXVOcTVsZVJzZEMzejR6NUF1YTFQM01ZU2tDVFJo?=
 =?utf-8?B?ckt3RHVzb3NxWFdEZGhIamlvZTZuSmpXL0gyZHF1L0pmaUV1Qi9OVWhDTTZa?=
 =?utf-8?B?Mll3MDE1Ynl2U2FWSkoycWdDM1hOdXlOb0paRmtIVG1KZUZvT0ZZYXFMT1Ar?=
 =?utf-8?Q?DXYGJL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEdydDB1ZVZRaGZqNHlHSFJQcHdPYmNod2V4UVdDTnFWdUhOeE5jUWlSK25X?=
 =?utf-8?B?bWlJdFdtTCtKS1dBRFZpU0dDRnpmK1FwQUpXZlFuV0tyQjRBUnI5Rm5nZ25m?=
 =?utf-8?B?eXg1U2s4blpQeTlkY3daWGo2Mm9pTFl0YjFMUkV5KzNCVDBBU3U3SlBibWpa?=
 =?utf-8?B?U1hsUlJncUUzYmc3Z1pUc05OWWMxdEV1N2xJRFBZTWVIRS8yWC91dEszWkFW?=
 =?utf-8?B?K0hZWm54SCtpbHdSMmgwb2EwZENBRkFCODZraGpjWlhJbEFqSlo4d05tRThk?=
 =?utf-8?B?QnhKMEVTNmZheW5ONGVYS1dZSjlHL3kvZEF4L3BFZW1GWTBSaXE0aDk4N2RN?=
 =?utf-8?B?STRyRVZFV1krQkY1dk9jbXJHYWltMUFlek1JQXJUNnhCV1YraGEvRTV3S1h5?=
 =?utf-8?B?UVQ3TGt6VnU5TXVUSGRKZHdJdWdqdHJQelVjY2FzVGdpVWZhcWdnVkF2TzBE?=
 =?utf-8?B?cXhtazR4OXZiNW51cmE4NXI0UC9hS09wN2d3eXpza1NGaWdwZDVOSFRRNmtk?=
 =?utf-8?B?VlBKek5KWlVWb3hUMzZIbUJiSmFaTk1lbk1kY3hmeGw1bS9VQ0ZTR3p4dmNT?=
 =?utf-8?B?RWI2TERBa05SbWdPMG9XMG1zOU1NbWlLanlEb29EK2J0SlloS2ZKRC9VNW1P?=
 =?utf-8?B?cEI5V2c0K25GK1Qvbm13M2Rtd1pxWGN6VEo4bG0xYVVFRmNEUFZPR2hxMGZN?=
 =?utf-8?B?QlRYckVIQTZ5UVdZNWkyYjJma1JhanBwUkpkQys5ak5Rd2M3ZVpYQWhmc1dR?=
 =?utf-8?B?VDErbnRFWGNhQlViZm9xd1ZaMFE4Zko5aTFYMmU0QWxFTUhpVXFvRGN3a1N6?=
 =?utf-8?B?QXluUFRoT1FFdStzdmY0eEZ0emRsTDZIeHpNRHFtbkwxWlBFYm5YZGk5Sktm?=
 =?utf-8?B?NXhNZy9YT3FGWGZyTXpjOFpKRDEzNXVWd05zWTJieXB0bXNYTHBjR3kzbUVR?=
 =?utf-8?B?TlpVQU5ub0VySkFLZEpvK3dQNmM2N212WGJPSVZ2TGZwWlllNXRsRW1JenAy?=
 =?utf-8?B?elhBWEM0Mmxld29UT1FkblpDMmZycVZnNEVLbmJHWnN4cEhRMHFncXk5c2NC?=
 =?utf-8?B?STJGVlhINlBUaDUyeUszUEw5TVVlaHpzdlk5R1FZeURBRitrUTdLYjR4L1p6?=
 =?utf-8?B?MGJaalZoUUhIMkQ3c3NPODM0VmwwUDNwNzEyNzhJYUZBeTIxcVVydktIRXcr?=
 =?utf-8?B?TUUydWZRaFBlTHE1QzZRYW1CVWdrblFObHh6Mjk1aUppbzNGaXN5bjM1bmhY?=
 =?utf-8?B?c3BuMTJ2UEhab09wVUFic3ovUXcraE50QnNmU3pTbURoRkZhTjFaTGwwblkr?=
 =?utf-8?B?c0RoN2FGaDBKelNtdml6ZHJSRVd1QlYwRTNjOUt0cTAyeXhBTk5XaXRKUllU?=
 =?utf-8?B?L21qT3RvdytmYzdXalZER3haaW1wTGZSYnJqTUgxd3BzckFsRFNMWk92bnYx?=
 =?utf-8?B?NG00UlhITlBQMnQ2Q2NoOTFMMjVzMVJNWDZub1VDandPOXIxNlVWZUJGblll?=
 =?utf-8?B?QXdGdU5LR2FENkxDNUxuVjljTnNPbkhGaTc1cnBNUHNlM3BHcFpiOW42WFd3?=
 =?utf-8?B?VFBNS1MwN3JVYU4wNzAvZkVEVEtBQVRVV0syYWtnenBXM2dhV1gvcUJiL2Fw?=
 =?utf-8?B?QnNQRWpOSGR2VVhtK1haRlo1bkVLeCtKWjBLbWpvQjkyMlA2b1kvVU5teUF1?=
 =?utf-8?B?UjhhQ1hDMThMMUxiNjJIK3JhTW45SkFDS2pvMjF3dGhzMXVEeVVwQmhYSzJH?=
 =?utf-8?B?blN1Z3NGWFhwWjJnUkFZelF0VmUvZGVYMzVxMm1PandDRGFLcXlueWJzaGxC?=
 =?utf-8?B?VlpOT3JkRWcvb1htNEtPUThaRndsaDNONnRXVFFpcXVuejh6TmNzb0djSnNX?=
 =?utf-8?B?UC9GN25uWHVxMURTaE96SFY5dFJ4UWdlaWx2b3Y2N2dZYmtGVDVzRVlzU2c0?=
 =?utf-8?B?R0dQNjFaaHBQNlhkRWwvSEhWdk4xZWtZZTNzZ1hxNllSU01qOTUySDA4NVNp?=
 =?utf-8?B?SWlEN1pwcGJMVUhwdVRWbUtKV0t1YWZRbXFTQnRLQXZBNi9IRUlucmxUZEJh?=
 =?utf-8?B?UEZ2TlZXNkh2ZGdMNEtIY2NDQXgzYWppU1p2SGZ5M1NPSGx0eFd5OXVjVkVz?=
 =?utf-8?B?Y1RXN1c4aWtOekh6N2E4cHhYQklPWFR2RDZLcVAvbUEwZll3STJiNFRIbEEr?=
 =?utf-8?Q?WxAxhgz8iLF+a3ypJcOr+5Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5893F8501F3564EB22702FA4390DA20@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b51b794-a24d-4550-96e4-08de00cd71e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:32:31.2045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7yytI0yqUkX4yTWIUbJW/pUi8T0tpajKBKFDghvjVGxVjWRTj+tOVkoP6k8tuq6AZ1lscO9ulKG6eo3Kpgb2a9FJYseWADfPv91Gz9PV3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3653
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

DQpPbiAzMC4gOS4gMjUuIDAzOjA2LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24g
V2VkLCBTZXAgMjQsIDIwMjUgYXQgNzoyMeKAr1BNIERqb3JkamUgVG9kb3JvdmljDQo+IDxEam9y
ZGplLlRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPiB3cm90ZToNCj4+IEFkZCBhIG5ldyBmdW5jdGlv
biwgc28gd2UgY2FuIGNoYW5nZSByZXNldCB2ZWN0b3IgZnJvbSBwbGF0Zm9ybXMNCj4+IGR1cmlu
ZyBydW50aW1lLg0KPiBUaGVyZSBpcyBhbHJlYWR5IGEgInJlc2V0dmVjIiBwcm9wZXJ0eSwgd2hp
Y2ggaHcvcmlzY3Yvb3BlbnRpdGFuLmMgaXMNCj4gdXNpbmcgdG8gc2V0IGEgY3VzdG9tIHJlc2V0
dmVjLiBXaHkgY2FuJ3QgeW91IHVzZSB0aGF0Pw0KPg0KPiBBbGlzdGFpcg0KDQpIaSBBbGlzdGFp
ciwNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQpXZSB3YW50IHRvIGJlIGFi
bGUgdG8gY2hhbmdlIGl0IGR1cmluZyBydW50aW1lLCBlLmcuIGZyb20NCg0KYHJpc2N2X2NtZ2Ny
YCBhZGRlZCBsYXRlciBpbiB0aGlzIHBhdGNoIHNldCwgc28gdGhhdCBpcyB3aHkgd2UNCg0KY291
bGRuJ3QgdXNlIHRoYXQgcHJvcGVydHkgb25seS4NCg0KVGhhbmtzLA0KRGpvcmRqZQ0KDQoNCj4+
IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVkLW9m
Zi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+
DQo+PiBSZXZpZXdlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRiYXJib3phQHZlbnRh
bmFtaWNyby5jb20+DQo+PiAtLS0NCj4+ICAgdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgMTQgKysrKysr
KysrKysrKysNCj4+ICAgdGFyZ2V0L3Jpc2N2L2NwdS5oIHwgIDQgKysrKw0KPj4gICAyIGZpbGVz
IGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+PiBpbmRleCBkMDU1ZGRmNDYyLi43NDcy
OGM1MzcxIDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+PiArKysgYi90YXJn
ZXQvcmlzY3YvY3B1LmMNCj4+IEBAIC03Myw2ICs3MywyMCBAQCBib29sIHJpc2N2X2NwdV9vcHRp
b25fc2V0KGNvbnN0IGNoYXIgKm9wdG5hbWUpDQo+PiAgICAgICByZXR1cm4gZ19oYXNoX3RhYmxl
X2NvbnRhaW5zKGdlbmVyYWxfdXNlcl9vcHRzLCBvcHRuYW1lKTsNCj4+ICAgfQ0KPj4NCj4+ICsj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4+ICt2b2lkIGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2Uo
aW50IHZwX2luZGV4LCB0YXJnZXRfdWxvbmcgYWRkcmVzcykNCj4+ICt7DQo+PiArICAgIENQVVN0
YXRlICpjcHVfc3RhdGUgPSBxZW11X2dldF9jcHUodnBfaW5kZXgpOw0KPj4gKyAgICBpZiAoY3B1
X3N0YXRlID09IE5VTEwpIHsNCj4+ICsgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VS
Uk9SLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAiY3B1X3NldF9leGNlcHRpb25fYmFzZTog
aW52YWxpZCB2cF9pbmRleDogJXUiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICB2cF9pbmRl
eCk7DQo+PiArICAgIH0NCj4+ICsgICAgUklTQ1ZDUFUgKnZwID0gUklTQ1ZfQ1BVKGNwdV9zdGF0
ZSk7DQo+PiArICAgIHZwLT5lbnYucmVzZXR2ZWMgPSBhZGRyZXNzOw0KPj4gK30NCj4+ICsjZW5k
aWYNCj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgcmlzY3ZfY3B1X2NmZ19tZXJnZShSSVNDVkNQVUNv
bmZpZyAqZGVzdCwgY29uc3QgUklTQ1ZDUFVDb25maWcgKnNyYykNCj4+ICAgew0KPj4gICAjZGVm
aW5lIEJPT0xfRklFTEQoeCkgZGVzdC0+eCB8PSBzcmMtPng7DQo+PiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+PiBpbmRleCA0YTg2MmRhNjE1
Li4zNDc1MWJkNDE0IDEwMDY0NA0KPj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+PiArKysg
Yi90YXJnZXQvcmlzY3YvY3B1LmgNCj4+IEBAIC02NzIsNiArNjcyLDEwIEBAIEdfTk9SRVRVUk4g
dm9pZCByaXNjdl9yYWlzZV9leGNlcHRpb24oQ1BVUklTQ1ZTdGF0ZSAqZW52LA0KPj4gICB0YXJn
ZXRfdWxvbmcgcmlzY3ZfY3B1X2dldF9mZmxhZ3MoQ1BVUklTQ1ZTdGF0ZSAqZW52KTsNCj4+ICAg
dm9pZCByaXNjdl9jcHVfc2V0X2ZmbGFncyhDUFVSSVNDVlN0YXRlICplbnYsIHRhcmdldF91bG9u
Zyk7DQo+Pg0KPj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4gK3ZvaWQgY3B1X3NldF9l
eGNlcHRpb25fYmFzZShpbnQgdnBfaW5kZXgsIHRhcmdldF91bG9uZyBhZGRyZXNzKTsNCj4+ICsj
ZW5kaWYNCj4+ICsNCj4+ICAgRklFTEQoVEJfRkxBR1MsIE1FTV9JRFgsIDAsIDMpDQo+PiAgIEZJ
RUxEKFRCX0ZMQUdTLCBGUywgMywgMikNCj4+ICAgLyogVmVjdG9yIGZsYWdzICovDQo+PiAtLQ0K
Pj4gMi4zNC4xDQo+Pg==

