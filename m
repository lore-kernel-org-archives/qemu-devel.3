Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F9C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk38V-00027Z-ES; Wed, 15 Jul 2026 13:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wk38R-000277-Vk
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:11:04 -0400
Received: from mail-francecentralazon11023117.outbound.protection.outlook.com
 ([40.107.162.117] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harry.vanhaaren@openchip.com>)
 id 1wk38Q-0007ny-8M
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG/yatcgEBzpsmOow1HOfUuD6h3RFXSdhy5aw16BgbFvLGts8UU80VCbHt4MCLW0vw5S7YlwsL0AF8d9vPKVCzWwcyb0WqEUQiWnfy/Ud32yE2oP8K1Cz1Gop+EscVg5oX5Jbj3Q2iuQOSkjmvbN6PtXDUG6sYNNqmHGLHEeTTqBAIg4dgH4OOABET4mkEoGuK2Bifr9M5f9IZt+5IyewYFGxSwKU08i8B/yvPiD/JXZob8zpKAovy15yBsaSxnrXMzXjc+FxWjsBwJOt8cD1vsKW5xM6xPBz/hQi+kT+AMT6CUIz8g+V0VWMbcICAvnJYiZ527L4D73shYAGnDcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyIQ+Yn15uvHlCyDmDhFJv4V86CZxl4m+hcaxBP8YDQ=;
 b=JRkexy4M+9TamF3QiXO/rU5qSJJ3QKUZvS62I4LTnRcoAllgr9YC6wTudTopjv8qNL0QhBqxZ2Q0bbAD8SW+4x3+TzCtzeTwBdPwqMm+/s0XDgnZNgU7JQRSXO1X9Hf1BL20/8+XUlbfJC3rvnFI+BZgayTaTA2GdH5QYg8+v18qAAIX6kM5o4CRsPkCIRqpUq3NqOZ92offNZvy9vCtnJ04IlwJzave1k9hDQmj9yGZL+YAq9JLGra43Sf8jdoCwSIGXtTFClFU1b30jhwSiRbj7O1+cSZZATD2mdMxvZJ4Gfs5dXgjdbyXQ8roKXnvr2dBBCfIDzGIUUCsISkG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openchip.com; dmarc=pass action=none header.from=openchip.com;
 dkim=pass header.d=openchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyIQ+Yn15uvHlCyDmDhFJv4V86CZxl4m+hcaxBP8YDQ=;
 b=Ta9kMXQ0q1JhizvuLldPNTX4q+PfZEbOge6pwiyDVwEIk9rxUoJqp7kXDBR8t3U6Hf1nuzX3ZI9vBH63cu1d8wgIVFHUoAlA9f1bnNWkZR5zqfNWoFJTHJL3vARwT3Pcvzn1uvrar5S4p80X0/BKhNTtVH05GO/B7F+GOHWuSPMvQT3YTRZVognYSbsF0nZM7s6VC6w2BCSJ2xCn3shXlVotK+11RrMqkV8Cmaxh0T8D9tEG1s8VhjrVoCtjNxtsDF+Kx4IF0IyLhJDFCC28KC0qAW2kF5tkZqY1rXud7K//ONySMQTpuCcP1n5r59M/rE3H59nlYUWxOUVuZH33rg==
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:328::6)
 by GVXP192MB2404.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 17:05:54 +0000
Received: from GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64]) by GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
 ([fe80::7ed0:3600:9df4:af64%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 17:05:53 +0000
From: Harry van Haaren <harry.vanhaaren@openchip.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>
Subject: Re: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution
 print loss
Thread-Topic: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution
 print loss
Thread-Index: AQHc/asBdz5UenWH/EGtxKxaHNookbZBg+iAgC10NVI=
Date: Wed, 15 Jul 2026 17:05:52 +0000
Message-ID: <GV2P192MB3464B1F78D8F38D1574A8D9185F82@GV2P192MB3464.EURP192.PROD.OUTLOOK.COM>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260616161242.267315-2-harry.vanhaaren@openchip.com>
 <e7edbf3f-55e1-42a4-8101-0a1c273c7587@oss.qualcomm.com>
In-Reply-To: <e7edbf3f-55e1-42a4-8101-0a1c273c7587@oss.qualcomm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=openchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P192MB3464:EE_|GVXP192MB2404:EE_
x-ms-office365-filtering-correlation-id: 0e7ab0b6-3a4f-41ea-9ebb-08dee29353e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|38070700021|4143699003|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: gLeZ7k0DV5R4HGtTqG+BPZ61Yat974xnYA/y+Vo2ZVYhrfxIcBKQC9sKQv+L8EazDtCS+f2dXdcfVJy460gBw2TByqUWVoQXvK6hoAYWgMONXk5+2bSDNg1/RNhVb8ItclqFC0CitlRCLXqgp76fgiFWN4jJ8ACQoEwjceFtzwypVZ9gx918rpodp7xLwlK127gnnXorVOroDFx/mvPp6FIJVn7LmR11gp+k0Khf1IkQL09T1fBg4V1YxMy1SBBqoBUG19h9kOngHXIJiAGnLVQcbQ6j6GtwrOO6Wj2ccY9O9emFXp5G7aUHyw239Jp1W/3sE91VFLSlwBgbOp52VKhvuo5f09QE6DpgfD+Tu8CfiFPuveptN4E59+XImkZldgYv56h9O5Db2qSrEpUQLcUCnxB5WGzI8jegSTvUFGaIgnlOTAD2zF/M7vs4RquTuLzKUxUarfAG8QogO0W+qQtBZ+HMI4DLPHFF6bO1vaL/w46nlzcNTmENj/bkxJuiz8YnKhcG/GWuISfAJDIGx0BHCUCECN3s6Zb2oipuefWBDEc3tlahkFy6OPqcb4F9zhje4hN1WYCCQc/UHFcze0yH0BqXl4g7wpGkAQgUb3Zsaeg6cO3AQFHkjmikXTXLg1KCIGMxrXEqKL9+9jwDDQUpJ2pRCSjMOuaFjnMYXq1+9nSWF6hRJqAuasZFpI+7b/qyWOvumOawbJ0YU6OGR0ZmXKRqaxWVWVNiJ/6Kj1E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P192MB3464.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(38070700021)(4143699003)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1gKdpMOrgCrItJzx4dWsEwxw7yC1EP3FTpa2zpR+C7M+76HQYnhO4nWD2e?=
 =?iso-8859-1?Q?msY2qYfbjhWJq5FWGLRUsbXsjvlzHRG+y4Ry8pUqGKAyL2X/b+MeQGewBJ?=
 =?iso-8859-1?Q?MUMELMLm9PdV9eyYvUQFpezc2g6g8UDxR9XqyI5CpOCfpM0D+7He7l1tkj?=
 =?iso-8859-1?Q?CwPYFzQRPEviIPT7EbzCKjBrmyycrXusul3C55IESkSuwzxK0oV4iIMsmk?=
 =?iso-8859-1?Q?drAi9LaBSZ12CYFPOYki4nFo36PyAWV/ow2R+aTr8PUlV+OUxj3P96hQcQ?=
 =?iso-8859-1?Q?a+2AzmeA0NfXnvvxGZOd3/vw1m8PcuRrZ5ByMlwYUwTdOBstxDxBv45Fqb?=
 =?iso-8859-1?Q?yzzJma6ULYj2Y2D6+icrLsg7AI+vmNdN2IqjVaUnBCb13o2U3FBFSgbK8j?=
 =?iso-8859-1?Q?qZ8l49wqeGp0p1P8ZUs4Z0cRxVN9vLWNduvAkDf8EeaNwGl8UYYnUDG2yd?=
 =?iso-8859-1?Q?tumHIlFdBr2ftNo2Ve9EjY/1oXStT9fBB2+qJzpzgPDTOvaW6UfaJX80GD?=
 =?iso-8859-1?Q?SDlrBQ7NuR5H0UmZwg3sfVXVWxJDPiGv37d632rl3JBpDoLaF18d0GZOQm?=
 =?iso-8859-1?Q?567wODrmITunxsRrV2wU4z0rie16Fef75ucs1Aexi1V8aWVIohWJ+oeNqG?=
 =?iso-8859-1?Q?xd9+I1NVSzd7LhtnPhqyTeFxMjf0SG5yEoyQYQHmAFhyjUe14rohzb5slT?=
 =?iso-8859-1?Q?wAee5aAdKF3s7pvCS/rqMYb+fF4ZMalLz3vGXddtYGOiI8C9eFiaV7TGoP?=
 =?iso-8859-1?Q?SqZc+gcX3gAKYkrvOTlSVaztrqeViHfBIRdYF0ukbQKb0H020gsxPdU9EZ?=
 =?iso-8859-1?Q?/q4YpsOH2Koug6K1c01nCG/I4cj3YKHm48sU6dvZabGIMaoEGQwD6YwuW+?=
 =?iso-8859-1?Q?N6lVUuyuNiXmpjn4iq4aZ4eRCrlQYBvDrU3Fs+6OSQwLwiGFj/zz2jpeIt?=
 =?iso-8859-1?Q?XFzssGwt65rqbIFuJ+pjGVS7trfS9oSP1P3ZxldaXkoo1RCdlHJReJzABl?=
 =?iso-8859-1?Q?J1cmpzJUukKwhxPwnNxjB+3TpSWgTTUmYHWOPh3jbXLurVNWgmHtQDKhef?=
 =?iso-8859-1?Q?b9Lbpm1T5NB+4v1DVOtt36hI9NtFI5Y+eklzRT3gGnmz7Qk85E7Pedghou?=
 =?iso-8859-1?Q?nC96e4DaOyUaSyL5bQCosrRPv3KmdvfGE81THcfxTOoSfTa3fwlyzWal6N?=
 =?iso-8859-1?Q?ZmypH+eVuvyCQhQvBc9o8JloH0lCHxXLMsMligcdTPuG4Xzi8CgAQ6dy6M?=
 =?iso-8859-1?Q?dwplyWEFqd2O/oGigViKUVMZn3YG+v27s4efWomu/Tj+O4ApAOCGNFFXzd?=
 =?iso-8859-1?Q?XtsJ5EOgBmNirpxm1ft4PjHbVsT7jfkIF0pqUkeNeT8k/6Zu9Xxgb+IWJZ?=
 =?iso-8859-1?Q?4m1WCXTTvBeDo0vYPEFJK1CjWA5OlVD0yG4DJdIA8Ar4fiKlYGN6Fsgjss?=
 =?iso-8859-1?Q?hA7KabFGrlXnRJubM6k1z4EEY8lP2jPCTIs2CCD2Og12/T4+AjXklMUHCr?=
 =?iso-8859-1?Q?f+vz8lG0Du7AyYx7dNHHw4F2O1fUvGU3wymQN8snXG+0TIycn9j3qNlVpP?=
 =?iso-8859-1?Q?hl3LifXgxsrzX3YwtcPZ7NfVT4TipLj7m3HQbRc+sWhkh2XuoZJLxfNLBC?=
 =?iso-8859-1?Q?0AnNW+j/uq/8O7ORrdTFPSkAGZQXchtgZGQGhJRhDNkDApejm0L1teuI86?=
 =?iso-8859-1?Q?aA+dyTDMW8i4xzR8kzY+GJ+0azCxU1PY2nMdQ+3Uj2XxqfTYUQ5xSsLswc?=
 =?iso-8859-1?Q?41ntv39Dk2tdD8hg+PcMLl2I1hGHIg4Qr4Ys8YK9dPukjUfEK7Soq3tdOV?=
 =?iso-8859-1?Q?LrZPoPYMkQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P192MB3464.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7ab0b6-3a4f-41ea-9ebb-08dee29353e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 17:05:52.8528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dfdd4aff-e2c9-4e1a-8642-7f6cc6bbbe6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPVSkwp6m7vd76A5Ls7LWSjaihz5XOlWcBKyYLKqLGSDoBJaiTAejsIJHA+hKyIVGdUQ0Cr+sqvEbGcuz5htiMdpMG0rcLh4OAtdmq3zl30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB2404
Received-SPF: pass client-ip=40.107.162.117;
 envelope-from=harry.vanhaaren@openchip.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

>From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>=0A=
>Sent: Tuesday 16 June 2026 7:40 pm=0A=
>To: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>; qemu-devel=
@nongnu.org <qemu-devel@nongnu.org>=0A=
>Cc: alex.bennee@linaro.org <alex.bennee@linaro.org>; erdnaxe@crans.org <er=
dnaxe@crans.org>=0A=
>Subject: Re: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution =
print loss=0A=
>=A0=0A=
>On 6/16/2026 9:13 AM, Harry van Haaren | OPENCHIP wrote:=0A=
>> From: Harry van Haaren <harry.vanhaaren@openchip.com>=0A=
>>=0A=
>> Executed instructions are cached in string format inside the=0A=
>> execlog plugin. These strings are flushed on exit of a TB, improving=0A=
>> performance. This causes executed instructions to be lost when an=0A=
>> 'ecall' (riscv system call) occurs that causes the thread to terminate.=
=0A=
>>=0A=
>> The fix in this patch registers an 'on_exit()' callback, and flushes=0A=
>> any content in the c->last_exec buffer, to ensure all instructions are=
=0A=
>> present in the final instruction log.=0A=
>>=0A=
>> A mutex lock/unlock is added around the plugin exit, to ensure the=0A=
>> lines are not corrupted.=0A=
>>=0A=
>> Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>=0A=
=0A=
<snip>=0A=
=0A=
>> +/**=0A=
>> + * On plugin exit, flush any remaining cached instructions and free sta=
te.=0A=
>>=A0=A0 */=0A=
>>=A0 static void plugin_exit(qemu_plugin_id_t id, void *p)=0A=
>>=A0 {=0A=
>> @@ -396,8 +417,10 @@ static void plugin_exit(qemu_plugin_id_t id, void *=
p)=0A=
>>=A0=A0=A0=A0=A0 for (int i =3D 0; i < n; i++) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU *c =3D qemu_plugin_scoreboard_find(cpus, =
i);=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (c->last_exec && c->last_exec->len) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_mutex_lock(&execlog_output_mutex);=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_plugin_outs(c->last_exec->st=
r);=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_plugin_outs("\n");=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g_mutex_unlock(&execlog_output_mutex)=
;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>>=A0=A0=A0=A0=A0 }=0A=
>>=A0=A0=A0=A0=A0 qemu_plugin_scoreboard_free(cpus);=0A=
>> @@ -467,6 +490,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,=0A=
>>=0A=
>>=A0=A0=A0=A0=A0 /* Register init, translation block and exit callbacks */=
=0A=
>>=A0=A0=A0=A0=A0 qemu_plugin_register_vcpu_init_cb(id, vcpu_init);=0A=
>> +=A0=A0=A0 qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);=0A=
>>=A0=A0=A0=A0=A0 qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);=
=0A=
>>=A0=A0=A0=A0=A0 qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);=0A=
>>=0A=
>=0A=
>Why not simply make this flush in atexit callback?=0A=
=0A=
I think on guest-thread join, the pthread stops, and qemu calls vcpu exit c=
allback.=0A=
At that point in time, its nice to flush the "ecall" (to printf or disk or =
whatever the output is) so the user sees it immidiately.=0A=
=0A=
The risk of not flushing here, is we wait until:=0A=
A) the plugin (not thread) exits, which could cause other threads to interl=
eave/finish first (confusing, interleaved and delayed output)=0A=
or=0A=
B) a new thread is spawned by the guest, and the vcpu is re-used. This will=
 correctly flush the previous-thread final instruction, but after an applic=
ation-dependent delay.=0A=
=0A=
Given that thread-exit is already heavy-weight and rare, I think the best f=
or the user that the final instruction flushes immediately when a thread is=
 finished.=0A=
Unless I get strong feedback for a different approach, I'll respin the patc=
hset and send (with git-publish, with footer removed, and "| Openchip" fixe=
d... hopefully!)=0A=
=0A=
Regards, -Harry=

