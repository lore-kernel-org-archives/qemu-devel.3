Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E6ECFD63A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTxz-0006ah-Pr; Wed, 07 Jan 2026 08:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiqi96@hotmail.com>)
 id 1vdNtY-0003fa-OT
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:23:52 -0500
Received: from mail-japaneastazolkn19011034.outbound.protection.outlook.com
 ([52.103.43.34] helo=TYVP286CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiqi96@hotmail.com>)
 id 1vdNtX-0005rm-3A
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:23:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZganPp1heFet+YBCzSlO+wPnRlQS2oKhM/z/AGoFUw1oDBjWnOJQKrtclihjx/2YmPqzG8nwzwZkpBBQR+S19UBXa4VEIivSBQjcEIBWIPrp6XbylK23gcwZQJgyEE5NMHLMeJaMfu3A+7WIdxa40HcMqMIGP7Ia3FgfI8HlClbOl7CsqfM6VOyYBPFlD0ybWDtMmVfOV76N/RuJIpL69yaURtAm7I203euikXHZHWhubWRQJ4yVoDDCdm76uYKpsSk5alkSJ0AEIgKhn2L6Rdq2Wm6XQtBUmMbYnfOMnaf/S8/HTupy8DaZxZmcJROqFsPyHJxa9TpAuVGYEWFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me2C8FhIE0czVhrqL/1Ytg/dthTNHblLoOBdHcmSkac=;
 b=VLPrFWKEvTGM/i6r1lOzmOfnMSeSWnyOvL4fBmOlGOFUYvYw26/o8XOObxmLnJdd0B5BmO3Le2FbQxRUIO1ScbbU5PntFJrNa05itdYkfQHTidh3Co9q2lGYV9FHYKDUfQpuCDHIw/WBOdBYg7LkSuzVJJYdjZTcD9MMkoDjt2cBFy6kPy9pC2iKGrMj3ZKy3D7SBpEFcVPKWkZG+r8UHzDvMgR+o0qpvERcSTnjcr//zRvNl/H/XWamJHm6hJW81HdADoje4pGKWkPZlhP5UAZz3P7LzIKz9pQLXs+LAMJveRYd6PA4WYkVIcUUi+VsGsZfVIw+xOupfxtF5g3ikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me2C8FhIE0czVhrqL/1Ytg/dthTNHblLoOBdHcmSkac=;
 b=FiqsJHeCebHyqbcdQnC6ZSOClAffjQPImwJsXy6s2xXkDf6EJoprrsaeGXlC9OeozpsqkkCEDPKEwNQ8O1FnrO7cBewaTSZf4myCHj1OWLWjrMjW9CNWnisrGw/2tW/M/Ce1/2LSpo3fvsJ76oIwiA1vjPYKVlLUukQn+XsJXW1BQ8ZQ2Kb74N4IELSZx8auFf+HyNwi0Tq2BDdI55/3NnlYn8yuvrWLVAK8y8RwFfQKSYaPAMdFLBUBf8KHhghTlj4z/2cVCKzK9qNpqqFDMPyews2j+rvMf6tTzdM/JFr6ky8LeA2kfFhUu/hjmuCY019N4SwQHnUtDoshJ/L7iw==
Received: from OSZPR01MB8340.jpnprd01.prod.outlook.com (2603:1096:604:180::9)
 by TYRPR01MB12189.jpnprd01.prod.outlook.com (2603:1096:405:ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 07:18:44 +0000
Received: from OSZPR01MB8340.jpnprd01.prod.outlook.com
 ([fe80::9ac5:201b:5f3c:ffdb]) by OSZPR01MB8340.jpnprd01.prod.outlook.com
 ([fe80::9ac5:201b:5f3c:ffdb%5]) with mapi id 15.20.9499.001; Wed, 7 Jan 2026
 07:18:43 +0000
From: Anquan Wu <leiqi96@hotmail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: qemu whpx
Thread-Topic: qemu whpx
Thread-Index: AQHcf6Wh4R5vucB+sEaPT3YcMItXrg==
Date: Wed, 7 Jan 2026 07:18:43 +0000
Message-ID: <OSZPR01MB8340BA4527E065073376C8FAB884A@OSZPR01MB8340.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8340:EE_|TYRPR01MB12189:EE_
x-ms-office365-filtering-correlation-id: b57643b8-f6bd-4df7-519f-08de4dbcfd74
x-ms-exchange-slblob-mailprops: VTa9p188PRMAZ2nTFE5GE8mes4GaiFflZk2xSxEDQnpgT/XgFFA2iZXOVy2BTPdgerDYxMad7RR+vqxpzFizC3mmVnx32fBSBqZy+wt1NTitvO0JrNYa3oih+qZcGEIZdO2MZTte+qstNfMtE/Giyupf1s22QRp+fNuEticuoglW9FoDBQ3mUsnX3hqsA72OJSFTRgXY8iVs8ViHnozNfarnqoM0lW9mu/IcWBpMEZ4t/ZCP5p12pGXuX71I0g//7sZF+lrIGaGRnZCjOtFouEmRmXlZjy+BdUgoYu0wEEVuNtr8ueuVvt0LGsENKh3c9uUrvPYyqmgsj3m25PI0LYUdMa5uSpb+iC/w8HVFTTWXI5/02F32gqiFqI/iu93cmSVw+ceXVtWyJKEumUV6KL18Y8NENv9I+x42Lma+/ospfMeKhWQ3rBmj9zO7E/18vdnwSEu+nNQaDQ+FJ0D4pmzaSFFJX7B6AoEfa1Suft2/CN0gfPXjW8Rrtnx9jilNu1FtSe1FEKaiq++e/KdDh+YKixA3ufNRHfvYw31+ZMcdN34/2CMFc7unsZGHinwkYSeqIBAcC5jEtm5K28UFEMxi02UBUS/y8nS32L3g2phD87jApONmT9XfrZdrYm4W
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|55001999003|20031999003|15030799006|15080799012|461199028|19110799012|39105399006|8060799015|8062599012|3412199025|440099028|40105399003|26104999006|102099032;
x-microsoft-antispam-message-info: =?gb2312?B?NWtJTENubGFvNWNXdkF2Mmk3TklENkd5TDdZVzJCWmpIWlp5amt3Ty91Vm9K?=
 =?gb2312?B?cytjdERWZm56eXBtRG92N210SkVZK1pBbGNoejdqVGNwc3VIYjZOd3g1alVS?=
 =?gb2312?B?TmJqV1pmbm9jREhsbU9wOGFZOHhacFdCMC9VUVBQZlhEREd1ZjJiMUkrZ0x6?=
 =?gb2312?B?QStYZ0pXZGlnWlZIYTBIRHQ3T0VvMDh3Wm1MdG1MMU9mOGJ4dFdMVng2TGlj?=
 =?gb2312?B?S3Jpa1hJUytlSm5ob2tZcTVGTGhldU1VQlAyejkzU2dhWmFpK0NqRGhVaUpz?=
 =?gb2312?B?S1JmMlI0eHZHajNhM2xaOEZaSG5WdVd6Ykw2SXo3aXU4Y2ErMFJXQ3Q4TElY?=
 =?gb2312?B?eFJTbk41aUQvUjY4dnZNNGQza0J2REZKcmgyTjFrbWl3RDZtQUpTZnBMSjlR?=
 =?gb2312?B?NEVZWUdtSG9MbVUxSUhFeHF1UXdJSGppNDFmUE8rVHQyVDVhMU8wYmlmREJS?=
 =?gb2312?B?SU5vTTVYUXN4KzBUMlg0NjdEeTV3cmx2WUE3L21USncxbDNSelUvODk5WjBB?=
 =?gb2312?B?Y0JEZEN0T2FpREowRjZzZjZFbllkTmNDblk5UFIrbUp1YkxLU21nWjNRS0Y3?=
 =?gb2312?B?eVR5MUtqa1k3c2xyU1cwby9SaWNxVFpraktLU29GazFVcVg2WmtmSWd3V2I0?=
 =?gb2312?B?NFUwSDQ4THZhb2d4cVpXL2k4T2p3TDNZVlE0LzdTZUpZaTY1MzBSWVBKVllN?=
 =?gb2312?B?eTE3YVpxSm1LVTZPT1BRVUlxSFUwMlVlaGpMV1k0YTZ6UWRla0JYazRIYlJX?=
 =?gb2312?B?MzVpRi9JeWlpZ09XYU8yd2FTR3JCYmMvZU02RHVrVHhZbTF5SVN4UE1QbXQ5?=
 =?gb2312?B?MDA0cG1rRmlMQ25mc1EyTWdjYjVqci9qMzRveUlaTm5jMzRoSE5FaFNrVUd0?=
 =?gb2312?B?WFF2d29xWTMxV0oyYTFiYVRrMy92NmVnZ25hUko3ZWFPVUZlNnh3YVQvcHBG?=
 =?gb2312?B?eENXeklpajJNZWtaSFlldXlhUmtLZTFyMHpKV2hqYUUyWVg4WnJBTjFITnNL?=
 =?gb2312?B?NXdvSlFHQkpNUGRrbTloVVVCT25WdjgwTUNPNU13U05vemxVQ1NxWisvZ1Mz?=
 =?gb2312?B?clo4cUFvdVJDUXlSeXV2OVY2S1BBUnRPOSsxaHM4Q1R6cTl2VjJUTFFVM0xY?=
 =?gb2312?B?eHpvQmdVZkdMU244Tk52N0doUXl5M2dEQ1BlQzJQSUNxRjloTjNNVEwrMWRZ?=
 =?gb2312?B?R3hWZGliejJtRmZHNWJmWTcxVG16Q1hweFhBazkzTklxN0U2NVdNeHhYd1Iw?=
 =?gb2312?B?dmZlMnowMW1CdlN6N2o3T052Wm44VlBpNVpVaVlOUU16RGhRYzVHdTFLQ1R5?=
 =?gb2312?B?VjN3Q2EveGwxSFZxQ042N1R3eXpOOGFTUVo4QldyUW9SRGY0M3FkMHZtRHFX?=
 =?gb2312?B?ZVRQaWV5TmF3aXVJSmVsTTFqQ01wR0VnbHYycHZuMlE2UTBobyttQ2VxR3Z6?=
 =?gb2312?B?cDZEZXo2S0RyZXFDSFl6SExmZ0VFTVJkSXRPRUo3MWg2RlNiM21UQlNtbU5s?=
 =?gb2312?B?TmVUcytTOTVpbU5pL3NlcHlURDdEQjNMbWUxL2p5NzN3ZGo1VUV2UHQvRjEv?=
 =?gb2312?B?Ykt5NU5SY2lSM0dOSFNnRGFjME5pNkdOemV4bFlPY25BMjNqeUVEbEloMnJq?=
 =?gb2312?B?MzdlcjQzVFo4T29SbHdPMFg3RlVER0xzc3lhdSszdEdIb1FNM2tTR2YxcXQr?=
 =?gb2312?B?WlRGNy9TQmtENGQ4ai91WVNMaHZ3WTNtZm9TRXNjZlJyM2Vmc2ZIVThUYmpm?=
 =?gb2312?Q?thHSQql6W0v27+rWSfoo5ogEE4yDG4y48cUS4RT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N0h3T3pDNWlQRnVmSFNUaHlnVWRjRjZVWldyWVRqUkNWeFk2YVdYZDJtZEJx?=
 =?gb2312?B?TmNaVkZ3ajdQZE1zYWJvYW9HVTZWem5BbC9zS2hqS1NRMjI4YnJqVXphWVFV?=
 =?gb2312?B?R0ZBd0RaU2JuTWZEZUc2cGVHc0JYcWtCVGNudk41VkZSRmhBUzY4bGxxMkFI?=
 =?gb2312?B?SWV0RFk5Rk9FclZiNms3MXIzWkhra1NuYTJoWHpPa1pUUDRHVWF2RC81cnpI?=
 =?gb2312?B?RWZWSVdTVEI3Tm56VUVkcWVINmFnamorUkxsU1dQSkVQSWFoT3U4NUc0UlRN?=
 =?gb2312?B?UDlkU0Z4NEljdlV5V1gxUGhlK20xaEJzQTZVUGRLWEEwb3QvRmJRanF2UW40?=
 =?gb2312?B?SXVNSEZhZUlvSDV5SjVSQUhYQXZpK25zNnMrak9kSGNmTG9IRWtxcXJVQmRm?=
 =?gb2312?B?MTRJdWFzTE5ZMmpFUE1kTmovZWVsd0xKbXc2Y2QrOE9TUE1rRTZJaEpRcU5x?=
 =?gb2312?B?TWZsMkFBaFRFelh2dGlZcHVUNUZvY3VUV1VqbG1vRXVRM3E4VTVvTUN2b2k2?=
 =?gb2312?B?MVMzMHZxSFBOS0Q0ZTdnSXpMUFRIZTh5cExkSVlmb2NNMFpNc3ZrSFNJK3kx?=
 =?gb2312?B?aElWUXUrbEI4QmQ2N3JYNGp4cjNXZS9tdDZ1S1pPVTVyNHJteUZmOExuQnFi?=
 =?gb2312?B?dTJxU2NGUVU1WHU2NkVETUFtdUxSMk55UG91WHZxYnlPZFBFeGI1dGhIQ3ps?=
 =?gb2312?B?SDNrSDJrTnlKZmlFc3NZMVpjL0hEL25DNWx5U09meHhIZmNsdHk0TUtCRmVE?=
 =?gb2312?B?YXJMVGNWSG5pSVJSWmdUWTNHaXZ5OHZkYW4xOUh6NXZvQmEyMGJLelV1VVVj?=
 =?gb2312?B?bjZETnZnVWNORUFMc00yMzNjSFdTSTB0UzZ6Ni9wWnlXZVF0dDNtS0p4YmxD?=
 =?gb2312?B?OGpXa05rNmtwUEhDQWhQWm91T2ZzZnNyTDdCZ0hHNnh6RUU2SVhwUGZ2dHpS?=
 =?gb2312?B?MWdKY0VQWC9hbkF0a3FUMFpXTWdTbERTdTdEbFd5RkJDcGZ3OG4xQXZNUTl1?=
 =?gb2312?B?R0Q2RU0yUGpGeDRWRWw5dGhXK1YzM0l2UHBOYUFOeFhBUDByT0I0WWNXdlRU?=
 =?gb2312?B?VWFVVTNUVUNwWTlXNE1xaHZza0RUWTRiRStoVzRnazk4L1V4cUZiRXVIVjhu?=
 =?gb2312?B?ZUdnU0ZnT3VaV0g0Wmt4SGw5OWZnV3NwQUxKNlFjMi9IaDRxWThGQk1ZLzR5?=
 =?gb2312?B?bTdESytHemRKWDMwa1U2ajBXb1VvSyt3RjZPRmcrNlBtWTIyY1dkZlVsbUMr?=
 =?gb2312?B?NWY4aFRwUktYcDFycmFZa3hOQk1HNUdHbXN3U1NOSmxIcUcrOTdmS2Y0clJM?=
 =?gb2312?B?UDZpRmZwbURsYS9JNFZHK296UXRBT29mNjhwTFZOcjUzUFk0cG4zZmQvTDJ0?=
 =?gb2312?B?Vksxc3M4TjhveUFURGozQVRqZnBmcXk2N3FNSjkwM29lMjZXZXlOQ0ZOS3R6?=
 =?gb2312?B?ZXFUamV1SXJ1SG5jZHpzRkg2K1lzblN4WVhjV0sxcDh1OU5aUHN4eWlQeW5R?=
 =?gb2312?B?aGJZRU9vR0o5OFZiMnpQM1N6SHBFaFNab280M0hjWDlZL2dQMUJKYnlLMi9U?=
 =?gb2312?B?LzBNblFmb3JmaWgyUE54YkNUMC8yK3pycHByWTBHU0V1aFU0VzNQckZvczFW?=
 =?gb2312?B?TnROd3NsUWNGU0NvOGdzd3FrK0QwdkszRThKcGsrTmpVc2pwWmZsdXY3Uyth?=
 =?gb2312?B?NUJOTC9VK3l2NTNnUGFpNFYyZjdBM3pTWW1XQ2JMeGtBSlBWU0lzNEFXbW5t?=
 =?gb2312?B?YWJBaU40NE1yektpdm1lZHVXTnVJZlBoVkVzOEFBTUZFcFoyaU94MEtCRFBr?=
 =?gb2312?Q?VXVYJVdVNWoJE88nabG+MegVBaVLv125DRRU0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-96c32.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8340.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b57643b8-f6bd-4df7-519f-08de4dbcfd74
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 07:18:43.4528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12189
Received-SPF: pass client-ip=52.103.43.34; envelope-from=leiqi96@hotmail.com;
 helo=TYVP286CU001.outbound.protection.outlook.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Jan 2026 08:52:49 -0500
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

aGVsbG+jrGFsbAoKTWF5IEkgYXNrIGlmIFFFTVUgb24gYSBXaW5kb3dzIGhvc3QgY2FuIHN1cHBv
cnQgbmVzdGVkIHZpcnR1YWxpemF0aW9uIHRocm91Z2ggV0hQWCBhY2NlbGVyYXRpb24gd2hlbiB0
aGUgcGh5c2ljYWwgQ1BVIGlzIEludGVsPwoKdGhhbmtz

