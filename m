Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017A606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=DcmuCaXd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOToZ-0006Pw-NS; Wed, 04 Nov 2026 00:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xOToX-0006PP-Io; Wed, 04 Nov 2026 00:45:37 -0500
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xOToV-0005gq-Lc; Wed, 04 Nov 2026 00:45:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR0iRy0poos6hvNCZOuFTdMSA7vwfwvSxXIgCZxg6Lmgqnw/w9jwTPIPck4KqA2foJL3naN7CgDnZ3u55vkDGu1pAzUKrPrE8644B85VgEnYASvTkXpkBXyUjHQK2NYI75Hnz+PFuBTcz8kgpqcpNHseMfBUhy526C9R3jQyjenWhz/iNj7SJ7yIN1q2sYt/D0mwlHN2KHRIda5F/kViNIT2f/ampNbVEpmUscdJ4FmBzdziIT7WWseyWYT/YwfCAeHXUe9ZJQPpny7sOGdGX6ctzHZUgXd8MCpdC9Awhn//WtwkTbO8/GNR+4DnGldQBgkFSpOZ8IisdLKJhX/4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLeUHI4/s4z1sbjn8xE0lsBgs3IpcH+tkKEftPOTsaY=;
 b=hf7rqJelq44wCExeO6krlLCXae4hQNHz0VdtGsbgfpy6spgAdGZwCQvSjzK+2WoDdjD5cjwGwaZuehSshUFEcdbeEW7KYapfywZmdML+9BqHtOQqTZIlLTTjr9GPmBYoBiQeekEEe/EBHV4vztkf1d24CG4MSN95m87emsDHc4egEoLZX6DYEYYYomjAD5MF3OtONWRy649rIs4f2/tsMlXzRbZeOvTDISn+Wqee1XnzlMBw+Cbori3BGrGG9CwGEcHyp1ui2E56SM+r7as2C/taEGjvh1smJSdNW8rvWBimgUhsqiVqhDJxGye/NNVLGChKM4TgJCKKqWBH9pNEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLeUHI4/s4z1sbjn8xE0lsBgs3IpcH+tkKEftPOTsaY=;
 b=DcmuCaXdamElYxKCGcWCpcSJwc6XDGsScsrVyml9d6AI0GrfwkkIiFBPixOrjWlHWd5SnqaWpV+uEyMuNiZRHJVgO3o/bmnyos9X8aoLH4s9tEVutOby75rcFuNYqyM7eZ6CvHja+4dK52lsgzUAOlsA6irm9BYQlXOwAu5l2gGr04LcW0AWeRPJDg7zkPLH0qWNtmQbR5qPE2k+PKmrEfxbvZV+5+MhPTQXtD1p5/VJgrOl5hws5jkja82CdTa9hdue8DO/eMUoonhTLEW8wfr92nSVktqQlF3lGPBPhoSmhRjJTWnjdybDm/sI6+sv32pKGcjncrEDE1ZBZiLxpQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by TYZPR04MB7978.apcprd04.prod.outlook.com (2603:1096:405:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 05:45:26 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:45:26 +0000
Message-ID: <TYZPR04MB749179EAF4726FD05B175320F3682@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Wed, 4 Nov 2026 13:45:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/riscv: Pass socket topology to KVM AIA
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261101031547.125591-5-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY6P301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <0419100a-8d9e-4964-b460-15328cde7f62@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|TYZPR04MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: f2234fc6-8413-4265-ca90-08df3a36d371
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|41001999006|24121999003|51005399006|23021999003|5072599009|22091999003|19101099003|4140399003|8060799015|19110799012|55001999006|25010399006|19061999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzF6WkVwZm15azhlVTNhQXlCUUdaYVBvUEJNd25Na0VjNHpDNlAwc3FKd1Qz?=
 =?utf-8?B?NFhBbm9XQ2RpQjJUcDhWaWZEamx2UEw4NE9NYzZtalVpMUlwSnVBNmc4Yjh5?=
 =?utf-8?B?bEtIb3lmQkdXSXhJTVBhNkh0REQxVE1CUVNOVDRkVHlUNkdmZjcvL0FCMEVw?=
 =?utf-8?B?L3cyM3RwMDBhblpXVGNaQVJWdVpxZE44d1dWdHdMaDlyRkFyUHlIZklmVnQ0?=
 =?utf-8?B?TDN5VEJWYXJLS3pkYVVkNEl4K1lHWmd4ZFA3OHV0WkxpTmVreFVlQ21XUWIx?=
 =?utf-8?B?dEdEU3hRNElmVVBIc25HS28vczJlVUhNL1hNOGtSR2k3RzAvWkp3ZmMydXI1?=
 =?utf-8?B?YVR5d0Jzb1BqU1N5d0o1UnRzaHl0a3lPS09lU29Nd3NKaDg3MFNsTEhiSXJr?=
 =?utf-8?B?OFpBRWNHOXBKczg0bzd1WGxkRHhUTmlmb0Ywak5KRFY4UHZBN3NRZHVGY1VQ?=
 =?utf-8?B?L1k4cTJjT3VBenVScnY2Y2tXRklDcGVtSGU0aE5YaEJQZEIrU1dqYWMxbnF3?=
 =?utf-8?B?OHN0YzZpRytnSUVJYUI2eDhBcjVFUG9KYStOcVNZOVd3OWRxZmQ5ZnppL0Rt?=
 =?utf-8?B?ZnpCN3RNWldvUkdGN0VhVHQybSszNXVDUDkzeUhSSWVROGc1KzZHeFAwVyta?=
 =?utf-8?B?ejZmd2l5KzF5TUdyRFhnb3JJK2g4M0tRb2lKMXFhOVpvWlVXU0ZyVFFlVHRy?=
 =?utf-8?B?UGhtcXRhcU5EdzZ1M0VxaHRrSHRZV3dubGVVUWhTbitQMUg3WTFCQ1F0c2ZI?=
 =?utf-8?B?UDRzOFJYaElGc1dvM2h3V0hpTVZrWE01a3NwdSs4NEF6TWxxTStKTXM2RVdk?=
 =?utf-8?B?WlpGUmg5RkpUREdXc3k0c2ZOcG1PUmNabE1OVDNuVENvVjlacW8wWHowR0tl?=
 =?utf-8?B?VnVodStVSGtra3gweU9uckNlV3VkTFM5dnkxdWpESmIyVC9xVHJIVkRZa2dM?=
 =?utf-8?B?OHk0R1Jwb1ViTStBTXQ4VnZGWWVoQnRHQUY4eU5qTzJvTFMvRDhIRHRjOWM0?=
 =?utf-8?B?Mm9iNEV6TXIxdlhMSHZTZVJBU010MnphdmlqOW9TSWF1TXFYKzVoOFJMN2dE?=
 =?utf-8?B?d3BzeUI4dHBzSDk3VVVvUjhQandwTWw3TG5pa2UzUllVOHJJd29QVHRwUE5v?=
 =?utf-8?B?VURnU3ZlQmc5Q09Vd0p5UGdsRUFyWFZzdGxhdXcvUzhGUGNSSmR2bjdJUExH?=
 =?utf-8?B?dDZRekliM21McitITEZiV1F1anhqREk5ZmdQYVA2cm9KVGFUUEFvQzBKRUZR?=
 =?utf-8?B?WGhnSVJyQTNrOG9vQXArRzJZRnBBcDFwbTh4eTRlcDhZZlpYOE41TVdjemRU?=
 =?utf-8?B?VWl6dlF6cFBkbkxxcXd0dG9rQ2EybzY0Kzc5OFA1VWozcXptNUN2cCtTc1V0?=
 =?utf-8?B?UUN3YWQ0eDNTSGNXU2hWODgveUhrM0lxcyt3dGtVTlBhVmo3Z2E3a3crYjQ4?=
 =?utf-8?B?Sjc2T0NUS0hLbjdtYVdjbTc3ZStvNUlTVHBVTmFoVVFKK1VxOEowVUJEZkNT?=
 =?utf-8?Q?/dQ/4598U5M4GZrhonvYGion/uQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVGZ05zOUFGSE9DakRFaGVPRnVwTTZ6SFoxNVBLcmgwbi9KUVZmYkZ2eDcr?=
 =?utf-8?B?cUZrMXQreVo1Qkk0d3lKMUV1QXVzcjE1aDc3V3hZY3laSTNya2huS3F6bTVI?=
 =?utf-8?B?Mks4eExVWVBoaG9JT20xOUdFbDFNZmxqdjNiRXNkbXp6ajRWSGg0QmpMb3A1?=
 =?utf-8?B?ZUhPdFl0TGVLTDJVaEhNR2NrNEo1eFVtZVkvejNQZXhWM3pScittNFhXMmNt?=
 =?utf-8?B?ZW5LZUNYSjN2WkhwNTYzclNRWFNqb2g1QmVvNEtlVHB0eFNxaEZ6Y2lNeU9Y?=
 =?utf-8?B?REZtWU9XUjhIVWYrT0Y1SzBWV3ovWUwzeDN0T3l3QWpZai9LeDdka3hpQmtp?=
 =?utf-8?B?SDAvS1phYVl1MDdYSU1JZW41eFNmZ3lkMVdRVmZnTmozOThWTXFtMHIzZHdU?=
 =?utf-8?B?RTE2SnREOE5UcjFIVzd5V2ozVjFCTHF4M0FIb1Q3djRYQ3RtUDZtYlhIbTF6?=
 =?utf-8?B?Tld6QVVhNWJBYVJ4RWZCZXJnZmFwOG9uNWVwRFJQc1N0UFVXendFNzJ3ODAy?=
 =?utf-8?B?ZTB1aU5hWU16d3RxYnpCMnV6L1Uzb0N6UUZmWEFVN3VPTGJVOEdqOFQvdzMz?=
 =?utf-8?B?ZkNTMktQUGVNbE1qajBoMzkzc2cyQlhzTEdFL015VnlOcksxL3V2WUo2TUVC?=
 =?utf-8?B?U1JDMjVVNHpiTnhvTnBtcEQ5WmZadHpVUkp0ejBBWmNQN3V3WUtpN1l0MjBW?=
 =?utf-8?B?Ni9CRTl0a0k0aHJaVFJjK01lMks0WWlKODhWRlVnZVJrbWpVVGd3YURWaTcy?=
 =?utf-8?B?bUdsbEQxTHAwWE1KVVZyL3VDc1g3ZmlacTkwcU52Rk16eFVKcVh3MFcvS0xo?=
 =?utf-8?B?bjVhMk5GaGhGU2toTm4way91VC9vTzc2VmZ1b2krUzFESURVRjB4Qk1icVVu?=
 =?utf-8?B?N3lTSmxRRzVNMElJaW1HOTZEVWJQMFhBbDJ6UjBzeHNwSmUzMU8yK29IdWZ4?=
 =?utf-8?B?eDRZV0pjKzF0UTg3UW5QcmtHSmxaRnBZQTJvd3ZmeG9yVmxVQ3dmR1N0WjA2?=
 =?utf-8?B?YkNNZXNDQzNIcmk0UThjOU1jQnllNURIelk1Ui9TanlzRVgwN1draUFKd0t5?=
 =?utf-8?B?ZTBvWGw4T1EvRE5XTWZUc0ROclNFNWtPSUtrcTRCS2FDWnhoc2wvRk5JeWJj?=
 =?utf-8?B?bHBnOWZiSWZBbTFGQVVDSDhPd2Nxcy9rVjdnMlI4WHBydkhsQ3V0M2xKeExn?=
 =?utf-8?B?SG1wQlpsL0NoelBISDlqK2IzUGM3c0tIY1FyZ2M2cHRzZ2llSjNPM0FBQXRH?=
 =?utf-8?B?VTNEUzRUUUdoR0pQeXNyNDVieXFMNk1sOXlXVUtTc0xleTdRemlRdEtidjJU?=
 =?utf-8?B?QWNVbXN1YWlHdE9rVWZNV0Z0NVJZanptdnhIOUlnNU9heUhEeWdoYWR5SXdR?=
 =?utf-8?B?Wk9sVmFSaS9HZ2Fsc1Z5Um5HNWV3L3Z2WGpEMXpVRkxiUjlicXZybzA3bnlB?=
 =?utf-8?B?elBTeU5ESEZqS2RQVjlQVXNEcTcrcVNkRkFPUk1oNnhVYy9BM3dxWnNFSDVp?=
 =?utf-8?B?ZmlPSmZubE14cHlUTmVKM05oMUt2dHp4TysxajI4SVkxbktvQU9PamhURFBT?=
 =?utf-8?B?WlVBU1JJdm9xeUc0dm9LZlAxcnYvek9ERGpxTEZCbGRrQzdoY0dZTUFEd1Jo?=
 =?utf-8?B?akJLQWxRUENQU05lR3J6ZXZ4TGxNTSs0SWxTRjBIbittWDBYd1lBeTFGbytD?=
 =?utf-8?B?aUZIVTg1amdLSnlFTnJ1QXJoeGoxY3Z2WXJGYUMxQmNCYjNIcnk2Sm9DK0pO?=
 =?utf-8?B?bHhkV0h3TURMSFdpczluWHdFcVBpazVJNFdIRnFvY09ycFUyNnVodGRBcXVV?=
 =?utf-8?B?cHkxQzZ1UEZ4TGFyM3ljSWtqcVdGaGljN3d5THlscmVvZUNIazVBREo1Q053?=
 =?utf-8?Q?ZrvEl5AoHoQYe?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f2234fc6-8413-4265-ca90-08df3a36d371
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 05:45:26.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7978
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/1/2026 11:15 AM, Tan Chi wrote:
> KVM AIA initialization uses the RISC-V NUMA helpers to query
> the socket count and per-socket hart topology.
>
> However, KVM support can be enabled without CONFIG_RISCV_NUMA.
> In this configuration, kvm-cpu.c is built while numa.c is not,
> resulting in undefined references to riscv_socket_count(),
> riscv_socket_hart_count() and riscv_socket_first_hartid().
>
> The virt machine already determines the hart topology when
> initializing its hart arrays. Pass the socket topology directly
> to KVM AIA instead of querying the NUMA helpers again.
>
> This removes the build-time dependency on CONFIG_RISCV_NUMA
> without changing the IMSIC address configuration.
>
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/aia.h               |  5 +++++
>   hw/riscv/virt.c              | 10 +++++++++-
>   target/riscv/kvm/kvm-cpu.c   | 10 +++++-----
>   target/riscv/kvm/kvm-stub.c  |  3 ++-
>   target/riscv/kvm/kvm_riscv.h |  5 ++++-
>   5 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index e4dcc5aae0..ed9b613f3c 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -12,6 +12,11 @@
>   #include "exec/hwaddr.h"
>   #include "qemu/bitops.h"
>   
> +typedef struct RISCVAIASocket {
> +    uint32_t hartid_base;
> +    uint32_t num_harts;
> +} RISCVAIASocket;
> +
>   static inline uint32_t imsic_num_bits(uint32_t count)
>   {
>       uint32_t ret = 0;
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 7ec7596b24..f1b1353647 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -853,7 +853,15 @@ static void virt_machine_init(MachineState *machine)
>       }
>   
>       if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> +        g_autofree RISCVAIASocket *aia_sockets =
> +                g_new(RISCVAIASocket, socket_count);
> +        for (i = 0; i < socket_count; i++) {
> +            aia_sockets[i].hartid_base = s->soc[i].hartid_base;
> +            aia_sockets[i].num_harts = s->soc[i].num_harts;
> +        }
> +
> +        kvm_riscv_aia_create(aia_sockets, socket_count,
> +                             IMSIC_MMIO_GROUP_MIN_SHIFT,
>                                VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
>                                s->memmap[VIRT_APLIC_S].base,
>                                s->memmap[VIRT_IMSIC_S].base,
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 45ad5e1525..1a74b9a37e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -46,7 +46,7 @@
>   #include "sbi_ecall_interface.h"
>   #include "chardev/char-fe.h"
>   #include "system/runstate.h"
> -#include "hw/riscv/numa.h"
> +#include "hw/riscv/aia.h"
>   
>   #define PR_RISCV_V_SET_CONTROL            69
>   #define PR_RISCV_V_VSTATE_CTRL_ON          2
> @@ -1897,7 +1897,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
>                                       "auto");
>   }
>   
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> +void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
> +                          uint32_t socket_count, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num)
> @@ -1905,7 +1906,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>       int ret, i;
>       int aia_fd = -1;
>       uint64_t default_aia_mode;
> -    uint64_t socket_count = riscv_socket_count(machine);
>       uint64_t max_hart_per_socket = 0;
>       uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_addr;
>       uint64_t socket_bits, hart_bits, guest_bits;
> @@ -2006,8 +2006,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>   
>       for (socket = 0; socket < socket_count; socket++) {
>           socket_imsic_base = imsic_base + socket * (1U << group_shift);
> -        hart_count = riscv_socket_hart_count(machine, socket);
> -        base_hart = riscv_socket_first_hartid(machine, socket);
> +        hart_count = sockets[socket].num_harts;
> +        base_hart = sockets[socket].hartid_base;
>   
>           if (max_hart_per_socket < hart_count) {
>               max_hart_per_socket = hart_count;
> diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
> index 64e39c96d8..f929161628 100644
> --- a/target/riscv/kvm/kvm-stub.c
> +++ b/target/riscv/kvm/kvm-stub.c
> @@ -9,7 +9,8 @@
>   #include "qemu/osdep.h"
>   #include "target/riscv/kvm/kvm_riscv.h"
>   
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> +void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
> +                          uint32_t socket_count, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num)
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index aef681f0a2..bad78e28f4 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -21,6 +21,8 @@
>   
>   #include "target/riscv/cpu-qom.h"
>   
> +typedef struct RISCVAIASocket RISCVAIASocket;
> +
>   void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>   /**
>    * kvm_riscv_set_irq:
> @@ -29,7 +31,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>    * @level: %0 to clear the interrupt, non-zero to set it.
>    */
>   void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> +void kvm_riscv_aia_create(const RISCVAIASocket *sockets,
> +                          uint32_t socket_count, uint64_t group_shift,
>                             uint64_t aia_irq_num, uint64_t aia_msi_num,
>                             uint64_t aplic_base, uint64_t imsic_base,
>                             uint64_t guest_num);

