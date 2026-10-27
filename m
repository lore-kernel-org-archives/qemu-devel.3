Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=P+hNkCRM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaJH-0002tK-1M; Tue, 27 Oct 2026 02:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLaJ6-0002md-1Z; Tue, 27 Oct 2026 02:05:14 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLaJ4-0006Lt-68; Tue, 27 Oct 2026 02:05:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN8y+ByAfECjXoFacDrH+nV2EqTPx7ZEOzJ3QwDstIbM03FC4XGXi4EGDXvu/QM8j4CY1gDAY9Mlvl+cZoHqtaRFppZ9kRSv1Gro7H8RKRXsg8En8OPGvgBx4NbSN/YHonNVrD5KLChTsajUoAv3313a0s0XcP4qI4kk2ByidGH8qNfhMFZ/dFWPMQ3yoOPe3lXi0u73mWmsffAvxe4TvtZkzbX7ArXWhtdWTpFL5Y5rU1skUJW6PkyZ6NNItLjIdQ8xRu2oB2+7IJRw9ySCDN+peY74I0k0aFx1LVVQs32AhOskjhaQlw/evM0WFsAWDGwnlxAsZkkAM9NtIIBYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SJFDcv2KijFcRomEbfNGdMBnOeDl/YkHDNvca8C9Qs=;
 b=CpgnLsTMnEej2dvs48lRoYZgRRGfQALP75bZ9LoN4mUI3WXCgRMiHcAY5lDvbSrVIFtqrlUVIx9ooUqlu1DJhZLTpAD4sP7c9NlCShftY3vCQF4eIcOBaVe212DGYIT8l6PBWdUz5KDKvwWdsVopqgwcBUTjsAz2DeCmmHju2sixWXKqAQOrgLMpynxmA4yhhoEpQU30PK5VgtaUVdDnGbvr7ZNqh5sqVHMHPDIr5aKAaejwqUMNZGQqka+LhqiUzQhSXAP79cwz95qYhSMmDqoTiiwReiJtjwXOadqaU2gS+ms86iaLPFa45CRBWzSh1yzmmS6ZWV3lf6GYL0tJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SJFDcv2KijFcRomEbfNGdMBnOeDl/YkHDNvca8C9Qs=;
 b=P+hNkCRM3HCIE2ZZ58N5zoH0MTEtKotLSEC3fnbkpP20HnKj3jO9vDcOQPH/ZYXQesi8/KjcHmwQLVlKU6CZHKBM0IMEUyBDR/Bz07hu04VcTbBfPdtp2bBFIp+sNKvcPkyBDXQkMHnIi1AwZJeq9pZ4Yj8uHtEcmkaxOH+2dbMqes82ZJaTpYMPtap/FmOrrRicemc9B+9INeSVsuFBZXlH9iB9+EQyDxdvxHslSNfdbiL9b+/FsyA9d6Kp+zskke+aMke4mznovz4/bIDoLSeBQuuhBLsduJSpCoyUBlV/6MpwJt71HMSz5L6cuM33q8K7pZGbXlJMgVEzxUsNNw==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by SI6PR04MB8307.apcprd04.prod.outlook.com (2603:1096:4:23b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:05:00 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:04:59 +0000
Message-ID: <TYZPR04MB74913D01748558160FDBD92AF3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 14:04:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261026141642.113731-1-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261026141642.113731-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <0a7f128a-568d-4cc6-9768-5a87875bcacf@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|SI6PR04MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: b535f37f-4259-4362-02f7-08df33f03b44
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7mKclqU2hR2DqDJnyROaBxFFN/2To/eC43ikK3HFWHd8sxuL2rrFeEnlA5suA2q5UF3ryjbSsD6Jod+8tMt7VEMclY/P3YK1FN3PCvcC1EAMirfc6zx9BD7f2jtMyvFcQqd+qg9N3lwwtsC0khwz0tAqnI4xA0kE4+6S48tluJjahtzzfMyRC83gK9zZ5kRxuER0PUrjYju7mFyKvT3qQTutjGdLAGZ7UBh9qGJTsUJkMLpEfprVwaSQm0soXtnerYhKUGLDa4AHq125kCDij1g/bDTrjLDUeqkZOj5L494GDIzp1e5L44Lg5eVYIZHmoXhgkDWTCz9AY0NW1Nyt1TmHw6okdrpD+XV2q1MG2BYWYwzQIWOabUXieo937vkMXhBwDzmLSjwfD8ha81kfrEBaHicJj/T0o9+yuO6mi/U5cu03B2P/ws+RLaZY2FPUEgPFlwrRUSUn6ytuHDJFAvjYZxEg8iEgQ6pYSIOjwkDl8VtdY08M07wFt2ZcrfeB7yZOMAqfpYIwHyB0i2h73dfPHBbKJhzLgAdHhzKzN9PxJaw2XrP6VAERINvFxZ+oz4sMZzpPIzzmUhOsSm8kfUFN91ErM8CNKYXeUIaA7jHpSf4IjqH8HQ4tx0dQPwfQ8Cog98r9CP6SA1NRGxWbm+ZwJjIldzASkf2SIgZJH5/6wl3VmDwJSP5FQnDZOZ3gEgSbGFs26KSF8XSAgek2PuFhHV6YPYU9CYaaJpnYsIFE=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19101099003|55001999006|19110799012|41001999006|25010399006|4140399003|8060799015|22091999003|24121999003|6090799003|51005399006|23021999003|5072599009|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGtldVVqWWlWbWNvQndxbEE5bmZDSldPd2cvNjBjV1dJWnJ0Y1orVkw3cW5i?=
 =?utf-8?B?b0ZNY1BLSG1KR1M0NndNTUVRMklPZHZvdmxReGJiN1ZvdVFpZkpHMVZGWHUy?=
 =?utf-8?B?MHJsckFiZExIWjNxV3VjMXNLNFZ1TlhpZlg1bG41Sks4ZnRBc2c2cE00bytV?=
 =?utf-8?B?MTFtcXY5c0MzVkhUQTFUa1FuTUl6V1E1bjdKTU11L0h5a3VCbnk4ay9OVzlV?=
 =?utf-8?B?MVg5S2Jrd3c4azhuVjRmbHYvS3VOWHZ5Z0VzYmo3TEpLbXdqOFJ3MDh2bG01?=
 =?utf-8?B?ZFovbGY4OGpQRmRSQ1JXYlVCSXl6RGxYV1pMMlNMTWhTUmxKWlVuWk9GSW15?=
 =?utf-8?B?bUR1VzZwT1VxTm5HbnN4UEREWXBhcmU4QW5NcFo1dkFVKzBxN29UWG42TGgr?=
 =?utf-8?B?TWQyR1ltb1MzMnVFNzN6M2xMTStzcnZDenlvL2ZmcngvOFdDUldCYWZUM2E1?=
 =?utf-8?B?RjZzUFIwNlozTHVlQTUxZHJIOWRjVkQ4a2EvWU1HSXY5NzZpUkpMdGY0QTlK?=
 =?utf-8?B?YUZQZVlGSURwRks3NjBNU2UyUHhzbHc4OXRIamNSOXJpb2xMU0FLdjNnem9n?=
 =?utf-8?B?TDU0RDNvZDB5TkRCS2dMQUF5NlhGdG4zL0RZVWVvYStrdDBuUmhiVWJ4RDdG?=
 =?utf-8?B?R1BxUGlDMCs5d0l3cXNON0ZBZTVTVllMdms0UGpNN1F0Rmk1T3FpN01pQVp5?=
 =?utf-8?B?R1dXTEVCRmwzb1JOZXZRQWJFK0l5MUw0Qm1qVVJKTE9hYVJodUtITE8yQVpj?=
 =?utf-8?B?MitiZC93ZnRKdzJ4bmxOd2xaNzhJUERqa2k5M0tUUldadk9SNElJVzE3MlBV?=
 =?utf-8?B?bk1jcDU2aXJISUpqbnBsemVTNTQvUVNvMWJnZ2NubE1PR0swODVNT0dleVJk?=
 =?utf-8?B?VmRRL0NHZy9vS0gxYXZ5TDdpbWRkdWlTenBVY2tmbGNWNm5tVDV1QTExTFgv?=
 =?utf-8?B?UGV3L1BLelFtbVU3UkJPaVNaZGwwVGd5dGNOZGd1VzRUNlc1TFlxRzFFc3JM?=
 =?utf-8?B?NGJwUFEzMEFCSlEwOTY4SXQzNTQxRU1YTEhEOWs4MkowRGk4MDFhUTlSVUJx?=
 =?utf-8?B?U3ZKVWZaKzBWUngrOE5YU0xSOEVwV1hKcHpsVW1qZU5qN3NxdXVyT3lHV3ov?=
 =?utf-8?B?TGZQNmN1VnE3ZTdFYm5TeGg1V3RlZk9RUlNiOStNNUhOTmhBUFQ2eTlyWmQv?=
 =?utf-8?B?WUpzYU5QSCtONlE3amdFLy9aWVFYZE5ja1dXemVTWkpmVE5RNmhlTTNGdGZt?=
 =?utf-8?B?cjRiQXdIeSsxVXJqbFNmUkR4eUJQUnpvYi9jekx6VzZUcllLSUFERFBrRk1H?=
 =?utf-8?B?bEIza09ubHRLV01IYXNpajh0cHU3S05aNUw0NDUza2Z1YUovaEhUYWpUMGRn?=
 =?utf-8?B?QkZWdHJnbjdiRTJHeDVHSjYrSlErN25LTHVYMjZYbVVBeUZsUjExK0prWmN3?=
 =?utf-8?B?TmZIdzYvR1N4SjJ5MkZiU2k3Z0NsRFljVFcvbU1BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXByWmJkd0RpQTg1VVRoeW0xOEN6RDBRWjc1bXVabm4zUVpDUXpWRnRpazd5?=
 =?utf-8?B?b0wreWpxWUVlaVM4Z3JHa2NFVHNtN3lvemQ0VDlZR3dyVXNTVGdPUDlLS1Ev?=
 =?utf-8?B?SE14MVZDMTlWeFpWbzV0TDRwbFo3L05kdXVZci9qM1FUeUdMd2dFRitzdlFi?=
 =?utf-8?B?a2Uzam5kVDYxN2NnaGtSWS9aR1RjS2dzWlFJNkFac1QyOTJwSldkVkpQUGsw?=
 =?utf-8?B?bCtFU3dBWW55cFRMaW8wNU1YNXR2S3N3VjI3ai9mYm5MMHlEUDBKWml5WnVo?=
 =?utf-8?B?OVdwandad2tIRWJhSEpicWdwZEFOc0ROVHM2ZW82WE9UWXVQbTRCR2p0NFp1?=
 =?utf-8?B?R1lhS09XNFVvWWlKaFRXZFVGUmtTR2JjTitCeFRQSnlXeitPY2NTaTJWREJq?=
 =?utf-8?B?RUpsTlVlN0U5RHk0MGQvOWtPQmV3by9lV00wUjBsa3ZsL3ZvV0N0dzlWREhB?=
 =?utf-8?B?SmJHVTBGSnk2d0VGbUNMSEtJdHdlVURJV0cwZVdEbEFiNTlxUnZ0bWVXd290?=
 =?utf-8?B?Yms4NnNTSDBYQ1BaVTZBQnlwZURVbzhPT0lwcE5hZmxadU04L3R4bHRvb2N3?=
 =?utf-8?B?NDVqRkp2YXk1LytkR0Z4cnhtMkQwTU9teUFoR0NQUWptZnZBam5JWlY3d1d6?=
 =?utf-8?B?NEU3bHhJNUhCVlByWWlQQ00welRpK255MEFVLzVzSXR2bHRIN0QxZTQ3eGk1?=
 =?utf-8?B?c1diQU9uUUdDMGp3MUkwRjNBQVBEek10czhpcm9VakZjSUNpZDNrYVBMaGF6?=
 =?utf-8?B?ZFlWQVo4OTVVOGNRV3Y3VXl6WTFWYm52eWtnRmhpRVdoN1FqNnJKWVQ3R1pF?=
 =?utf-8?B?WXl5cFEzWGZnRHZ3L3M2V1owN0cvUkpyNVN3VURkTWp5Tlh3Y3VzeGxSWjRh?=
 =?utf-8?B?c2pRSFFKNmNnbjlGdFVDaWF4NGJiQ1ZjM0NMQUloZTlIOVFPczBINWIrOHRv?=
 =?utf-8?B?WjVwaS9iaDZUOXBCYms5Z3NnU0hMaUtRSGxMOHpUYTRLNFl0TUZpRHhCSkZD?=
 =?utf-8?B?c3hNaGJ2QjhxUzE4Z1YwS05LR0w5VnlmNkRUNURnMWdXQk9RWjgxV1oxZVhB?=
 =?utf-8?B?bUtnZjZZaDVIcjArMzh6Rko2OGYzcTJIKzczVnNvbk1WNEFBSjhZNDBoOXpQ?=
 =?utf-8?B?eFFEWFBkem13cW1ySWRlM0p0U1Y2a1dxSTNuZWZhc2tpQWlSZlVxVXRHREF5?=
 =?utf-8?B?a0FaQ3JDelVwTHlNUUIxOHVNUmdQTE4veUVSakh2RktCakxweThHRHBHZFFJ?=
 =?utf-8?B?TzRVZnJ1aU55ZC9QcGVFY1pYd0lydXFOWWZ6RmNKcThpVmVyWDBORFdnSTB1?=
 =?utf-8?B?bldEKzRKRU9rbzJYc3VOUm1SMXRnVTM1dERSbm0xbGM0YzkzR1FmNjVmemJm?=
 =?utf-8?B?QXNUYjNudnJPendTbm1HTnF4Y2xzR3lKQTE1ek5WYnlVWFpQOFhVdUxJVVNz?=
 =?utf-8?B?NnVYeUdLdUxBMTgrbGlmSVZyZCtKNGM1cERkbjhXY2pzaFpTeS83MTZScTkr?=
 =?utf-8?B?MHF5dnkraU12d0xyVDdxUDh0eHl1dXFRRERPVkVTcnpMWnkzSk1DdHpPS1FM?=
 =?utf-8?B?bDYzMjhJUkd1UkxBc1JUOGMyTDYydWI4NE5hMkxwR2I3VHFvVXlxbXNzMWZ3?=
 =?utf-8?B?QkJtNXJqSUJhclJWS1R3bWNXQmZkYkVTTUU5QkVKeUtwcjFDdGJJdFFTcmZE?=
 =?utf-8?B?VzVLZlptTlJYbWdNTElmUFBlK3I5S2x0cUkrWUZtQzBXK3ZTU1NyTUVFMzNR?=
 =?utf-8?B?Qzk0cy9ma0JkS3ZJa2lxcFpCb21pZklBNjlaa0F6OVladDJmUitmajN4OHI1?=
 =?utf-8?B?VEtUZlVNWVdhaGZtbGJudkpsVW9NaHZOYVB1dUVaWFUrYW51Vm53czkwQkhS?=
 =?utf-8?Q?cqztWzAIf9Cpi?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b535f37f-4259-4362-02f7-08df33f03b44
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:04:59.5577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8307
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/26/2026 10:16 PM, Tan Chi wrote:
> KVM irqfd bypasses the PCI device's IOMMU AddressSpace, so MSI
> addresses requiring translation may fail to reach the guest IMSIC.
>
> Translate MSI addresses through the device's IOMMU AddressSpace when
> setting up KVM routes. Only direct mappings to an IMSIC MemoryRegion
> are installed in KVM routes.
>
> Other IOMMU MSI remapping forms are not converted to KVM routes and
> continue to use the existing userspace MSI delivery path.
>
> Select PCI for RISCV64 KVM builds, as QEMU currently enables the
> RISC-V KVM target only for riscv64-softmmu builds and the MSI route
> fixup requires PCI support. Also trace translation failures to help
> diagnose route setup failures.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>
> The AddressSpace translation follows the existing
> kvm_arch_fixup_msi_route() implementation on ARM.
>
> Changes in v2:
> - Select PCI for RISCV64 KVM builds.
> - Add trace events for MSI translation failures.
>
>   target/riscv/Kconfig       |  2 ++
>   target/riscv/kvm/kvm-cpu.c | 54 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/trace-events  |  4 +++
>   3 files changed, 60 insertions(+)
>
> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
> index 11bc09b414..0cf2c8e1c4 100644
> --- a/target/riscv/Kconfig
> +++ b/target/riscv/Kconfig
> @@ -7,3 +7,5 @@ config RISCV64
>       bool
>       select ARM_COMPATIBLE_SEMIHOSTING if TCG
>       select DEVICE_TREE # needed by boot.c
> +    # kvm_arch_fixup_msi_route() needs to access PCIDevice
> +    select PCI if KVM
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 45ad5e1525..7c3d3c8c69 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1507,6 +1507,60 @@ int kvm_arch_release_virq_post(int virq)
>   int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                                uint64_t address, uint32_t data, PCIDevice *dev)
>   {
> +    AddressSpace *as;
> +    hwaddr xlat, len = sizeof(uint32_t), translated;
Seems unnecessary to initialize 'len'.

Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> +    MemoryRegionSection section;
> +    MemoryRegion *mr;
> +    Object *owner;
> +
> +    if (!dev) {
> +        return 0;
> +    }
> +
> +    as = pci_device_iommu_address_space(dev);
> +    if (as == &address_space_memory) {
> +        return 0;
> +    }
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    mr = address_space_translate(as, address, &xlat, &len, true,
> +                                 MEMTXATTRS_UNSPECIFIED);
> +
> +    if (!mr) {
> +        trace_kvm_riscv_fixup_msi_route_failed(address,
> +                                               "address translation failed",
> +                                               "none");
> +        return 1;
> +    }
> +
> +    /*
> +     * Only direct IMSIC writes can be represented by a KVM MSI route.
> +     * MSI page-table translations instead target the RISC-V IOMMU trap
> +     * region, which requires further BASIC/MRIF processing.
> +     */
> +    owner = memory_region_owner(mr);
> +    if (!owner || !object_dynamic_cast(owner, TYPE_RISCV_IMSIC)) {
> +        trace_kvm_riscv_fixup_msi_route_failed(address,
> +                                               "non-IMSIC target",
> +                                               memory_region_name(mr));
> +        return 1;
> +    }
> +
> +    section = memory_region_find(mr, xlat, 1);
> +    if (!section.mr) {
> +        trace_kvm_riscv_fixup_msi_route_failed(address,
> +                                               "memory region lookup failed",
> +                                               memory_region_name(mr));
> +        return 1;
> +    }
> +
> +    translated = section.offset_within_address_space;
> +    memory_region_unref(section.mr);
> +
> +    route->u.msi.address_lo = translated;
> +    route->u.msi.address_hi = translated >> 32;
> +    trace_kvm_riscv_fixup_msi_route_translated(address, translated);
>       return 0;
>   }
>   
> diff --git a/target/riscv/trace-events b/target/riscv/trace-events
> index 93837f82a1..50980c031d 100644
> --- a/target/riscv/trace-events
> +++ b/target/riscv/trace-events
> @@ -12,3 +12,7 @@ mseccfg_csr_write(uint64_t mhartid, uint64_t val) "hart %" PRIu64 ": write msecc
>   
>   # op_helper.c
>   riscv_exception(uint32_t exception, const char *desc, uint64_t epc) "%u (%s) on epc 0x%"PRIx64""
> +
> +# kvm-cpu.c
> +kvm_riscv_fixup_msi_route_translated(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
> +kvm_riscv_fixup_msi_route_failed(uint64_t iova, const char *reason, const char *region) "MSI iova = 0x%"PRIx64" failed: %s (region=%s)"

