Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B43C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpT88-0006vE-Gl; Tue, 04 Mar 2025 09:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tpLIm-0005eV-Bn
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 00:58:49 -0500
Received: from mail-koreacentralazolkn19012052.outbound.protection.outlook.com
 ([52.103.74.52] helo=SEVP216CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tpLIj-0008Dd-Lo
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 00:58:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omieZRAFWGa0Sxb7f7YIcC7CVL+DRDE+bWZr0HMoojBKfUJGOchmDwK6QBL5r5BCIJZgLkdArZYDDLAGDfOjB0uFz/XzhDtHuc1I06Xrx1WMmDrnQ7lKvwdhOcSSaKb4Lsrb7eCJIno5rZepn75H2ckrsoBwFB5l93fDXUolKByHF/vpU3eSDMVVH2H/Fe68K5AQgiWvGedmzgANOHPbfEQ+7bqPQ/1sIUsES6UilaHSTBTAakASLYNrGESkqNw637tQ8Nw9Lo8hZ0eB63c8lnrkZSJe4aUCwumShJs0Opgr+hkbuKYIRIRMU55c4/F4ezmtwAaR7beZJnmfdKLVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNuL9xaHCyS4C0KAt6vr23BngliiigSOhYpNn4i5qXU=;
 b=GBSfy9VXyajA0LbG6ODYre7cRkDuRWlHbD5E69hgLtIlYun2SmNY+kLD2rhuo/fA9xxR6ekBlmppQLKejBmrSm3BG7BeOuDRiJgF8AtgaqNFlFyk13neIqPdRxUSkL8kx+0+r94gsMDHVo0xQAZxyGuNXkAfZFzckaX4mLLIPJbf1OfNiYzuiNkjA6AE8f1huuUx882yu6DZnfbBWMxayoP38S3yifNsiVjSZyYTzwuZ/T42EUYjuFhhlsShGNVN9hpFelf09S58UN0HB55UK4J7y93CwR8SEQ2mZlVAfxGBqxBxkTdWsihvEfMcILrGAe1xuK1vnYvQM0g60mtSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNuL9xaHCyS4C0KAt6vr23BngliiigSOhYpNn4i5qXU=;
 b=IwHf7mTZjotfVELXBFd7neBKbO8E/dN02kp2QjNw5EagzDd/b62ehiYZBTxC9cCyaZiTlpVmegEahzHebYTGXMNeEqKPhjp69kwaeZt2c7U6bIq4rJ+u/OVkrKVi3JlWX0T2JhsRlpPa3++yjiPD4HecPMq1sA+XWdVKeBuadPIp86mYbsr/1i8YB4gd6ZmZimXJPvylkXdkZsNYjrYUPkDmCeMo56/ji/RUG22N3jwqVtN+2iEMzzcnfzp7VgD/R/6SRr66EawMRjQOVibbY7aO1bmDb7KdZKvBAnEbUQcvaQAl5sSTZfObQr8oHOfEPr8yUYfYIsAitT5xRVzXGw==
Received: from SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM (2603:1096:101:160::6) by
 PU4P216MB2051.KORP216.PROD.OUTLOOK.COM (2603:1096:301:130::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Tue, 4 Mar 2025 05:53:08 +0000
Received: from SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ee:60fa:3632:b408]) by SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM
 ([fe80::1ee:60fa:3632:b408%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:53:08 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>
CC: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Building QEMU as a Shared Library
Thread-Topic: Building QEMU as a Shared Library
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU67NWLXcAgAEJSQCAC1FcEQ==
Date: Tue, 4 Mar 2025 05:53:08 +0000
Message-ID: <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
In-Reply-To: <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1SPRMB0015:EE_|PU4P216MB2051:EE_
x-ms-office365-filtering-correlation-id: f1395e19-e33b-4c54-e409-08dd5ae0d729
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599003|461199028|8060799006|9400799030|14030799003|19110799003|15080799006|7092599003|12050799009|440099028|10035399004|3412199025|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YA9RAnRZy2c9bzdHo7+2igZgSWvKQy5/dFdhpHubz9S1/+l1thXcxsxyPk?=
 =?iso-8859-1?Q?nQBe4E+GN+yWcfj3dNouanggqpnKLza1GabUTpd403c5Zrnyg/yihgkwiA?=
 =?iso-8859-1?Q?7x0FoiQZeuQV3RcjDkeq6oflbyNhUdbbpHNKJPb6aSlx1miaEECcuJr15d?=
 =?iso-8859-1?Q?N7QB9/x2GsE689ORfAQ5xRv/MV2mum8ChsPUB8CLTwUI2I5heX6ob8My6K?=
 =?iso-8859-1?Q?jjAWydvoDqAJrahdKh75RHrxv2J8BZxLCVg5efQVfF8Pv+xh8dBQLvd5yf?=
 =?iso-8859-1?Q?kGVJlm7yec/w31MT8wkVxViEEvr1o9g2R79MR3JPz8C46b1RGbb09AHFb8?=
 =?iso-8859-1?Q?scMrLllHB/wFMrYJpDuLIwXNQ29Ar97ZRQbK31iOdgXjkHS+sXR4f/X+He?=
 =?iso-8859-1?Q?w1VrLh6GVe1WdyFZRwYwkesPZkf3XCBW3OBTJkBgjHmmf2ohro1CxCQ4VN?=
 =?iso-8859-1?Q?dtZrnLlSN58OXVQDjvvkrwPqbba2nXhYd6wcAmv96ZCqjhe/ma4BB+meTN?=
 =?iso-8859-1?Q?LQZ2CuYo5EOunJCyazvRKbQxTVgC4as7W2j4kMbArkLUMV85Aco6N04jnH?=
 =?iso-8859-1?Q?s8th8/aSuZx9qW2X9N1vYztGY8zpe5yQUyRyU8k/EvXSHxjzkeaYTPojCY?=
 =?iso-8859-1?Q?nf3okW0C2SwP4qyuInkUoyIQp/kBK4rprTQ8B0s4rUwnuQpnGdAZ3tw6vL?=
 =?iso-8859-1?Q?7xBoxmeLZURERTQNjVY/Uwz8zi+iU6lqN1J70fjAVnufFiS3dt6QVQCRY1?=
 =?iso-8859-1?Q?wFAb3zhDv7hCpJXqnI6KDTIvNwNWPnC/AiOQKcsrxLqf8ZrOKZRpvFJFBv?=
 =?iso-8859-1?Q?PMXqzmvhFJ5q/WZbwhUCo8+yQ+vlLM5dRAZAPVhK6PTt8KUTc5nCqDy5QX?=
 =?iso-8859-1?Q?nF7IsbmcsqxiCP0UFMHzhqnFlbeOxyKWAy23gj4Q1Cj3qQRYKwj8JUNZnr?=
 =?iso-8859-1?Q?h2LHhmp0Br5gZuIJhle7TUSKT8UrAeiP5mQCa+EWcbRDLqK+lAhUgayp3S?=
 =?iso-8859-1?Q?HFV7VrNEhI7VaWrffjhYsnu2kIuXit7IA9Dw91HOssM9xEu/Iiq8C6ka5c?=
 =?iso-8859-1?Q?yQvMdNBPi+o3ti/yU7O6BnSu5slj0CfH/uNoQhstTdatZP+Cf/vpgUdegk?=
 =?iso-8859-1?Q?4724Y65OemR4i0uptijuOGhjXAkjrNApDj02WLwl2cxaInI8mZRI3hZCIV?=
 =?iso-8859-1?Q?yliwIHjzHGheRxRJkJcFnOM/keRdfVIM+qbDnc2tlDqizir4GryrUGKMGC?=
 =?iso-8859-1?Q?bmq22VmP+oH+7FS7+ADtcocYsGl0EBTaE12lXiodY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nwLxTFtlCs7g57SpITpDIr07MONetvpIQEG2iTYxu9vOUdTzSrtImdr6NN?=
 =?iso-8859-1?Q?aM44UoB/PeiX6L7PZ4zmAq9Q85DNaJjxLEEDnEhXS92MviA1wS1qYMfTq8?=
 =?iso-8859-1?Q?BfCRhZgXR06lgavUTSMgZ2BlrN/y5lvvtqlYgvNMtrGrs/hM9SHIbqYdW+?=
 =?iso-8859-1?Q?932vcpUDThfrLK1g9Ob1F/qhmcMUmzK+FLh3lZMRos8KIHn23pjQjNLVQt?=
 =?iso-8859-1?Q?4Vo+yZhVjIAXFYbiO1QecNhISVMGs0CqExhpC09rohIt8YUgeDpbk0BdaH?=
 =?iso-8859-1?Q?AiPm1HbDtc851aif1LOn/+51kPPTsgz1T2QQyxH9iuha1XjCrx0uuDy3R/?=
 =?iso-8859-1?Q?XOnSVNmNVChIDAhf/WHCXRXk8a7k5W0pMCWcIWLRRfmF1lYnHuAlgrTr8N?=
 =?iso-8859-1?Q?eXf+VcyelttIiv9eOOWC/fAKWzsmSHFEbF0NOs+Zlcn8ncGIC63p1uIk1/?=
 =?iso-8859-1?Q?xJh6cmjqgc6ITowgSp/U8hQeQNVojHmM2GDf0lt4LcwvQpNSHhmqLPV36c?=
 =?iso-8859-1?Q?PZV5IwNKdMo9Rm+b+Paxld5j7RaZ57p6XtnSLXb9F2C0Oc4FFav79OJhlc?=
 =?iso-8859-1?Q?Ks9QMLUwe2YW6hd8vrEFfrjyDBL7qlo81BgUxNtw8CYHCQbIEOR6EpLTVs?=
 =?iso-8859-1?Q?lxh94MHpkJLmCHy3EUUL0DWORRT1yE6nGncDUkcpyKni43+4x0hJcynYG3?=
 =?iso-8859-1?Q?WfNbOrzaw8eqKliwvtIDgtoTN8IvVA1q9hin9fuJFeRKLT7tZFDHu8BlJD?=
 =?iso-8859-1?Q?GTndnzbU1ZFfmn3yQ9tyxXM4KOeWvVewmACGIXOXPISeSPfCSYPjGZSI7e?=
 =?iso-8859-1?Q?EzUlAWqUB/EUBID/WtnEoXR910BlpcGJ6d7HsJPbGhQ/p//T643ieloB87?=
 =?iso-8859-1?Q?vIkw5+WlFZGSWhEA3DiFkPoi8y2r4Ntlz+UuaO+lxbMxmOwI5aB+CHs5iH?=
 =?iso-8859-1?Q?o3iveH5DuIMIYVEODldPjIKNDtKd8ZSDUFGrjUVh6bSZHwHMobqQvWNJdR?=
 =?iso-8859-1?Q?F63FxBGksJpKb4p1OC1zcA3GcY6a1gxG0x3z6PRW2g+VDxw1r7/qAchtll?=
 =?iso-8859-1?Q?pw7OehJOrPISr/dEU9AhQ4KrAiyDLhyUiWYdxIqQSKMqQjXog8lJ7L9Hhu?=
 =?iso-8859-1?Q?MhleIXDyRoaBPU2D2hIk0BNU1Qa2KmBPTZ24LTDBh8lJGk9NFwIqD/hBsB?=
 =?iso-8859-1?Q?Azk7YGFMYthppK4botp0EsvE6U5zlcIRLjME/7YQynmHSDKHNuX7iGBiu9?=
 =?iso-8859-1?Q?OxqnAcZBiaKYKKzIIwJu5ItdWik2ltOdoYWSMb6rXT9gYWHBRbu77YeNuD?=
 =?iso-8859-1?Q?Pm51V5CWEKkD7vipn93BpgedIg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SE1SPRMB0015BDAF043E9103B24B9973CCC82SE1SPRMB0015KORP21_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f1395e19-e33b-4c54-e409-08dd5ae0d729
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 05:53:08.5122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB2051
Received-SPF: pass client-ip=52.103.74.52;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SEVP216CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Mar 2025 09:20:14 -0500
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

--_000_SE1SPRMB0015BDAF043E9103B24B9973CCC82SE1SPRMB0015KORP21_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi,

Thank you so much for your inputs. I was able to create the .so file of QEM=
U.

Actually, what we are trying is to understand and explore possibilities of =
Virtual Time Control in QEMU. In short, what I mean to say is an approach v=
ia which I can tell QEMU to emulate for XYZ time when the I give a trigger =
and then pause the emulation by itself after the XYZ time is completed.

On that front itself, do you have any inputs/ideas regarding the same?


Regards
Saanjh Sengupta
________________________________
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Sent: Tuesday, February 25, 2025 6:29:44 AM
To: Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@r=
edhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongn=
u.org <qemu-devel@nongnu.org>; Saanjh Sengupta <saanjhsengupta@outlook.com>
Subject: Re: Building QEMU as a Shared Library

Hi Saanjh,

here is a minimal patch that builds one shared library per target (arch,
mode) where arch is cpu arch, and mode is system or user, and launch
system-aarch64 through a simple driver:

https://github.com/pbo-linaro/qemu/commit/fbb39cc64f77d4bf1e5e50795c75b6273=
5bf5c5f

With this, it could be possible to create a driver that can execute any
existing target. It's a sort of single binary for QEMU, but shared
objects are mandatory, and duplicates all the QEMU state. So there is no
real benefit compared to having different processes.

In more, to be able to do concurrent emulations, there are much more
problems to be solved. QEMU state is correctly kept per target, but all
other libraries states are shared. There are various issues if you
launch two emulations at the same time in two threads:
- glib global context
- qemu calls exit in many places, which stops the whole process
- probably other things I didn't explore

At this point, even though qemu targets can be built as shared objects,
I would recommend to use different processes, and implement some form on
IPC to synchronize all this.
Another possibility is to try to build machines without using the
existing main, but I'm not sure it's worth all the hassle.

What are you trying to achieve?

Regards,
Pierrick

On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing our meson experts
>
> On 22/2/25 14:36, Saanjh Sengupta wrote:
>> Hi,
>>
>> I referred to your mailing chains on suggesting QEMU to be built as a
>> shared library.
>>
>> *Change meson.build to build QEMU as a shared library (with PIC enabled
>> for static libraries)*
>> *
>> *
>> Could you please suggest what exactly has to be enabled in the meson.bui=
ld?
>>
>> I am confused on that front.
>>
>> Regards
>> Saanjh Sengupta
>


--_000_SE1SPRMB0015BDAF043E9103B24B9973CCC82SE1SPRMB0015KORP21_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">Hi,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thank you so much for your inputs. I was able to create t=
he .so file of QEMU.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Actually, what we are trying is to understand and explore=
 possibilities of Virtual Time Control in QEMU. In short, what I mean to sa=
y is an approach via which I can tell QEMU to emulate for XYZ time when the=
 I give a trigger and then pause the
 emulation by itself after the XYZ time is completed.&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">On that front itself, do you have any inputs/ideas regard=
ing the same?&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Regards</div>
<div dir=3D"auto">Saanjh Sengupta&nbsp;</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pierrick Bouvier &lt;=
pierrick.bouvier@linaro.org&gt;<br>
<b>Sent:</b> Tuesday, February 25, 2025 6:29:44 AM<br>
<b>To:</b> Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzin=
i &lt;pbonzini@redhat.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@red=
hat.com&gt;<br>
<b>Cc:</b> amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Saanjh Sengupta &lt;saanj=
hsengupta@outlook.com&gt;<br>
<b>Subject:</b> Re: Building QEMU as a Shared Library</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Saanjh,<br>
<br>
here is a minimal patch that builds one shared library per target (arch, <b=
r>
mode) where arch is cpu arch, and mode is system or user, and launch <br>
system-aarch64 through a simple driver:<br>
<br>
<a href=3D"https://github.com/pbo-linaro/qemu/commit/fbb39cc64f77d4bf1e5e50=
795c75b62735bf5c5f">https://github.com/pbo-linaro/qemu/commit/fbb39cc64f77d=
4bf1e5e50795c75b62735bf5c5f</a><br>
<br>
With this, it could be possible to create a driver that can execute any <br=
>
existing target. It's a sort of single binary for QEMU, but shared <br>
objects are mandatory, and duplicates all the QEMU state. So there is no <b=
r>
real benefit compared to having different processes.<br>
<br>
In more, to be able to do concurrent emulations, there are much more <br>
problems to be solved. QEMU state is correctly kept per target, but all <br=
>
other libraries states are shared. There are various issues if you <br>
launch two emulations at the same time in two threads:<br>
- glib global context<br>
- qemu calls exit in many places, which stops the whole process<br>
- probably other things I didn't explore<br>
<br>
At this point, even though qemu targets can be built as shared objects, <br=
>
I would recommend to use different processes, and implement some form on <b=
r>
IPC to synchronize all this.<br>
Another possibility is to try to build machines without using the <br>
existing main, but I'm not sure it's worth all the hassle.<br>
<br>
What are you trying to achieve?<br>
<br>
Regards,<br>
Pierrick<br>
<br>
On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:<br>
&gt; Cc'ing our meson experts<br>
&gt; <br>
&gt; On 22/2/25 14:36, Saanjh Sengupta wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I referred to your mailing chains on suggesting QEMU to be built a=
s a<br>
&gt;&gt; shared library.<br>
&gt;&gt;<br>
&gt;&gt; *Change meson.build to build QEMU as a shared library (with PIC en=
abled<br>
&gt;&gt; for static libraries)*<br>
&gt;&gt; *<br>
&gt;&gt; *<br>
&gt;&gt; Could you please suggest what exactly has to be enabled in the mes=
on.build?<br>
&gt;&gt;<br>
&gt;&gt; I am confused on that front.<br>
&gt;&gt;<br>
&gt;&gt; Regards<br>
&gt;&gt; Saanjh Sengupta<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SE1SPRMB0015BDAF043E9103B24B9973CCC82SE1SPRMB0015KORP21_--

