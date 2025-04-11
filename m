Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81652C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 09:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ao8-0006SC-5e; Fri, 11 Apr 2025 05:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1u3Ao6-0006Rw-GB
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 05:36:18 -0400
Received: from mail-koreacentralazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::2] helo=SEVP216CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1u3Ao4-0007pi-BZ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 05:36:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyigok4SpoL3Ta9bIQHbUWJvOQl50F+sWpUT4+56kf3/gGYZ0O2jC2PaKqcKJ5QodHpqQ5yG8eNoSVqiKEt2zxgXnjVoet//v7Flb1d/EDguxLCUv5lZJldCR9E/QGwvO3GxUmrVFzPuPn50XCNJYB++LscQZpVCvawFzu9TS8qKO+BdlPdIaliRhnbTUSsZvxVQumTxqwpcBms6EP6PbobEoFu6EU1nri+c4+ECLrsZvk1WUBUO95iULIIy08TDsN6uumQ5tWrDTM9qdRMmBgO+1hT1qySZZeONH6SNdgk1gQBCVwLJK8LsLO5W24G1/PAYIxJPdH61GEF+VvPKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVothbx3AuxjDvuZV1PaEKzvGamrZmnaCMF/M/fR5oU=;
 b=HUtiFj2y/t/Zr79cBZmrt8LdkOuVVqTSR6e5caeYXFND8++612KmXa735Jqzc5RkIt++N2NpYP/OVNgsGw2aywkQKfFbowb3tPu1USUda5vrE8n6npWilKiheZAOSXTKYYX4VYixdU4ciJbZTB39eiRTW49wOVeIOKHW8KjdFL/bPEjNRJmokYj1JEIBnvuVmWT4Ni4/r1LlJcxwykd0iACPI9avQUM3bgS/nU42ucshwhO97mZ4d9cVyHmaHsNyvgUJqdJtN5/DsOiB/UYCSp4EbRJREwehsn976EGOPmVGfz9Z7TcvbYk4TdAy/7QOHBcU6m4OGN7c5wkQk1Dugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVothbx3AuxjDvuZV1PaEKzvGamrZmnaCMF/M/fR5oU=;
 b=tmZrJD6rGEznE8/hqSLWDPhX/OFxWY9PPeeNvIx9tMGNDWIsBChIdtZzKC0IneLYgargVf6nEZbr0k0o0OWJSsMEZl+9Q16XXDGb3hrJHpwhg+kkELpWOVbssPcZgizCQfuJLBcNW8eT/qsP5prS5JeFMDctESPCF2Paoi/OlYUU8b7fLJtjTQxzGL2alrm/QYmnkutcEnLfE1SNuZv5X3P5G3+dLRUMUerAbPGGyLonUTDuFnKjX02ojZhzby3HXoNESRuNWDoegPF8BKx5TyCAEaHI8MrT7ujxsff5x7WeKT6+crMDv8WBPQN+y2W1RCusYOedfJMxPnJ7TazIcQ==
Received: from PS2P216MB1388.KORP216.PROD.OUTLOOK.COM (2603:1096:301:99::6) by
 PU4P216MB2098.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12c::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.24; Fri, 11 Apr 2025 09:36:07 +0000
Received: from PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
 ([fe80::cf60:86f0:7ddd:c026]) by PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
 ([fe80::cf60:86f0:7ddd:c026%4]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 09:36:07 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
CC: "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "amir.gonnen@neuroblade.ai"
 <amir.gonnen@neuroblade.ai>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "aabhashswain25@gmail.com" <aabhashswain25@gmail.com>, "aniantre@gmail.com"
 <aniantre@gmail.com>, "guptapriyanshi180@gmail.com"
 <guptapriyanshi180@gmail.com>, "harshitgupta5049@gmail.com"
 <harshitgupta5049@gmail.com>, "atakale@gmail.com" <atakale@gmail.com>
Subject: Re: Issue with stoptrigger.c Plugin in QEMU Emulation
Thread-Topic: Issue with stoptrigger.c Plugin in QEMU Emulation
Thread-Index: AQHbqgkoRvQTBP5kkkqjjTRUTVHxm7OdBYYAgAELhHo=
Date: Fri, 11 Apr 2025 09:36:07 +0000
Message-ID: <PS2P216MB13883D8DE8571EFF1E72A6AECCB62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
References: <E57BEAE6-4DE5-4FF7-AADE-DB43678FE2E6@outlook.com>
 <a8d9bc7f-2162-4198-ab6c-67e72c5e964e@linaro.org>
In-Reply-To: <a8d9bc7f-2162-4198-ab6c-67e72c5e964e@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1388:EE_|PU4P216MB2098:EE_
x-ms-office365-filtering-correlation-id: 95a17db4-8791-468c-861d-08dd78dc4973
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599003|12050799009|9400799030|8060799006|461199028|14030799003|19110799003|7092599003|15080799006|10035399004|3412199025|440099028|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info: =?us-ascii?Q?mYmfT28dsb2rF1dZ/jS+LbwiepHUTGxVjM23jC2MOCxYaHn3onZKtF4pBjrz?=
 =?us-ascii?Q?w5plrNPNco/JVVK6Up2yNWuXOejNjdqb5mrDLrKmEIIHdvzGUaQcYihRhMwx?=
 =?us-ascii?Q?Pm7YRlurWVSLt6tj4Dh2y19Zxr9w2vxUbUTJtShCLSNh3YYfOL6hfTZuYbaN?=
 =?us-ascii?Q?8dQ42w8tgBfDNat7v1GxFP5yqZb09OkD80i6Tr32A46/Z3DmrYUmJfXrqWGX?=
 =?us-ascii?Q?ZLzHEZ+3Ne6egPOKBn3u3TzB6yKOwlC9mFJr4j/IUByaCrEUVfHvQPkMVF2v?=
 =?us-ascii?Q?k8ZRxKHjKbszX0W7IGGJvVS+CL++H4GxJhGWrtyAeuN5OwuJTrOP7NBb51QS?=
 =?us-ascii?Q?y3dWyjA/48ixm86/Zmqq90Hz+mttpzZk8tvMDxVn7QVTbwSQ688AF5Cc/bwm?=
 =?us-ascii?Q?U3FDfDNdVz+myqmTcONsi3hvqkVi5CrubtVQfovKKCyg0vKyJeMhJAkYLv+0?=
 =?us-ascii?Q?JxBm8a35zfWA3fXCxLu9nFLbi80jUUOEUkMcfiXJV73FRQjBgu7qTd/D16Ti?=
 =?us-ascii?Q?skcWnHBeHrE80ot/M2Dwdcc2WniE7Q6+bJ9fdpZJTSt9+1QP8nCyB82/76qW?=
 =?us-ascii?Q?NoqJvLkr5xvLFhIr5e4VtL89k9w/uYthpO1CF/qfefZZ6xybRw9Y9p/InGrC?=
 =?us-ascii?Q?6M8kcib19k7bgqZgF0eEnJWaBgfPlv+dZ21qzdAvJx1RkaHZXKoj3WkgB9Sg?=
 =?us-ascii?Q?/wOzkTqtU+UzgH8wtSNiIDv2se5lCDi0QD2yWiFINlAh7Nc5SPQBNF6q3Rrf?=
 =?us-ascii?Q?EPGb5UhSYg1O+MhEXkKWf4vGwcP/aWCLxF65oL3ppCU9U/Ofus7CR1VAL1fn?=
 =?us-ascii?Q?VLyCJdMPHCAxBAmA9GE2CCLb98wOta3icKikTvkIThJZ9ueoMTAuGhfYReMW?=
 =?us-ascii?Q?yJ8UpX2HskibssWrS3/AwM7DcPtxmfA2FdqWPTNF7z9fshIY+rmotyAlnQr/?=
 =?us-ascii?Q?Gsb4zRiE0gYuQ0Wif/2iIc042sOiTwZR53KLmbgXptOnPmvBOqKrI4Mci4Ts?=
 =?us-ascii?Q?D9mJkplplOw/9Ze+hJasZkbGu45LopTe0g5CgjcXdmnyuvcO8iMaLnz2TGOD?=
 =?us-ascii?Q?tCRNhVqBXf6FB52KWrIYVYFU0Ee7ykz+xBzpJE5/PQnsyCJuGYSH3qJarlRk?=
 =?us-ascii?Q?w1jgaaqIz511xL4A2AYbCapzAPlnojCuYFzvOtzFvczNiUeK1FVTDyyVe14X?=
 =?us-ascii?Q?M2nA2+4Dhpya12Nthv3Zv44lJV3PxyBXoHlnbbqQiCYYBg3h3+rv151ksoiL?=
 =?us-ascii?Q?bXkoOwkKnqLjIMtZSGNqEbfZCZ8W+dpCGrJZp7Xqq9Fq1ekm1Wp7/83WcodZ?=
 =?us-ascii?Q?9D+jV4/6HNFZNnurN3wRnXwm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XjFrpV+s+cRfYAjrjDoams4p6AtVVk9Ol/2aAlcuCnyjjzfdSd3YfgEBo2nD?=
 =?us-ascii?Q?rDRCVlsTZBYD14IT6Xcd4bUAnKwKVpo4Twz3zYTtBsEdtF+3SvNZiW9eV78l?=
 =?us-ascii?Q?bC9GkhV6nSApFViWYLMcCvgdrEHOteSwnKj3QxVSVZ68Qg/SgAtpcHLQvGzz?=
 =?us-ascii?Q?VbSkEIpB+ylej2++B88X/cQWUDJvX2O7XETOh1pzgdoMiNwzGYX+pQCynNEQ?=
 =?us-ascii?Q?tIAD7qMk4tSxps8T4dHZbMKXiT/Rc24Upz57dE+2vmxGETG+xjCYUiNq3aS9?=
 =?us-ascii?Q?h/jPD4gsl+HNkyaWv27T/Xr5EVj9U/stVk6Dvzhwc/N63OM8Nv+99uRBC55M?=
 =?us-ascii?Q?oDbZbUawZKz9x7GBTHnfeJAefFxbjGf/exkz+GL6sskiVCyFLtw4xuMbSD14?=
 =?us-ascii?Q?BPeqTSkjFvhI/1k+OdaKPIGdcxB1ABTQlbqDHwa5Y6bGXiCNsiLWKPBTn0ui?=
 =?us-ascii?Q?FCDAyLzstfXnSEz1G0bsFTyBEZSamNOSaHWDsr2Y1TWoCOIFVmfQAjkkrgbe?=
 =?us-ascii?Q?vnvUhC14UvVeZxcmo5Y8D19Zx1mN0sbtkktlktWpuktJGRRT/+9vJr7EuPnw?=
 =?us-ascii?Q?ZwWbJKhTAQts5B1dgnmEAAZke3DQvqW6UWNqViNcPGEglSGQWBEWg8pl0Ih9?=
 =?us-ascii?Q?i3gN6tIuzOlrQojS41MJon8lF+cu2eN+80OGD9s+xEZycPAIUkEtL3XrmeiN?=
 =?us-ascii?Q?9rkGYfhIIkkKjO7Zm6r/YviV2lNVv2gS4rnbaOX2ora9KWbwX28UgaZJmFzq?=
 =?us-ascii?Q?WkG3/XCIjCzfgahTRjhL1C5L0VchhaH0wGlbDLDY6hE0x2fM/+PhOPN0GGq4?=
 =?us-ascii?Q?r9oCZVmgiH6vr2pB7AkUpYhkOH6PuwBvRyO59U468QwPm3WoSe59rr7bbQWY?=
 =?us-ascii?Q?6Cb/bk6irVkbHuq++dzISgZjOtp7E4LCbQfOsBdl5pcvXXBWRLdPWY9N/Etv?=
 =?us-ascii?Q?YPQLg5R+swpsPMujYOkLaHzNNYDuy0BvtvQnd3SM7wCNgRJDFUw4kqaQ/vus?=
 =?us-ascii?Q?QZIwwe6FhplviUcedNMYpb/XSkU9Kxq5u53ZRKEr2xtB5v7KRXGZA3IcyWZ7?=
 =?us-ascii?Q?zbcMsjvbntWIbld0iQo56DuThsO19r8EATBOiFtC/rwFI8d519K9a08J22F6?=
 =?us-ascii?Q?qe8XgGOq7php5cvzeGF9u/m4Hml9SoPrXpfSLjO1wcpo+jJrcTNRNmQlp9nz?=
 =?us-ascii?Q?FkjE13RGyFZ0C7p5w86UPHuhvjoL8M0kZJlpOhDhzIuZGL+mw75KraKjTmBB?=
 =?us-ascii?Q?GUOSEDHj92MHOTnvmc3c?=
Content-Type: multipart/alternative;
 boundary="_000_PS2P216MB13883D8DE8571EFF1E72A6AECCB62PS2P216MB1388KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2P216MB1388.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a17db4-8791-468c-861d-08dd78dc4973
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 09:36:07.6416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2098
Received-SPF: pass client-ip=2a01:111:f403:d40f::2;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SEVP216CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
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

--_000_PS2P216MB13883D8DE8571EFF1E72A6AECCB62PS2P216MB1388KORP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for responding.

The error is consistent while executing a command on the latest master bran=
ch (commit ID: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365) for the v10.0.0-rc=
3 release.

Could you please confirm if you are using the same command (like I do in my=
 case), and if possible, share it for reference?

Also, what OS are you emulating in QEMU and what is your host machine confi=
guration over which QEMU is running ?

Regards
Saanjh Sengupta


Sent from Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Sent: Thursday, April 10, 2025 8:55:32 PM
To: Saanjh Sengupta <saanjhsengupta@outlook.com>
Cc: philmd@linaro.org <philmd@linaro.org>; pbonzini@redhat.com <pbonzini@re=
dhat.com>; marcandre.lureau@redhat.com <marcandre.lureau@redhat.com>; amir.=
gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongnu.org <qe=
mu-devel@nongnu.org>; aabhashswain25@gmail.com <aabhashswain25@gmail.com>; =
aniantre@gmail.com <aniantre@gmail.com>; guptapriyanshi180@gmail.com <gupta=
priyanshi180@gmail.com>; harshitgupta5049@gmail.com <harshitgupta5049@gmail=
.com>
Subject: Re: Issue with stoptrigger.c Plugin in QEMU Emulation

Hi Saanjh,

I have not been able to reproduce the issue with current master branch.
Is it an error you see for every run?

Regards,
Pierrick

On 4/10/25 04:10, Saanjh Sengupta wrote:
> Hi,
>
> I am writing to seek assistance with an issue I am experiencing while
> using the stoptrigger.c plugin in QEMU emulation. I am currently
> utilising the latest QEMU version, 9.2.92, and attempting to emulate the
> Debian 11 as the operating system.
>
> The command I am using to emulate QEMU is as follows:
> *./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic -serial
> mon:stdio -nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda
> debian11.qcow2 -icount shift=3D0 -plugin ./build/contrib/plugins/
> libstoptrigger.so,icount=3D9000000000 -d plugin -qmp
> tcp:localhost:4444,server,wait=3Doff*
>
> However, when I attempt to use the -icount shift=3D0 option, the plugin
> fails with the error "*Basic icount read*". I have attached a screenshot
> of the error for your reference.
>
> error.png
>
> When I remove the -plugin argument from the command the OS boots up
> perfectly, as expected. Command utilised in that context was somewhat
> like *./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic -
> serial mon:stdio -nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda
> debian11.qcow2 -icount shift=3D0 -qmp tcp:localhost:4444,server,wait=3Dof=
f*
>
>
> I would greatly appreciate it if you could provide guidance on resolving
> this issue. Specifically, I would like to know the cause of the error
> and any potential solutions or workarounds that could be implemented to
> successfully use the stoptrigger.c plugin with the -icount shift=3D0 opti=
on.
>
>
> Regards
>
> Saanjh Sengupta
>


--_000_PS2P216MB13883D8DE8571EFF1E72A6AECCB62PS2P216MB1388KORP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto">Hi,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thank you for responding.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">The error is consistent while executing a command on the =
latest master branch (<b>commit ID: 56c6e249b6988c1b6edc2dd34ebb0f1e570a136=
5)</b>&nbsp;for the
<b>v10.0.0-rc3</b>&nbsp;release.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Could you please confirm if you are using the same comman=
d (like I do in my case), and if possible, share it for reference?</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Also, what OS are you emulating in QEMU and what is your =
host machine configuration over which QEMU is running ?&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div dir=3D"auto" id=3D"ms-outlook-mobile-signature">Sent from <a href=3D"h=
ttps://aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pierrick Bouvier &lt;=
pierrick.bouvier@linaro.org&gt;<br>
<b>Sent:</b> Thursday, April 10, 2025 8:55:32 PM<br>
<b>To:</b> Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;<br>
<b>Cc:</b> philmd@linaro.org &lt;philmd@linaro.org&gt;; pbonzini@redhat.com=
 &lt;pbonzini@redhat.com&gt;; marcandre.lureau@redhat.com &lt;marcandre.lur=
eau@redhat.com&gt;; amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai=
&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; aabhashswain25@g=
mail.com
 &lt;aabhashswain25@gmail.com&gt;; aniantre@gmail.com &lt;aniantre@gmail.co=
m&gt;; guptapriyanshi180@gmail.com &lt;guptapriyanshi180@gmail.com&gt;; har=
shitgupta5049@gmail.com &lt;harshitgupta5049@gmail.com&gt;<br>
<b>Subject:</b> Re: Issue with stoptrigger.c Plugin in QEMU Emulation</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Saanjh,<br>
<br>
I have not been able to reproduce the issue with current master branch.<br>
Is it an error you see for every run?<br>
<br>
Regards,<br>
Pierrick<br>
<br>
On 4/10/25 04:10, Saanjh Sengupta wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I am writing to seek assistance with an issue I am experiencing while =
<br>
&gt; using the stoptrigger.c plugin in QEMU emulation. I am currently <br>
&gt; utilising the latest QEMU version, 9.2.92, and attempting to emulate t=
he <br>
&gt; Debian 11 as the operating system.<br>
&gt; <br>
&gt; The command I am using to emulate QEMU is as follows:<br>
&gt; *./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic -serial=
 <br>
&gt; mon:stdio -nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno&nbsp; -hd=
a <br>
&gt; debian11.qcow2 -icount shift=3D0 -plugin ./build/contrib/plugins/ <br>
&gt; libstoptrigger.so,icount=3D9000000000 -d plugin -qmp <br>
&gt; tcp:localhost:4444,server,wait=3Doff*<br>
&gt; <br>
&gt; However, when I attempt to use the -icount shift=3D0 option, the plugi=
n <br>
&gt; fails with the error &quot;*Basic icount read*&quot;. I have attached =
a screenshot <br>
&gt; of the error for your reference.<br>
&gt; <br>
&gt; error.png<br>
&gt; <br>
&gt; When I remove the -plugin argument from the command the OS boots up <b=
r>
&gt; perfectly, as expected. Command utilised in that context was somewhat =
<br>
&gt; like *./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic - =
<br>
&gt; serial mon:stdio -nic tap,ifname=3Dtap0,script=3Dno,downscript=3Dno&nb=
sp; -hda <br>
&gt; debian11.qcow2 -icount shift=3D0 -qmp tcp:localhost:4444,server,wait=
=3Doff*<br>
&gt; <br>
&gt; <br>
&gt; I would greatly appreciate it if you could provide guidance on resolvi=
ng <br>
&gt; this issue. Specifically, I would like to know the cause of the error =
<br>
&gt; and any potential solutions or workarounds that could be implemented t=
o <br>
&gt; successfully use the stoptrigger.c plugin with the -icount shift=3D0 o=
ption.<br>
&gt; <br>
&gt; <br>
&gt; Regards<br>
&gt; <br>
&gt; Saanjh Sengupta<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PS2P216MB13883D8DE8571EFF1E72A6AECCB62PS2P216MB1388KORP_--

