Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45068C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 04:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsDkz-0007Pq-7E; Wed, 12 Mar 2025 00:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tsDkn-0007If-Pm
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 00:31:40 -0400
Received: from mail-koreacentralazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::] helo=SLXP216CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saanjhsengupta@outlook.com>)
 id 1tsDki-0002TV-JK
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 00:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsHlsXKW/fBiXTMhNckrd2hMDuEK+HseohYe1lkH8hNaoMtEKhcVCXgRSbLlTP+OaspwQ00D7MYLn4x94KxhX7vLKubpF8D9Hm3KYuZ5oz1s+LQhVK6DXNP2ilmLJqycz/S9Q4jOA3XnR+a05/tKxfsj5KRKlbsxQn/wgIh17bodZgDPtbCNAsER6bDfgT6NiBVPcS1TxdrFhZ9Owh7i+obt6j2HkzL63TA4ar2icaXq6AfQn00yRdcz0BD9MegRXXT6gf+d1oYAbYzYO6CPgLOeHbhAXZVf1kCf75wmgyCB3YJn3aNQbhXj/wc2d2vF9vsX229v5wONP5yO8gkfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjkPKahnDTxMQTSkSHgHILD2ALKU9XAHp285MfPZ9ms=;
 b=fz3c/evlm8xbYxsP+vZqh7aQ5wBQt5phw3Kv6Y8IAKSQCdX3CX5pl4vFnNiHAsP9ZvN3bMsmb9GNQHvdmKA8aNm0PEVwiGTQTq5A4PzWgFQCGS4gWcxYr5Vzmyb3Xp7RGSzkqxGIojEbzd2g8pjEN7XTgtKDjPVCso6WQYmdWtykuHT+O7KBqQNhzUs7v1N2mE2+66yfTLmiO0nRsb++m7F5Z+B6yUoSw8oW3e8tgjFde6p0G3EgEwlQh2bsoJ5+cqTMxYMvMq+UGzsxOdoT0fo9uXnjiT3cEJCrE4mknLwj5JiAiTal4cb1hSJ5vW7D30/vpZy1CcQprmUdRt34cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjkPKahnDTxMQTSkSHgHILD2ALKU9XAHp285MfPZ9ms=;
 b=g+f5FvIjy5v6JckJIY788ZRnHdWOHUiRdwY0W5sD73VPr4dRF5n5gRmyr16g1cAf4lbaqJCLLtBYAJVR+pyszmtgV2RUtE/YMOQn66/OeoxErnQT9yf3qB1S+EmDcvj+9hKu3FSPByV+vftBzPBiOvmCBx/zCu6aS9qYMuMuStBEKbm7zsHws1Lvb5O7ubQL7SrXXItE1h2q064Jcr+bi48aXGqhaBaO1ZypDxdDrnAT23TBmBIBOvYY2fClrGuQW0osiC22buGlR5PJoMDAhb0nIkHndmwOnj8m9Hw2ZBY3Mu1z25QnO7czKkAhscG6zAUemBv8DVevGxJbxfJ99A==
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::12) by
 SEWP216MB3027.KORP216.PROD.OUTLOOK.COM (2603:1096:101:296::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 04:31:23 +0000
Received: from SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98]) by SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
 ([fe80::20cf:4ec:2a4e:f98%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:31:23 +0000
From: Saanjh Sengupta <saanjhsengupta@outlook.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>
CC: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Building QEMU as a Shared Library
Thread-Topic: Building QEMU as a Shared Library
Thread-Index: AQHbhS5hC6j1H6b7H06DOFGvD/EU67NWLXcAgAEJSQCAC1FcEYABLfwAgAn+2teAAM2LgIAAf5SG
Date: Wed, 12 Mar 2025 04:31:23 +0000
Message-ID: <SL2P216MB1380316B32539524D1CCD831CCD02@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
 <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
 <SE1SPRMB0015BDAF043E9103B24B9973CCC82@SE1SPRMB0015.KORP216.PROD.OUTLOOK.COM>
 <67a10cba-5bb8-4dda-a7c7-c7a3637bb1b3@linaro.org>
 <SL2P216MB138053F139E1B688D2BBA201CCD12@SL2P216MB1380.KORP216.PROD.OUTLOOK.COM>
 <2f1078d7-31bf-4940-aa43-30a45f7a07a0@linaro.org>
In-Reply-To: <2f1078d7-31bf-4940-aa43-30a45f7a07a0@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1380:EE_|SEWP216MB3027:EE_
x-ms-office365-filtering-correlation-id: f9bda3c8-f1c6-4116-6d6d-08dd611ebece
x-microsoft-antispam: BCL:0;
 ARA:14566002|12050799009|8062599003|14030799003|461199028|9400799030|8060799006|19110799003|15080799006|7092599003|3412199025|440099028|10035399004|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jDku8eBUfy+9GhBNsGt2nYMbiVk7fSgcy3giKjUkMT9dvRutIy9Tx7lyX+?=
 =?iso-8859-1?Q?9rAKWkmZcqcyDwXuHRDRo1Ia7tWlt/Pa5mcM3Tq+MVGN3kuoG1H7Tff9WF?=
 =?iso-8859-1?Q?dtMe5IzFXxGaCVX/rEgKY0GpwdWx4RF70yR6bLkZ4PHXL8XRI1ysEoU1aQ?=
 =?iso-8859-1?Q?Dj/J9T4PuP6WwYqX8li6Q/dhkIUBMEAXPxmKMicjI20c/kWtbMuIc5R9a/?=
 =?iso-8859-1?Q?W6RFQRoU/3WEwCUDq6TNCRJu0xXBuLCMZDt0Ddns0ctQlXYK+6q454mcOc?=
 =?iso-8859-1?Q?ozPtUczohf+RsMBfRqzeLyTlv5AtLgxw3EX1L7fsf13pqvudNfTxU5+PHW?=
 =?iso-8859-1?Q?ml0jqQAqIsGO8HtuWfS/qzKMp72Pvz8c2bm2WFn1xk1a0bMC/6o+fBoDs/?=
 =?iso-8859-1?Q?+GDoOXXrDRkfd5wDUs9MqbVkvD0BhgVFi7vJrMcR+z45EKdmRZj1V1rZfP?=
 =?iso-8859-1?Q?5sZv9tQuQNUVsRyKqe5yzDAhnnjM6n0vMnYdYpa//yBVDrKiE1o272nyOf?=
 =?iso-8859-1?Q?RyK02MnhsFADarJa4XUPnnYwp4AOsEgxMtRNOYY8GR+zgm5EzWS4nXsCOe?=
 =?iso-8859-1?Q?JYIki8yIY+KD8gVQhwPXLfAaKWmFHavdLkbYLH16+hSo3dXrTeqnY9es8W?=
 =?iso-8859-1?Q?2R3sf0fTXTWHPfU7liZw/+r23lfkdcWNU0q7M0IANp6APjBlsqOPlKhtCK?=
 =?iso-8859-1?Q?qsdmtqJWPkaLev7I/MmJRRjMT64zelBUfAPYIUhyozGK9LGqq1boCDx1yj?=
 =?iso-8859-1?Q?DpIh85xUp5xdjq7U3GXfpP/Z/NS4dlpNUQJeqJ8DxBywmjEQHzIxKxo0Tg?=
 =?iso-8859-1?Q?/RaUXT7os0d2g3ucUL60yYpNoVv/CxdGKAvZ4kNdm0fDWCghaVO7YzNGU3?=
 =?iso-8859-1?Q?8xzXfA8q9THh9R2zTm0b3qu+m9Fp+JJXEfHGXm6IyzglKoB/JPFY92RfBh?=
 =?iso-8859-1?Q?fivlx3bO/rfFhshUEi0TWE9Xkw6JY9P7j+yGcXwYRkrxGJZe5sOBI59tGD?=
 =?iso-8859-1?Q?EcANJM8Ii6dAHXMQpXEuJKyfRHiGndIt9s1gxYHTunrWSqfUim2E/Z9NDc?=
 =?iso-8859-1?Q?ke/AUuquB2nmmJ3RosULSUgnfzrFql9Et9mPzTV3G6/ElMdbPIbmda9LtO?=
 =?iso-8859-1?Q?6OBxUCn0ilYjuH2k3/CBj2kM5+I8KGzzjakJd3VDKeoO7Y3BDxEq4r+2PH?=
 =?iso-8859-1?Q?AqIQ4wCVvuxjT7CPYabN4ET2x19vZNRGby9O7uJPRO4pnCoD3BXbjWeHKn?=
 =?iso-8859-1?Q?s+I26Jtf8MHgc1YTeVwFY5j9iyFLdi36NLEMRIfxo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2IoGvGOs9awj4rUIacEr+6dRwwPjaM1vfGpkPrQQwRuAsTNnYK9lrrpP7X?=
 =?iso-8859-1?Q?RU2z8Q95cyntTAZ8T6OLnoZOnyVFds+E3yo1k+1pgSPXYVy4YbzvXwlKAb?=
 =?iso-8859-1?Q?bMDVO15D33sw3Gw0sD4l2a58EyTqHiI4rTPg1ad8rqNb/QqyaAojpgUVwl?=
 =?iso-8859-1?Q?GXcJXWDEqj39R/hr9adfO8yTuiA08AGopVaPlaiZFf5IQL/r5sq1h7yINS?=
 =?iso-8859-1?Q?dHEZGheg9iHiDu2Y3waGdXHN+cVnT6G3Ky2vdcF/LxHRTs7L5EjcytTfnk?=
 =?iso-8859-1?Q?rpmOydMqCnw0KA7wmYyGvI2OaPAR4zAgMJgH2giQ31h3DSz8E92dPjBh2q?=
 =?iso-8859-1?Q?EzbmES1smiOaQ0WOa9bcVtMi8BuePedAX7uSqk9Oe+wBWLjjV2id5/P/PO?=
 =?iso-8859-1?Q?broBIJ/WLZksPR7hTwuPC8WwFEjDcBz0N5Dd5BkgdClquRYm9FVmR9MPUp?=
 =?iso-8859-1?Q?moDMUjKCu5Fjzc40JZLgfrLrifX0u3E0SyBwkQA7xsigTKNXstkO4ubwia?=
 =?iso-8859-1?Q?7Q2DDWdG1SZ05gO0I5+9Sfktre5fPfWS8iqc+/1S08ccFfpUBm5nLEQB5U?=
 =?iso-8859-1?Q?+emJGy4SPbnYCjZ44nGm1jbMiEoBvh74iVRH/BpUBRw9CrIeQitllxYXMu?=
 =?iso-8859-1?Q?IagR6Jm4ng6C4a8Nb483evqqUzWtV5lDgsnk5DwHs238D3dVDAlzrOEMmp?=
 =?iso-8859-1?Q?pBpC59ZqoLCITcrdPYTh98uSx1Ip96atbZMeKPLK+v9uREa4F1HSnWZ+Pp?=
 =?iso-8859-1?Q?+bBml/gSNt9hn18eAeI6WE4d5Y3V7tTaDBVEGLoqzQ1BntmlOP0mEA4q9Y?=
 =?iso-8859-1?Q?iE2i2qav4YXyO91jH3HsmvGpWu319l5zHSLK9XRECPMcdjkqlDEWx+Ilsg?=
 =?iso-8859-1?Q?uBN9Em8lb6YLEJf/mdE4bStvsyzT7PFjlbIApa8KB654npX7UiVuVlA8FD?=
 =?iso-8859-1?Q?Sgw/AwZ5MF2R63ArWWlmnHNrTjYRSh2KGecKRu/VO3RZcZMm0Wtm11fK5s?=
 =?iso-8859-1?Q?jTu5fKY670tVQ1TAU532bWxsqjR+ASylje1gCUJrc83cTc3SE/Il2YIWGo?=
 =?iso-8859-1?Q?sVMrgdWJIP6WXmrJeyWfUV+Or5w1bE4AaH6aw7A41jMWxz/l4Q93BrWIzX?=
 =?iso-8859-1?Q?njgEjYetRPs/+sGbxdiqHud6Gd6uRE7C8LmxS1zzzeegW7DvVJCeL8RMcZ?=
 =?iso-8859-1?Q?vSih/ifvHybXUcPfu3HNEgtsYwG97tReHKVaBQif2aiWf8O3vv9z8uhfms?=
 =?iso-8859-1?Q?JSe7zwQlnCB8eUz5FGVipPYYfAqBiO1AJ/lH5vJyDpHKIsNFrmpy96VtjZ?=
 =?iso-8859-1?Q?xCfWemuJWMy3gpXqZzi8AlMqjw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SL2P216MB1380316B32539524D1CCD831CCD02SL2P216MB1380KORP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1380.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bda3c8-f1c6-4116-6d6d-08dd611ebece
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:31:23.4523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEWP216MB3027
Received-SPF: pass client-ip=2a01:111:f403:d40f::;
 envelope-from=saanjhsengupta@outlook.com;
 helo=SLXP216CU001.outbound.protection.outlook.com
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

--_000_SL2P216MB1380316B32539524D1CCD831CCD02SL2P216MB1380KORP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi,

Thank you for the clarification. Regarding the last time
"Stoptrigger might be a better fit for what you want to do, and instead of =
exiting, you want to resume emulation after N insn. The function qemu_clock=
_advance_virtual_time() can only be used to move the time forward, and you =
can not stop the "virtual time" by design."

I did not quite understand this. Even if I have to modify the stopTrigger p=
lugin, I would want it to pause rather than exiting.
For example: It gets 10000 instructions executed after that it should pause=
 and after some time it should then resume again execute till 20000 instruc=
tions (because previously it executed till 10000 and then it must execute t=
ill 20000). How do I do this? How do I state the code to pause the qemu's e=
mulation after 10000 instructions?

Moreover, I tried an activity where I was utilising the QMP protocol to con=
trol the virtual time (with respect to the IPS plugin). In that context whe=
n the QMP stop is triggered, my virtual time does got freezed until the res=
ume is triggered. Does this mean I am able to manipulate the virtual time o=
f the QEMU?



Regards
Saanjh Sengupta
________________________________
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Sent: Wednesday, March 12, 2025 2:14:47 AM
To: Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-Daud=E9 =
<philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-Andr=E9 Lure=
au <marcandre.lureau@redhat.com>
Cc: amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-devel@nongn=
u.org <qemu-devel@nongnu.org>; Alex Benn=E9e <alex.bennee@linaro.org>
Subject: Re: Building QEMU as a Shared Library

On 3/11/25 02:50, Saanjh Sengupta wrote:
> Hi,
>
> I have a couple of questions:
>
>  1.
>     When I use the libstoptrigger.so: in that case the QEMU 's emulation
>     stops after executing the defined number of instructions. Post this,
>     the whole QEMU terminates. And while using the libips.so I am
>     assuming that the QEMU doesn't execute no more than the defined
>     instructions. Please correct me if I am wrong.

That's correct for both plugins, with the additional note that libips
does this per second only.

>  2.
>     In my case, I want the QEMU to start emulation for some time and
>     PAUSE it's emulation for some time; after it is Paused (it's virtual
>     time is also to be paused) and then let's say for after 'x' time
>     period it should resume it's virtual time.
>

The virtual time variable in ips plugin is only related to this plugin,
and based on how many instructions have been executed, which is
different from what you want to achieve.

Stoptrigger might be a better fit for what you want to do, and instead
of exiting, you want to resume emulation after N insn.
The function qemu_clock_advance_virtual_time() can only be used to move
the time forward, and you can not stop the "virtual time" by design.

> image
>
>
> I have added this segment inside the update_system_time function inside
> the ipsPlugin.c. but once the instructions reach to the defined limit
> the virtual time does not seem to stop.
> Do you have any suggestions on that front?
>
>
> Regards
> Saanjh Sengupta
> ------------------------------------------------------------------------
> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
> *Sent:* Wednesday, March 5, 2025 5:20:38 AM
> *To:* Saanjh Sengupta <saanjhsengupta@outlook.com>; Philippe Mathieu-
> Daud=E9 <philmd@linaro.org>; Paolo Bonzini <pbonzini@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>
> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-
> devel@nongnu.org <qemu-devel@nongnu.org>; Alex Benn=E9e
> <alex.bennee@linaro.org>
> *Subject:* Re: Building QEMU as a Shared Library
> Hi Saanjh,
>
> depending what you are trying to achieve exactly, plugins can provide a
> solution. It's convenient and you can stay on top of QEMU upstream,
> without having to create a downstream fork.
>
> We already have plugins for stopping after a given number of
> instructions, or slow down execution of a VM:
>
> # stop after executing 1'000'000 instructions:
> $ ./build/qemu-system-x86_64 -plugin
> ./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin
>
> # execute no more than 1'000'000 instructions per second:
> $ ./build/qemu-system-x86_64 -plugin
> ./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin
>
> You can see source code associated (./contrib/plugins/stoptrigger.c and
> ./contrib/plugins/ips.c), to implement something similar to what you
> want, but based on time.
> Would that satisfy your need?
>
> Regards,
> Pierrick
>
> On 3/3/25 21:53, Saanjh Sengupta wrote:
>>
>>
>> Hi,
>>
>> Thank you so much for your inputs. I was able to create the .so file of
>> QEMU.
>>
>> Actually, what we are trying is to understand and explore possibilities
>> of Virtual Time Control in QEMU. In short, what I mean to say is an
>> approach via which I can tell QEMU to emulate for XYZ time when the I
>> give a trigger and then pause the emulation by itself after the XYZ time
>> is completed.
>>
>> On that front itself, do you have any inputs/ideas regarding the same?
>>
>>
>> Regards
>> Saanjh Sengupta
>> ------------------------------------------------------------------------
>> *From:* Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> *Sent:* Tuesday, February 25, 2025 6:29:44 AM
>> *To:* Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Paolo Bonzini
>> <pbonzini@redhat.com>; Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>> *Cc:* amir.gonnen@neuroblade.ai <amir.gonnen@neuroblade.ai>; qemu-
>> devel@nongnu.org <qemu-devel@nongnu.org>; Saanjh Sengupta
>> <saanjhsengupta@outlook.com>
>> *Subject:* Re: Building QEMU as a Shared Library
>> Hi Saanjh,
>>
>> here is a minimal patch that builds one shared library per target (arch,
>> mode) where arch is cpu arch, and mode is system or user, and launch
>> system-aarch64 through a simple driver:
>>
>> https://github.com/pbo-linaro/qemu/commit/ <https://github.com/pbo-
> linaro/qemu/commit/>
>> fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f <https://github.com/pbo-linaro/
>> qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f>
>>
>> With this, it could be possible to create a driver that can execute any
>> existing target. It's a sort of single binary for QEMU, but shared
>> objects are mandatory, and duplicates all the QEMU state. So there is no
>> real benefit compared to having different processes.
>>
>> In more, to be able to do concurrent emulations, there are much more
>> problems to be solved. QEMU state is correctly kept per target, but all
>> other libraries states are shared. There are various issues if you
>> launch two emulations at the same time in two threads:
>> - glib global context
>> - qemu calls exit in many places, which stops the whole process
>> - probably other things I didn't explore
>>
>> At this point, even though qemu targets can be built as shared objects,
>> I would recommend to use different processes, and implement some form on
>> IPC to synchronize all this.
>> Another possibility is to try to build machines without using the
>> existing main, but I'm not sure it's worth all the hassle.
>>
>> What are you trying to achieve?
>>
>> Regards,
>> Pierrick
>>
>> On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:
>>> Cc'ing our meson experts
>>>
>>> On 22/2/25 14:36, Saanjh Sengupta wrote:
>>>> Hi,
>>>>
>>>> I referred to your mailing chains on suggesting QEMU to be built as a
>>>> shared library.
>>>>
>>>> *Change meson.build to build QEMU as a shared library (with PIC enable=
d
>>>> for static libraries)*
>>>> *
>>>> *
>>>> Could you please suggest what exactly has to be enabled in the meson.b=
uild?
>>>>
>>>> I am confused on that front.
>>>>
>>>> Regards
>>>> Saanjh Sengupta
>>>
>>
>


--_000_SL2P216MB1380316B32539524D1CCD831CCD02SL2P216MB1380KORP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto">Hi,</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Thank you for the clarification. Regarding the last time<=
/div>
<div dir=3D"auto"><i>&quot;Stoptrigger might be a better fit for what you w=
ant to do, and instead of exiting, you want to resume emulation after N ins=
n. The function qemu_clock_advance_virtual_time() can only be used to move =
the time forward, and you can not stop
 the &quot;virtual time&quot; by design.&quot;</i></div>
<div dir=3D"auto"><i><br>
</i></div>
<div dir=3D"auto">I did not quite understand this. Even if I have to modify=
 the stopTrigger plugin, I would want it to pause rather than exiting.&nbsp=
;</div>
<div dir=3D"auto">For example: It gets 10000 instructions executed after th=
at it should pause and after some time it should then resume again execute =
till 20000 instructions (because previously it executed till 10000 and then=
 it must execute till 20000). How
 do I do this? How do I state the code to pause the qemu's emulation after =
10000 instructions?&nbsp;</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Moreover, I tried an activity where I was utilising the Q=
MP protocol to control the virtual time (with respect to the IPS plugin). I=
n that context when the QMP stop is triggered, my virtual time does got fre=
ezed until the resume is triggered.
 Does this mean I am able to manipulate the virtual time of the QEMU?&nbsp;=
</div>
<div dir=3D"auto"><br>
</div>
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
<b>Sent:</b> Wednesday, March 12, 2025 2:14:47 AM<br>
<b>To:</b> Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;; Philippe Mat=
hieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzini@redhat.c=
om&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<br>
<b>Cc:</b> amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e &lt;alex.be=
nnee@linaro.org&gt;<br>
<b>Subject:</b> Re: Building QEMU as a Shared Library</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 3/11/25 02:50, Saanjh Sengupta wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I have a couple of questions:<br>
&gt; <br>
&gt;&nbsp; 1.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; When I use the libstoptrigger.so: in that case=
 the QEMU 's emulation<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; stops after executing the defined number of in=
structions. Post this,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; the whole QEMU terminates. And while using the=
 libips.so I am<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; assuming that the QEMU doesn't execute no more=
 than the defined<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; instructions. Please correct me if I am wrong.=
<br>
<br>
That's correct for both plugins, with the additional note that libips <br>
does this per second only.<br>
<br>
&gt;&nbsp; 2.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; In my case, I want the QEMU to start emulation=
 for some time and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; PAUSE it's emulation for some time; after it i=
s Paused (it's virtual<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; time is also to be paused) and then let's say =
for after 'x' time<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; period it should resume it's virtual time.<br>
&gt; <br>
<br>
The virtual time variable in ips plugin is only related to this plugin, <br=
>
and based on how many instructions have been executed, which is <br>
different from what you want to achieve.<br>
<br>
Stoptrigger might be a better fit for what you want to do, and instead <br>
of exiting, you want to resume emulation after N insn.<br>
The function qemu_clock_advance_virtual_time() can only be used to move <br=
>
the time forward, and you can not stop the &quot;virtual time&quot; by desi=
gn.<br>
<br>
&gt; image<br>
&gt; <br>
&gt; <br>
&gt; I have added this segment inside the update_system_time function insid=
e <br>
&gt; the ipsPlugin.c. but once the instructions reach to the defined limit =
<br>
&gt; the virtual time does not seem to stop.<br>
&gt; Do you have any suggestions on that front?<br>
&gt; <br>
&gt; <br>
&gt; Regards<br>
&gt; Saanjh Sengupta<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
&gt; *Sent:* Wednesday, March 5, 2025 5:20:38 AM<br>
&gt; *To:* Saanjh Sengupta &lt;saanjhsengupta@outlook.com&gt;; Philippe Mat=
hieu- <br>
&gt; Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bonzini &lt;pbonzini@redhat.c=
om&gt;; Marc- <br>
&gt; Andr=E9 Lureau &lt;marcandre.lureau@redhat.com&gt;<br>
&gt; *Cc:* amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;; qem=
u- <br>
&gt; devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Alex Benn=E9e <br>
&gt; &lt;alex.bennee@linaro.org&gt;<br>
&gt; *Subject:* Re: Building QEMU as a Shared Library<br>
&gt; Hi Saanjh,<br>
&gt; <br>
&gt; depending what you are trying to achieve exactly, plugins can provide =
a<br>
&gt; solution. It's convenient and you can stay on top of QEMU upstream,<br=
>
&gt; without having to create a downstream fork.<br>
&gt; <br>
&gt; We already have plugins for stopping after a given number of<br>
&gt; instructions, or slow down execution of a VM:<br>
&gt; <br>
&gt; # stop after executing 1'000'000 instructions:<br>
&gt; $ ./build/qemu-system-x86_64 -plugin<br>
&gt; ./build/contrib/plugins/libstoptrigger,icount=3D1000000 -d plugin<br>
&gt; <br>
&gt; # execute no more than 1'000'000 instructions per second:<br>
&gt; $ ./build/qemu-system-x86_64 -plugin<br>
&gt; ./build/contrib/plugins/libips.so,ips=3D1000000 -d plugin<br>
&gt; <br>
&gt; You can see source code associated (./contrib/plugins/stoptrigger.c an=
d<br>
&gt; ./contrib/plugins/ips.c), to implement something similar to what you<b=
r>
&gt; want, but based on time.<br>
&gt; Would that satisfy your need?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Pierrick<br>
&gt; <br>
&gt; On 3/3/25 21:53, Saanjh Sengupta wrote:<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; Hi,<br>
&gt;&gt; <br>
&gt;&gt; Thank you so much for your inputs. I was able to create the .so fi=
le of <br>
&gt;&gt; QEMU.<br>
&gt;&gt; <br>
&gt;&gt; Actually, what we are trying is to understand and explore possibil=
ities <br>
&gt;&gt; of Virtual Time Control in QEMU. In short, what I mean to say is a=
n <br>
&gt;&gt; approach via which I can tell QEMU to emulate for XYZ time when th=
e I <br>
&gt;&gt; give a trigger and then pause the emulation by itself after the XY=
Z time <br>
&gt;&gt; is completed.<br>
&gt;&gt; <br>
&gt;&gt; On that front itself, do you have any inputs/ideas regarding the s=
ame?<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; Regards<br>
&gt;&gt; Saanjh Sengupta<br>
&gt;&gt; ------------------------------------------------------------------=
------<br>
&gt;&gt; *From:* Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;<br>
&gt;&gt; *Sent:* Tuesday, February 25, 2025 6:29:44 AM<br>
&gt;&gt; *To:* Philippe Mathieu-Daud=E9 &lt;philmd@linaro.org&gt;; Paolo Bo=
nzini <br>
&gt;&gt; &lt;pbonzini@redhat.com&gt;; Marc-Andr=E9 Lureau &lt;marcandre.lur=
eau@redhat.com&gt;<br>
&gt;&gt; *Cc:* amir.gonnen@neuroblade.ai &lt;amir.gonnen@neuroblade.ai&gt;;=
 qemu- <br>
&gt;&gt; devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Saanjh Sengupta <b=
r>
&gt;&gt; &lt;saanjhsengupta@outlook.com&gt;<br>
&gt;&gt; *Subject:* Re: Building QEMU as a Shared Library<br>
&gt;&gt; Hi Saanjh,<br>
&gt;&gt; <br>
&gt;&gt; here is a minimal patch that builds one shared library per target =
(arch,<br>
&gt;&gt; mode) where arch is cpu arch, and mode is system or user, and laun=
ch<br>
&gt;&gt; system-aarch64 through a simple driver:<br>
&gt;&gt; <br>
&gt;&gt; <a href=3D"https://github.com/pbo-linaro/qemu/commit/">https://git=
hub.com/pbo-linaro/qemu/commit/</a> &lt;<a href=3D""></a>https://github.com=
/pbo-
<br>
&gt; linaro/qemu/commit/&gt;<br>
&gt;&gt; fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f &lt;<a href=3D""></a>http=
s://github.com/pbo-linaro/<br>
&gt;&gt; qemu/commit/fbb39cc64f77d4bf1e5e50795c75b62735bf5c5f&gt;<br>
&gt;&gt; <br>
&gt;&gt; With this, it could be possible to create a driver that can execut=
e any<br>
&gt;&gt; existing target. It's a sort of single binary for QEMU, but shared=
<br>
&gt;&gt; objects are mandatory, and duplicates all the QEMU state. So there=
 is no<br>
&gt;&gt; real benefit compared to having different processes.<br>
&gt;&gt; <br>
&gt;&gt; In more, to be able to do concurrent emulations, there are much mo=
re<br>
&gt;&gt; problems to be solved. QEMU state is correctly kept per target, bu=
t all<br>
&gt;&gt; other libraries states are shared. There are various issues if you=
<br>
&gt;&gt; launch two emulations at the same time in two threads:<br>
&gt;&gt; - glib global context<br>
&gt;&gt; - qemu calls exit in many places, which stops the whole process<br=
>
&gt;&gt; - probably other things I didn't explore<br>
&gt;&gt; <br>
&gt;&gt; At this point, even though qemu targets can be built as shared obj=
ects,<br>
&gt;&gt; I would recommend to use different processes, and implement some f=
orm on<br>
&gt;&gt; IPC to synchronize all this.<br>
&gt;&gt; Another possibility is to try to build machines without using the<=
br>
&gt;&gt; existing main, but I'm not sure it's worth all the hassle.<br>
&gt;&gt; <br>
&gt;&gt; What are you trying to achieve?<br>
&gt;&gt; <br>
&gt;&gt; Regards,<br>
&gt;&gt; Pierrick<br>
&gt;&gt; <br>
&gt;&gt; On 2/24/25 01:10, Philippe Mathieu-Daud=E9 wrote:<br>
&gt;&gt;&gt; Cc'ing our meson experts<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; On 22/2/25 14:36, Saanjh Sengupta wrote:<br>
&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I referred to your mailing chains on suggesting QEMU to be=
 built as a<br>
&gt;&gt;&gt;&gt; shared library.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; *Change meson.build to build QEMU as a shared library (wit=
h PIC enabled<br>
&gt;&gt;&gt;&gt; for static libraries)*<br>
&gt;&gt;&gt;&gt; *<br>
&gt;&gt;&gt;&gt; *<br>
&gt;&gt;&gt;&gt; Could you please suggest what exactly has to be enabled in=
 the meson.build?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I am confused on that front.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; Saanjh Sengupta<br>
&gt;&gt;&gt; <br>
&gt;&gt; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SL2P216MB1380316B32539524D1CCD831CCD02SL2P216MB1380KORP_--

