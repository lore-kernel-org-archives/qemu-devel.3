Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64737FF60EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Uvq-0005AX-Rk; Tue, 31 Mar 2026 04:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w7Uvp-0005A7-8z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:58:41 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w7Uvn-0000Tf-6b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774947512; x=1775552312; i=deller@gmx.de;
 bh=1azJMBt6jCRF7f9STNUU0YKLMhnYr9IqAJoagT55B8k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=q9glactbe+t8G41qKEHxTOIu1layT4R3e4ENBLxM1Pk4GOGArjmA6hTjNJrj23Wf
 7/JyrrkQ8J475Q1djVtfjAjKxsg8xPGNdKeWsRtxr3Q5hudqzDpfmQRL7tOQ+tuCt
 avBSaiNn46tC9m4S+G3LchCU774REUC/0iNjs+7vIiuqLtdpRdv6eXtxn20f4L9Xj
 8acrwN14AQdNbMUKTJcsrh+2PSexN9VMLBiwwDYVJc6z6P4EXNbTglJ4jvs3cREHh
 Wz6UP8CN44lFF3WVUB2s9uhJuQxk5uddOGubcQlzc4+sVZdxkRYtQIRDLZkYpi+SN
 fKIx1tqFuzk6sINTcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1wAFoU0k5m-00GsPd; Tue, 31
 Mar 2026 10:58:32 +0200
Message-ID: <0634a5f1-7f98-4905-b5a4-394d5cfec3a3@gmx.de>
Date: Tue, 31 Mar 2026 10:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/hppa: Disable Artist graphics card on 64-bit
 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-3-deller@kernel.org>
 <04942b9e-ed2f-4553-b4c7-73d5499f342a@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <04942b9e-ed2f-4553-b4c7-73d5499f342a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wtDQdCMTr6aBS7ltPCaD6TuFnlZ5zIA7nD/ibvaFh2aRiHoOWvR
 9EWA+ix68DgFrKHR12SyTsduTrxI9Jcz3DT5SqkPdejc3ETZBNl9j+Im+uxS6dE2kx7Lt52
 uMMaWjOA6eFDzHhFhOMEAiJk+qyrRbby8M29AK9DBeJiQEI8ptAU98Bqd6LuAgQJHyezsAr
 SkVS3/fke5QlGBmMR6kTQ==
UI-OutboundReport: notjunk:1;M01:P0:XYEMQ2bMWWI=;1qIqA7fk/ajf33/aGnLUjn/OTOm
 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
 SL
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/30/26 23:42, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/3/26 23:18, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The original Artist graphics used the GSC bus, was often installed in o=
ld
>> 32-bit machines (e.g. 715) and can not be used on 64-bit machines.
>> This is why this patch makes the artist driver dependend on the Lasi ch=
ip,
>> which was never used in a 64-bit machine.
>>
>> Note that there exists a variant of Artist for the PCI-bus (Visualize-E=
G PCI).
>> It has quite some differences in the registers, and would require that =
we write
>> a PCI ROM for it, so that Linux and HP-UX would be able to use it.
>>
>> Instead, for now, users can simply use a standard VGA or ATI PCI graphi=
cs card
>> on Linux.=C2=A0 This can be enabled on the command line with "-device a=
ti-vga" or
>> "-device VGA".=C2=A0 If the "-nographic" option is omitted, a PCI OCHI =
controller
>> with USB keyboard and USB mouse will be added automatically.
>>
>> This fixes graphics support on 64-bit hppa machines and allows us to bo=
ot up a
>> 64-bit Linux installation with VGA graphics.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 hw/hppa/machine.c | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 3663bac53b..58e76bee2e 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -384,7 +384,8 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Graphics setup. */
>> -=C2=A0=C2=A0=C2=A0 if (machine->enable_graphics && vga_interface_type =
!=3D VGA_NONE) {
>> +=C2=A0=C2=A0=C2=A0 if (lasi_dev && machine->enable_graphics &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_interface_type !=3D VGA=
_NONE) {
>=20
> Pre-existing, 'lasi_dev' being a static variable isn't really helpful.

Yes, can be done post-v11.
Where would it belong? Into MachineState?

> Back to this patch:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!
 =20
> Although a distinct descriptive boolean variable could be used
> instead for clarity, rather than testing LASI presence.

Helge

