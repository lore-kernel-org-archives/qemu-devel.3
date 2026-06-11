Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E7DCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaUK-0003bw-Hy; Thu, 11 Jun 2026 04:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXaUD-0003Zk-6C; Thu, 11 Jun 2026 04:10:02 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXaUB-0002Et-8y; Thu, 11 Jun 2026 04:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuESj8VzJBawWlMqweldGNfcDFsj/nFQY7wuSxQk9/FCXi3kkkuLQWFIekvjiixrnhUIGNhZXCTT+nWInTcx5IEV6uOtco/eTW2P1CL1Skm9rnldod+AMFOEDpK4BZice1AWmT53mzmH7+LEmLKs6hQ2jBRnSDentG5BAjQKax8c2QbdUhwZEWexNVa5YyYb5Y24bfdzYX6mOo8Kg4LML7hpDrp8JtVjv2bPfhf91stSMdOMDu2fdJt/MqUr1zPy5HP4krNMeftEXRdf2XrTCYrp7kJkCx+n4tZqm1HFDM2HwOmWEqv8rNdMTAVL4Af0dWrepT31A74FtUSsuN9zgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cExQ03y6RxF0cTVDagosfrKVJBWoInGTJibKNaPbhjU=;
 b=uNrzsz7WZMoBkSaXr9bcLUf6LUbuTLL860zZijabFeXHO+MJmpbfcdRKKly1ECnDC4x1EeC6nfLVn9F+qMj3sYemh2VeKVGBlz2CZgDiUQLUxs8cfvgpcr6VlyL75xX6dXmWr/3YFA4oxUMkH3yuMO5z3XZmsfGHwhhNc0UHxSRkMJm0Z/tSjz+HpzE50WhGYwQBUQaPoaKKPY+I0Hp20xl/V9APi+Uu+kcr5He4ruoJH0ibyI9aAFQlgGxWMyAHdouQwwvk+y/F6PaqSmyQo+2wkx4Zvtu5QzaOhP0T/lHaYxpESgryGoSLEL82LtISzS1qMnV4KqxqdEBMimbG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cExQ03y6RxF0cTVDagosfrKVJBWoInGTJibKNaPbhjU=;
 b=UjCiZYy75lwa8NzDC8SviTuX3i+0Cthr8c7HYB/4AbXcCF4Bq0X14uXwzKf5tssfSvMaupjKssk9bHDuDXlLrIS1cjInbImVdNUNen9whRz4rmMROh89MH1gx8mBdsR8eiv2H1z0gZIm0oRAzbWsKCj815/mbut6X+wN6qANZG69zEuCtxw9VWpQ5gIX5cDCyJxPFS44TQ1yqgJmpc1QPyMPmbYj/gNlIbR+Br+H3P8GIs/G9UHgkhLFEjoSXk6kJayd2krWMyMMHdW9/ApAPqBdYkUDpA6Y3GDu6Ab+cJHNa06qefrFrlMtHiPwvVjfZiCQJiIQ+hvzPC34hMtqPg==
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com (2603:1096:d10:46::5)
 by JH0PR04MB7294.apcprd04.prod.outlook.com (2603:1096:990:3a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 08:09:50 +0000
Received: from KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d]) by KUZPR04MB8925.apcprd04.prod.outlook.com
 ([fe80::e3dd:6f77:3be9:b71d%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 08:09:50 +0000
Message-ID: <KUZPR04MB892551C31C464EE06747970BF31B2@KUZPR04MB8925.apcprd04.prod.outlook.com>
Date: Thu, 11 Jun 2026 16:09:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] tests/functional/riscv64: add riscv-server-ref
 tests
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-5-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260610214133.1882563-5-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To KUZPR04MB8925.apcprd04.prod.outlook.com
 (2603:1096:d10:46::5)
X-Microsoft-Original-Message-ID: <e684396a-2abf-4707-bcc2-edbfb8ac50dc@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KUZPR04MB8925:EE_|JH0PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dfe76f-d776-4a68-ca27-08dec790cf02
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|19110799012|51005399006|15080799012|8060799015|5072599009|23021999003|19101099003|40105399003|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlhYYWR6dVFtVEFDOUZlWWszckh0cVU5MnBScWJUNnN1cjFNS3VzSk9IbENy?=
 =?utf-8?B?RHkwSDdwSzZpZUU2RGxXTkZXY2plYitkcWdpNkFpVExOMFFzbStjVVBjWTNp?=
 =?utf-8?B?dFRpcEw1SjhEcjZMU0d3ZDdmUnNId29SR1paUldxdlZlOVJYNXkvN2oxcUVx?=
 =?utf-8?B?alBSZTY1VU8rLysvalhRS2F2eFR4OEZtcVZEVUFFeUVXVWtPcTVRSEVxck0x?=
 =?utf-8?B?UzQ1MHFzeGxKR0FYRzJOU29IdmVURG5KVXhlNjFGc0h1aGFDaFNpSTlscktL?=
 =?utf-8?B?Y092SzdIOWQ5OTRkNUlUc1dzbHBUbzNXRFhuS0VXVDNRYTZNd1NPUkdVU3N2?=
 =?utf-8?B?Rmo5ZytJU2Yrb2Y0dG1qeDBqT0x6MDBOLzJSbjFVQ3UwbW83TEtSUjNuQmVz?=
 =?utf-8?B?OHhvRjZQb1YrNmVLYWZBbXd4eEVBSkNyUUFTbTBKVFdtdm1aS3RueWw5bUcv?=
 =?utf-8?B?WTZBKytQNjIrOUdueDh2VjlDR3cvSFNKaW9uc1k5WkQ0N1ZLOWdITTFwVTV2?=
 =?utf-8?B?a1pWMitkUEVKT0tPTHJ4VWoyV2NJcXBGZUNZTStxTkpKQTJyaGhVWU9Dd2U1?=
 =?utf-8?B?cDlhanpuZDg4NXV3ckc5c1dwNFBuanZEdkN2SUx6UWVETEd6dkQwU0liZlQ2?=
 =?utf-8?B?Q28wTEVUM2t2bjNQb1cyeFVMb3ZhTzlmMU1RSm5EbllOT3pmbDJ4L0NtOGFS?=
 =?utf-8?B?SDRjM1hlRU9MNmM3OWxaLzE2OGJiYVpXOTRONURycWV1ZmRtNWdCSGZPSXhZ?=
 =?utf-8?B?bTRmTFU0QXYwTWtQMEdjU3lxVUVrUjBrbUpRMnVKenhtZjdYS1JtNzhicHo5?=
 =?utf-8?B?SnBqZmlSU3FYbjJOM1UrSjVoY0xId1haU3ZGRHRPeXczMG5zVzVIRVlNSWQ2?=
 =?utf-8?B?NzhMSTdRbUZEdlI1UHlocW9QbzZGazR1b0RwdWhZcCtmUncycGlXQzBmeFBD?=
 =?utf-8?B?TW9HbFZQYk93SVRBR1M3cVhRVmwyYlR6OGhucksrNUV4U1NTTU5DTVZSQXQz?=
 =?utf-8?B?dVRiMmJ0eWx3VWM0eXJobUtjOWJmYnh5ZHI4UWFoZHE2dTFhcTFOWVA4QXMy?=
 =?utf-8?B?dE8vMTdZQktqQTJlajlWdHJTaitzLzZXYmRvWFdwSkJzUGE2dGdwdGMwN3VD?=
 =?utf-8?B?V00wQU5KNXVuczUzSFI3R1puaUdrQ1Jma3EwZnZVdGVKU2lFWU5Gd2N5QnRX?=
 =?utf-8?B?RU9BMW4rWUFLQnpzZ21hbmtpNU9qTmltbFRZR2V0QXNEeU10UmNYU2JyMjhj?=
 =?utf-8?B?V1RETXJJSStHNDMyWUFvbGFWb2dYK0ZkajlrUXUxT09xMG1uYUhPTVMySkY5?=
 =?utf-8?Q?gzNqesY8nqbgpvh49lfxVqWlVcaOR/wKMg?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJLdnVDVDN0cks0dGJaajllS3VvVlduaXZWL2daZjhsbWNFZWxMNUpZL0JV?=
 =?utf-8?B?K0NtUVJZbkM2Vi81YkJqTCtMc3hIZUh4bThrYjM3Nm82eENSQ3B5WWhTOWV4?=
 =?utf-8?B?bWZuL2ZpVy9tdktYLzFsb2RjTWFtRzVpejQwUkxEdzZtYkNIWFhUQ3N4U3dl?=
 =?utf-8?B?dDdEUmhiUDh1aTV0WE5xQ3hVZTBtczhzakNSMitLa0g0N1RYZUMrcy9aRVFR?=
 =?utf-8?B?bHA4RDVqTkFGWXF2RkJjRXI1RkpyN3hiWG5iM2FJYVNCd3NDcUQwWkc2OG8w?=
 =?utf-8?B?RTdLT2VYVXZ3SEVoUkIzK2Rhb2VmOFBnbXNTbFhlcURqQjducllVZngvMjVP?=
 =?utf-8?B?MnBxM1AwamJGNUQrTDdkVExFRUFQay9DU3FFQnpaUThBNFArL1BxZWZhaHlM?=
 =?utf-8?B?SjViYjNoUDRZNnVwTkxCQUpvUXRkSjdXZ3AzZ3lMRjBvYjd1djlrZFJMQ2My?=
 =?utf-8?B?cVU0UHpxZXJKTDE2OElBTGIrcm1mYU1rTURBOXYzRE1zSEhPOXhZVTFmVmhQ?=
 =?utf-8?B?YjdsQS9aZGVFVDNxQmw3Sm5paUJuVThiR2cxWTg0cTZxVkRObU9UZ0FaL2lV?=
 =?utf-8?B?eG5aVEhIZkxPOFdtOWdpV3g4L1lIWXhKaDV4Yjh6QUlLVnpMWDI5VytqUy9P?=
 =?utf-8?B?STN3dklvTHhlY1NadzdkVm9lenZKaVBOOFM0QTBxWnFEMHVZdXZ3RnJXcW5a?=
 =?utf-8?B?dWM3MEFMOGNxL1doM1NaU3l0T0lyNkZKbHl4dUE5TXdxTzhHVWhHY0N5Q0pR?=
 =?utf-8?B?QW5ocEZLNXFXZ1JxSE5kMDQ5YUYxaTljSmErNDQwbTVKWTdjc2tkODRxOHY2?=
 =?utf-8?B?aWVuY0tkb2FTT1FTQ1FrQkZ6RHhwZFFZaGEyN0hnemE4YkhJbXFSbTRrR2pz?=
 =?utf-8?B?OVhKTW11WDRydnR1a25UWkpiTE1JNkZGbG8rNFUvaVZrL0JEVVFlaDUwVGcr?=
 =?utf-8?B?M0FWczVpL2dvNUxhQWhISWNaTkZ5cndtQWtNNGdGSUlBY0w3QWx2QlRlUjdR?=
 =?utf-8?B?eEJtOWxsVmVDQVlHWVpYVWdHS3FibTRRVjZSZWZkTmVud0hCNGFzRVVmU2lN?=
 =?utf-8?B?TnlOMFZNVmpBeWVUeloyVUJaQUlqYWRYU1hpcGdpemlTR3YwOUtCbktja2Za?=
 =?utf-8?B?K2RuWkg2cnN6RHk2dTFBMG5WYTRhcnZDNW9rR2h0RUkzbGNSb1JHL3BpNVZo?=
 =?utf-8?B?MUxqWWdJWElsZUZ3RGI0Q21YOG9Da05UOXJ4S3F4TVBzSjFtdlowNFdwUHdW?=
 =?utf-8?B?SEpTVE9RU1gzU2QrL1hWTjZSam1hbXVxSWJjZE01S3hheFBzeGZtTFBadDJ1?=
 =?utf-8?B?QkF6cWVIRU9ydXVNdlpvdGtWWVdTSzRaWVVja25KLzFzeTJhSnpjZm8ySDJS?=
 =?utf-8?B?TlhlS0w1WVJ5RUh1eFV4andnTHd5ZVAxWDE4Ukxxc0lDS0VjMHZ6NmJmeHVs?=
 =?utf-8?B?UjdybFJ6d3lLdnc0Lzh3a2ZNQjliM0FqWFlnTjd6VVY0YytSZlZKQ1phTHJ3?=
 =?utf-8?B?WnlXMzdKVWJicHN0ZnU3T3U4Z3d5LzVZcGp0a1dpdnBUeldSMXlOQ0dPTSsz?=
 =?utf-8?B?Z1pnc1E3Z0J3NU1MMDhQU2VtYW5NbmZOOWErL2VuaGV0ZkloTFl4OGhYNWZz?=
 =?utf-8?B?QSt2NHA3ajNGSlFpbXFGUUdzUzlJVklEV3R4bS9qZTd3QVE3aExSa3JrWUhq?=
 =?utf-8?B?WkpLelFkUXY4QXFKY05aRG5SZkVINDJjc29NOTRBS1VwZDZJd2lOTlpORmsr?=
 =?utf-8?B?M1krSjFaY1lXTFlDeGhpVXA0SWtOaFBqUWx4azZ2SHZFK1JZRWphVGhQdHhz?=
 =?utf-8?B?YTNFUzZrQ0gxOFgwL1pGam0vRm9iditVV014M1RVUEhZVDVqaGZTSlBjM0Yy?=
 =?utf-8?Q?zgO84sOhhNCl2?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dfe76f-d776-4a68-ca27-08dec790cf02
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB8925.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:09:50.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7294
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 6/11/2026 5:41 AM, Daniel Henrique Barboza wrote:
> Add two tests for the recently added riscv-server-ref machine:
>
> - a new test_opensbi.py test.  The idea is to have a quick test that can
> catch trivial regressions that would prevent OpenSBI to finish;
> - a new Linux boot "thorough" test that will boot the machine up to the
> buildroot prompt.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   tests/functional/riscv64/meson.build        |  2 +
>   tests/functional/riscv64/test_opensbi.py    |  4 ++
>   tests/functional/riscv64/test_server_ref.py | 59 +++++++++++++++++++++
>   3 files changed, 65 insertions(+)
>   create mode 100755 tests/functional/riscv64/test_server_ref.py
>
> diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
> index 5871211e89..2eb12586bf 100644
> --- a/tests/functional/riscv64/meson.build
> +++ b/tests/functional/riscv64/meson.build
> @@ -2,6 +2,7 @@
>   
>   test_riscv64_timeouts = {
>     'boston' : 120,
> +  'server_ref' : 120,
>     'tuxrun' : 120,
>   }
>   
> @@ -13,6 +14,7 @@ tests_riscv64_system_quick = [
>   tests_riscv64_system_thorough = [
>     'endianness',
>     'boston',
> +  'server_ref',
>     'sifive_u',
>     'tuxrun',
>   ]
> diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
> index d077e40f42..057f55f90b 100755
> --- a/tests/functional/riscv64/test_opensbi.py
> +++ b/tests/functional/riscv64/test_opensbi.py
> @@ -32,5 +32,9 @@ def test_riscv_virt(self):
>           self.set_machine('virt')
>           self.boot_opensbi()
>   
> +    def test_riscv_server_ref(self):
> +        self.set_machine('riscv-server-ref')
> +        self.boot_opensbi()
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()
> diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
> new file mode 100755
> index 0000000000..2ecfcf60ad
> --- /dev/null
> +++ b/tests/functional/riscv64/test_server_ref.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +"""
> +riscv-server-ref board test
> +"""
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +class RiscvServerRefTest(QemuSystemTest):
> +    """
> +    Test the riscv-server-ref board
> +    """
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/Image'),
> +        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a36')
> +
> +    ASSET_ROOTFS = Asset(
> +        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
> +         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
> +        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
> +
> +    def test_boot_linux_test(self):
> +        self.set_machine('riscv-server-ref')
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        rootfs_path = self.ASSET_ROOTFS.fetch()
> +
> +        self.vm.add_args('-kernel', kernel_path)
> +        self.vm.add_args('-append', 'rw rootwait root=/dev/sda')
> +        self.vm.add_args('-drive',
> +            f'file={rootfs_path},format=raw,id=hd0,snapshot=on,if=none')
> +        self.vm.add_args('-device', 'ahci,id=ahci')
> +        self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci.0')
> +
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        # Wait for OpenSBI
> +        wait_for_console_pattern(self, 'OpenSBI')
> +
> +        # Wait for Linux kernel boot
> +        wait_for_console_pattern(self, 'Linux version')
> +        wait_for_console_pattern(self, 'Machine model: qemu,riscv-server-ref')
> +
> +        # Test e1000e network card functionality
> +        wait_for_console_pattern(self, 'e1000e')
> +        wait_for_console_pattern(self, 'Network Connection')
> +
> +        # Wait for boot to complete - system reaches login prompt
> +        wait_for_console_pattern(self, 'Run /sbin/init as init process')
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

