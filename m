Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99665C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7DK-0007lb-U5; Tue, 07 Jul 2026 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wh7D0-0007fh-VS; Tue, 07 Jul 2026 10:55:41 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wh7Cy-0004Gz-Qd; Tue, 07 Jul 2026 10:55:38 -0400
Received: from [192.168.25.24] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 659512003E3;
 Tue,  7 Jul 2026 16:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783436124;
 bh=XTZikrCYTnWpn3XimM/NidLp1i4dOflk4theZvvY9qM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ojYYa+o1aTch/qk5uiCPkra2j+gfronSHB3S09I8HpDPGVN8TDykThejXhUjBOOiu
 UAo232huk21SOxpkxtyIGW+IkkYvQi/RxYK/M7nsKy5ZFm/2fD6WQKKMvy6Ve1OgP5
 Atot8+cV3HFhP13aqzW8IdV1PYFheLQmLO6+0+TwxD+BkSayURBWl7qYpivUxethFl
 A/QhvwjmVUFecklRjInS36dEeltgJoEahKPwhqFexQY8om/cJvsGJAcEqArDCxCqI1
 Xlnnlnfy/k/czpq8mX/ovvEyzti5i+IfwSV1BeOAkVDC4cWA1nSPhKziqjSXh+yf2q
 9LVD6846Hd2vA==
From: emmanuel.blot@free.fr
To: alexander.hansen@9elements.com
Cc: qemu-devel@nongnu.org, eblot@meta.com, titusr@google.com, clg@kaod.org,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v7 4/4] hw/sensor: support MAX11615
Date: Tue, 07 Jul 2026 16:55:11 +0200
X-Mailer: MailMate (2.0r6290)
Message-ID: <5EC00F06-D9B3-47D7-9C39-F3F693EE3A7C@free.fr>
In-Reply-To: <20260619115533.5664-5-alexander.hansen@9elements.com>
References: <20260619115533.5664-1-alexander.hansen@9elements.com>
 <20260619115533.5664-5-alexander.hansen@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_94164AD7-A666-438A-8FB3-C526E18FAF21_="
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


--=_MailMate_94164AD7-A666-438A-8FB3-C526E18FAF21_=
Content-Type: text/plain; charset=UTF-8; format=flowed; markup=markdown
Content-Transfer-Encoding: 8bit



On 19 Jun 2026, at 13:55, alexander.hansen@9elements.com wrote:

> From: Alexander Hansen <alexander.hansen@9elements.com>

> diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c
> new file mode 100644
> index 0000000000..ac2ccda4fa
> --- /dev/null
> +++ b/hw/sensor/max11615.c

Would it make sense to call it max1161x.c and create a specific version 
for the 8-channel version?
It seems Analog Devices produces MAX 11612 .. 11617 which mostly vary 
with the input channel count, so your driver could later be extended to 
support the 4- and 12- channel version. This would avoid being stuck 
with a specific model in its name, as it is unfortunately the case with 
several I2C emulated device in QEMU such as PCA9552, PCA9554, …

> +#include "qapi/visitor.h"
I think this file inclusion is not needed.

> +struct MAX11615Class {
> +    I2CSlaveClass parent_class;
> +};
> +
> +OBJECT_DECLARE_TYPE(MAX11615State, MAX11615Class, MAX11615)

Maybe stick with the I2CSlaveClass as no feature is added here, with
OBJECT_DECLARE_TYPED_SIMPLE(MAX11615State, MAX11615)

If you opt-in for a multi-channel implementation (MAX1161x), this does 
not apply, as the class should contain the number of ADC channels, 
initialized for the MAX11615 version with MAX11615_NUM_CHANNELS.

> +static int16_t max11615_differential_value(MAX11615State *s)
> +{
> +    /* Table 4. Channel Selection in Differential Mode */
> +    size_t i1 = s->pointer;
> +    size_t i2 = (s->pointer % 2 == 0) ? s->pointer + 1 : s->pointer - 
> 1;
> +
> +    const int16_t ch1 = s->channels[i1];
> +    const int16_t ch2 = s->channels[i2];
> +    return ch1 - ch2;
> +}

Maybe const MAX11615State *s

> +static void max11615_write_config_byte(MAX11615State *s, uint8_t 
> data)
> +{
> +    trace_max11615_write_config(s->i2c.address, data);
> +
> +    uint8_t scan_select = (data >> 5) & 0x3;
> +
> +    if (scan_select != 0x3) {
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented scan select\n", 
> __func__);
> +    }
> +
> +    uint8_t channel_select = (data >> 1) & 0xf;
> +
> +    /* Table 3. Channel Selection */
> +    if (channel_select >= MAX11615_NUM_CHANNELS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel 
> select\n",
> +                      __func__);
> +        channel_select = MAX11615_NUM_CHANNELS - 1;
> +    }
> +    s->pointer = channel_select;
> +    s->single_ended = data & 0x1;
> +}

I’m not sure about the invalid channel management. The datasheet 
specifies:
“For the MAX11615, CS3 is internally set to 0”.
My understanding is that channel_select is therefore masked with 
MAX11615_NUM_CHANNELS - 1 here, not 0xf;
the actual selected channel is wrapped rather than been maxed.

BTW a nice addition - for a future update, I do not think it is worth 
changing it now - would be to use the registerfields.h macros, it would 
make the code more readable as hardcoded mask & shift would be managed.

> +I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t address,
> +                                    const uint16_t *init_values,
> +                                    uint32_t init_values_size)
> +{
> +    MAX11615State *s;
> +
> +    s = MAX11615(i2c_slave_new(TYPE_MAX11615, address));
> +
> +    i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &error_abort);
> +
> +    for (int i = 0; i < MAX11615_NUM_CHANNELS; i++) {
> +        /* arbitrary value if there is no data*/
> +        s->channels[i] = i < init_values_size ? init_values[i] : 
> 0x2d2;
> +    }
> +
> +    return I2C_SLAVE(s);
> +}

max11615_reset_enter is called once the device is realized, overriding 
those values with the default reset ones. I’m not sure to understand 
how this function can be used.
I think it would be more flexible to use QOM properties rather than a 
custom dedicated function to initialize default values.

> +
> +static void max11615_reset_enter(MAX11615State *s)
> +{
> +    trace_max11615_reset_enter(s->i2c.address);
> +
> +    s->single_ended = true;
> +    s->bipolar = false;
> +    s->vref = 2048;
> +    s->pointer = 0;
> +    s->outlen = 0;
> +
> +    for (int i = 0; i < MAX11615_NUM_CHANNELS; i++) {
> +        s->channels[i] = 0x2d2;
> +    }
> +}
> +
> +static void max11615_reset(Object *obj, ResetType type)
> +{
> +    MAX11615State *s = MAX11615(obj);
> +
> +    max11615_reset_enter(s);
> +}

I tend to think it should be the opposite call logic:
- max11615_reset should be called max11615_reset_hold as per
   rc->phases.hold = max11615_reset;
- max11615_reset_hold should call max11615_reset
- max11615_reset should initialize the default values
- max11615_reset should also be called from write to SETUP./rst (hence 
the need for two reset functions)


--=_MailMate_94164AD7-A666-438A-8FB3-C526E18FAF21_=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8"=
>
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" sty=
le=3D"white-space: normal;">
<p dir=3D"auto">On 19 Jun 2026, at 13:55, <a href=3D"mailto:alexander.han=
sen@9elements.com" style=3D"color: #3983C4;">alexander.hansen@9elements.c=
om</a> wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">From: Alexander Hansen <a href=3D"mailto:alexander.hansen=
@9elements.com" style=3D"color: #777777;">alexander.hansen@9elements.com<=
/a></p>
</blockquote>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">diff --git a/hw/sensor/max11615.c b/hw/sensor/max11615.c<=
br>
new file mode 100644<br>
index 0000000000..ac2ccda4fa<br>
--- /dev/null<br>
+++ b/hw/sensor/max11615.c</p>
</blockquote>
<p dir=3D"auto">Would it make sense to call it max1161x.c and create a sp=
ecific version for the 8-channel version?<br>
It seems Analog Devices produces MAX 11612 .. 11617 which mostly vary wit=
h the input channel count, so your driver could later be extended to supp=
ort the 4- and 12- channel version. This would avoid being stuck with a s=
pecific model in its name, as it is unfortunately the case with several I=
2C emulated device in QEMU such as PCA9552, PCA9554, =E2=80=A6</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+#include &quot;qapi/visitor.h&quot;</p>
</blockquote>
<p dir=3D"auto">I think this file inclusion is not needed.</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+struct MAX11615Class {</p>
<ul>
<li>I2CSlaveClass parent_class;</li>
</ul>
<p dir=3D"auto">+};<br>
+<br>
+OBJECT_DECLARE_TYPE(MAX11615State, MAX11615Class, MAX11615)</p>
</blockquote>
<p dir=3D"auto">Maybe stick with the I2CSlaveClass as no feature is added=
 here, with<br>
OBJECT_DECLARE_TYPED_SIMPLE(MAX11615State, MAX11615)</p>
<p dir=3D"auto">If you opt-in for a multi-channel implementation (MAX1161=
x), this does not apply, as the class should contain the number of ADC ch=
annels, initialized for the MAX11615 version with MAX11615_NUM_CHANNELS.<=
/p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+static int16_t max11615_differential_value(MAX11615State=
 *s)<br>
+{</p>
<ul>
<li>/* Table 4. Channel Selection in Differential Mode */</li>
<li>size_t i1 =3D s-&gt;pointer;</li>
<li>size_t i2 =3D (s-&gt;pointer % 2 =3D=3D 0) ? s-&gt;pointer + 1 : s-&g=
t;pointer - 1;</li>
<li></li>
<li>const int16_t ch1 =3D s-&gt;channels[i1];</li>
<li>const int16_t ch2 =3D s-&gt;channels[i2];</li>
<li>return ch1 - ch2;</li>
</ul>
<p dir=3D"auto">+}</p>
</blockquote>
<p dir=3D"auto">Maybe const MAX11615State *s</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+static void max11615_write_config_byte(MAX11615State *s,=
 uint8_t data)<br>
+{</p>
<ul>
<li>trace_max11615_write_config(s-&gt;i2c.address, data);</li>
<li></li>
<li>uint8_t scan_select =3D (data &gt;&gt; 5) &amp; 0x3;</li>
<li></li>
<li>if (scan_select !=3D 0x3) {</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">   qemu_log_mask(LOG_UNIMP, &quot;%s: un=
implemented scan select\n&quot;, __func__);
</code></pre>
</li>
<li>}</li>
<li></li>
<li>uint8_t channel_select =3D (data &gt;&gt; 1) &amp; 0xf;</li>
<li></li>
<li>/* Table 3. Channel Selection */</li>
<li>if (channel_select &gt;=3D MAX11615_NUM_CHANNELS) {</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">   qemu_log_mask(LOG_GUEST_ERROR, &quot;=
%s: invalid channel select\n&quot;,
</code></pre>
</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">                 __func__);
</code></pre>
</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">   channel_select =3D MAX11615_NUM_CHANN=
ELS - 1;
</code></pre>
</li>
<li>}</li>
<li>s-&gt;pointer =3D channel_select;</li>
<li>s-&gt;single_ended =3D data &amp; 0x1;</li>
</ul>
<p dir=3D"auto">+}</p>
</blockquote>
<p dir=3D"auto">I=E2=80=99m not sure about the invalid channel management=
=2E The datasheet specifies:<br>
=E2=80=9CFor the MAX11615, CS3 is internally set to 0=E2=80=9D.<br>
My understanding is that channel_select is therefore masked with MAX11615=
_NUM_CHANNELS - 1 here, not 0xf;<br>
the actual selected channel is wrapped rather than been maxed.</p>
<p dir=3D"auto">BTW a nice addition - for a future update, I do not think=
 it is worth changing it now - would be to use the registerfields.h macro=
s, it would make the code more readable as hardcoded mask &amp; shift wou=
ld be managed.</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<p dir=3D"auto">+I2CSlave *max11615_init_with_values(I2CBus *bus, uint8_t=
 address,</p>
<ul>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">                               const uin=
t16_t *init_values,
</code></pre>
</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">                               uint32_t =
init_values_size)
</code></pre>
</li>
</ul>
<p dir=3D"auto">+{</p>
<ul>
<li>MAX11615State *s;</li>
<li></li>
<li>s =3D MAX11615(i2c_slave_new(TYPE_MAX11615, address));</li>
<li></li>
<li>i2c_slave_realize_and_unref(I2C_SLAVE(s), bus, &amp;error_abort);</li=
>
<li></li>
<li>for (int i =3D 0; i &lt; MAX11615_NUM_CHANNELS; i++) {</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">   /* arbitrary value if there is no dat=
a*/
</code></pre>
</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">   s-&gt;channels[i] =3D i &lt; init_val=
ues_size ? init_values[i] : 0x2d2;
</code></pre>
</li>
<li>}</li>
<li></li>
<li>return I2C_SLAVE(s);</li>
</ul>
<p dir=3D"auto">+}</p>
</blockquote>
<p dir=3D"auto">max11615_reset_enter is called once the device is realize=
d, overriding those values with the default reset ones. I=E2=80=99m not s=
ure to understand how this function can be used.<br>
I think it would be more flexible to use QOM properties rather than a cus=
tom dedicated function to initialize default values.</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px=
 solid #777777; color: #777777;">
<ul>
<li></li>
</ul>
<p dir=3D"auto">+static void max11615_reset_enter(MAX11615State *s)<br>
+{</p>
<ul>
<li>trace_max11615_reset_enter(s-&gt;i2c.address);</li>
<li></li>
<li>s-&gt;single_ended =3D true;</li>
<li>s-&gt;bipolar =3D false;</li>
<li>s-&gt;vref =3D 2048;</li>
<li>s-&gt;pointer =3D 0;</li>
<li>s-&gt;outlen =3D 0;</li>
<li></li>
<li>for (int i =3D 0; i &lt; MAX11615_NUM_CHANNELS; i++) {</li>
<li>
<pre style=3D"margin-left: 15px; margin-right: 15px; padding: 5px; backgr=
ound-color: #F7F7F7; border-radius: 5px 5px 5px 5px; overflow-x: auto; ma=
x-width: 90vw;"><code style=3D"margin: 0 0; border-radius: 3px; backgroun=
d-color: #F7F7F7; padding: 0px;">   s-&gt;channels[i] =3D 0x2d2;
</code></pre>
</li>
<li>}</li>
</ul>
<p dir=3D"auto">+}<br>
+<br>
+static void max11615_reset(Object *obj, ResetType type)<br>
+{</p>
<ul>
<li>MAX11615State *s =3D MAX11615(obj);</li>
<li></li>
<li>max11615_reset_enter(s);</li>
</ul>
<p dir=3D"auto">+}</p>
</blockquote>
<p dir=3D"auto">I tend to think it should be the opposite call logic:</p>=

<ul>
<li>max11615_reset should be called max11615_reset_hold as per<br>
rc-&gt;phases.hold =3D max11615_reset;</li>
<li>max11615_reset_hold should call max11615_reset</li>
<li>max11615_reset should initialize the default values</li>
<li>max11615_reset should also be called from write to SETUP./rst (hence =
the need for two reset functions)</li>
</ul>

</div>
</div>
</body>

</html>

--=_MailMate_94164AD7-A666-438A-8FB3-C526E18FAF21_=--

