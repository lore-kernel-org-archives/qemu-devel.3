Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7715E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 22:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMEWK-00009n-RF; Fri, 13 Dec 2024 17:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tMEVp-00006c-BK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 17:51:58 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tMEVj-0008NI-Vs
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 17:51:56 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a814c54742so15095ab.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734130309; x=1734735109; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngsKVFtrwUaMQDbHR+shwHXvRbxFfsK5MGPC0fuCMIo=;
 b=PU5ICTPkvPU0KqkHHFVKXyk9z3O++zkZqXaId6A6aIiTMqRfovQqmyBkSRe58ojpO1
 2WX7ABVDfVWKpiFS4e+buLIviVlYtGu7Culov07pWgQAPHjT/WLMwxrOtAjDfsRlrloL
 vaOYOwSRBPnGheVEERVwGn3g+xrsUW6zGkoi9VdhKIuKwPYzdRBEGOO4Ak3ax0lLSuh4
 On+Ejsd9CGbeK9706TurBZRBIDcUafQYgOINV3NVEDmYs3ETEvEy+nZbWPxF9tqFj35o
 WORGyovKAlemvz1vPS/wg6W9jNi+e2UMJQp4C+YPvDqzdFE2LDYgPZG7UkGXwSR29pnD
 iNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734130309; x=1734735109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngsKVFtrwUaMQDbHR+shwHXvRbxFfsK5MGPC0fuCMIo=;
 b=UK3hCP6l49KIF4ptzWC2XS6r82AxdUoLuxIBvBpievEKz1HYrP9bIspi0y3sKZ+vd0
 8ILfgRBdQHnnHN51If4XkKUvq4opTifWD1TXeM8QW1Ox8cYVKrcmP/k8cAzO0mCmOOEt
 wS0Zwp1TeWFjsR78XufdQwHW8TsFRnfI1Otdseme2X2lkewzZFVCt2ycIGQmJtRzLcX1
 oAqxqcDYdzLHqREA7GsfhbTjSMgz7pSd92Yd9+ucdsx92tFf1dwVp41CP1tFaCxntJ97
 OgQlevd7LddUnTeO3idLVzEFCBIYvx3cs45+zCSn3NlVW6eA6XwlW2vJNXEvx4j26QaH
 oLFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9j5rJyamddAjRfHbvIpYoIM3AxDrWKpXY6YOXv7VWNBFGhy+pGXuskizq1+Xynpqx4/g4mLGeH1c9@nongnu.org
X-Gm-Message-State: AOJu0YzAgEYFrmGh78fXI/V+MNn/n5XoTIriDn2Bd5QgXGT7dln+LGU6
 X7+Lq5rjQ5VYs4i6YLlMrNv73OCSnq6+rbgWtEUWenVCyyJTMSi8TpPEMFIiJRGg2/mXpVeiYFX
 BR0hy4tpagEWouncn38vNKnc65w1sqRzS7ibo
X-Gm-Gg: ASbGncu2WTVNUOonXQaRde8lY3R+2Syar60I+BLUa/iioaN44//3LN7O1eeOMFHjmf6
 8BDtmAdHPJ15UbR3tUWgnh/KULyyH9WrQbZsd26pKYonTq46nhje2BozXegn3udZcsrAQ
X-Google-Smtp-Source: AGHT+IENLvj/uUjPeXlOIOScoOmwRjDjwiYzY++iWlkqgjfAHXnigUbhwvksFAufVItfMs3pWHB/MlCwunr23YzcsxU=
X-Received: by 2002:a92:c002:0:b0:3a0:a34e:9ab1 with SMTP id
 e9e14a558f8ab-3b26f4f85e6mr855245ab.8.1734130309323; Fri, 13 Dec 2024
 14:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20241213224020.2982578-1-nabihestefan@google.com>
In-Reply-To: <20241213224020.2982578-1-nabihestefan@google.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Fri, 13 Dec 2024 14:51:37 -0800
Message-ID: <CA+QoejVFqA5vL7kLQ69-Z=y8i6jEjRTPWTZKB078E3+cbSZZ8Q@mail.gmail.com>
Subject: Re: [PATCH v2] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Some of the info I was asked for in V1 of the patch:

I'm seeing the failure on 2 different machines, the compiler versions are:
- gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
- gcc version 14.2.0 (Debian 14.2.0-3+build3)

Both of the outputs below are run on the Debian machine.
Output of the command at a5ba0a7e4 (without this patch):
$ QTEST_LOG=3D1 QTEST_TRACE=3D"sse_*" QTEST_QEMU_BINARY=3D./qemu-system-arm
./tests/qtest/sse-timer-test
TAP version 14
# random seed: R02Sef41cebd370ee89bac17cc72a839670c
# starting QEMU: exec ./qemu-system-arm -trace sse_* -qtest
unix:/tmp/qtest-3006002.sock -qtest-log /dev/fd/2 -chardev
socket,path=3D/tmp/qtest-3006002.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine
mps3-an547 -accel qtest
[I 0.000000] OPENED
sse_timer_reset SSE system timer: reset
sse_timer_reset SSE system timer: reset
sse_timer_reset SSE system timer: reset
sse_timer_reset SSE system timer: reset
sse_counter_reset SSE system counter: reset
[R +0.024763] endianness
[S +0.024774] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
"package": "v9.2.0-28-ga5ba0a7e4e"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
1..3
# Start of arm tests
# Start of sse-timer tests
[R +0.026195] writel 0x58100000 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x0 size 4
[S +0.026216] OK
[R +0.026240] writel 0x4800002c 0x0
[S +0.026247] OK
[R +0.026263] writel 0x4800004c 0x0
[S +0.026268] OK
[R +0.026284] writel 0x58100008 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x8 data 0x0 size 4
[S +0.026294] OK
[R +0.026309] writel 0x5810000c 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0xc data 0x0 size 4
[S +0.026316] OK
[R +0.026331] clock_step 3125
[S +0.026340] OK 0
[R +0.026356] readl 0x58100008
sse_counter_control_read SSE system counter control frame read: offset
0x8 data 0x0 size 4
[S +0.026366] OK 0x0000000000000000
[R +0.026381] readl 0x5810000c
sse_counter_control_read SSE system counter control frame read: offset
0xc data 0x0 size 4
[S +0.026388] OK 0x0000000000000000
[R +0.026404] writel 0x58100000 0x1
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x1 size 4
[S +0.026412] OK
[R +0.026428] clock_step 3125
[S +0.026437] OK 0
[R +0.026453] readl 0x58100008
sse_counter_control_read SSE system counter control frame read: offset
0x8 data 0x0 size 4
[S +0.026461] OK 0x0000000000000000
**
ERROR:../tests/qtest/sse-timer-test.c:91:test_counter: assertion
failed (readl(COUNTER_BASE + CNTCV_LO) =3D=3D 100): (0 =3D=3D 100)
not ok /arm/sse-timer/counter -
ERROR:../tests/qtest/sse-timer-test.c:91:test_counter: assertion
failed (readl(COUNTER_BASE + CNTCV_LO) =3D=3D 100): (0 =3D=3D 100)
Bail out!
[I +0.026730] CLOSED
Aborted


Output of the command at a5ba0a7e4+this patch:
$ QTEST_LOG=3D1 QTEST_TRACE=3D"sse_*" QTEST_QEMU_BINARY=3D./qemu-system-arm
./tests/qtest/sse-timer-test
TAP version 14
# random seed: R02Sfe7ced06933a483e656b6313bfe47a7d
# starting QEMU: exec ./qemu-system-arm -trace sse_* -qtest
unix:/tmp/qtest-2909753.sock -qtest-log /dev/fd/2 -chardev
socket,path=3D/tmp/qtest-2909753.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine
mps3-an547 -accel qtest
[I 0.000000] OPENED
sse_timer_reset SSE system timer: reset
sse_timer_reset SSE system timer: reset
sse_timer_reset SSE system timer: reset
sse_timer_reset SSE system timer: reset
sse_counter_reset SSE system counter: reset
[R +0.024304] endianness
[S +0.024314] OK little
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
"package": "v9.2.0-29-g556bf9b0e6"}, "capabilities": ["oob"]}}
{"execute": "qmp_capabilities"}

{"return": {}}
1..3
# Start of arm tests
# Start of sse-timer tests
[R +0.025692] writel 0x4802e008 0x0
[S +0.025704] OK
[R +0.025722] writel 0x58100000 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x0 size 4
[S +0.025732] OK
[R +0.025748] writel 0x4800002c 0x0
[S +0.025755] OK
[R +0.025771] writel 0x4800004c 0x0
[S +0.025776] OK
[R +0.025791] writel 0x58100008 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x8 data 0x0 size 4
[S +0.025801] OK
[R +0.025817] writel 0x5810000c 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0xc data 0x0 size 4
[S +0.025825] OK
[R +0.025841] writel 0x4802e008 0x1
[S +0.025846] OK
[R +0.025862] clock_step 3125
[S +0.025873] OK 3125
[R +0.025902] readl 0x58100008
sse_counter_control_read SSE system counter control frame read: offset
0x8 data 0x0 size 4
[S +0.025912] OK 0x0000000000000000
[R +0.025927] readl 0x5810000c
sse_counter_control_read SSE system counter control frame read: offset
0xc data 0x0 size 4
[S +0.025933] OK 0x0000000000000000
[R +0.025948] writel 0x58100000 0x1
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x1 size 4
[S +0.025955] OK
[R +0.025974] clock_step 3125
[S +0.025982] OK 6250
[R +0.025997] readl 0x58100008
sse_counter_control_read SSE system counter control frame read: offset
0x8 data 0x64 size 4
[S +0.026005] OK 0x0000000000000064
[R +0.026021] readl 0x5810000c
sse_counter_control_read SSE system counter control frame read: offset
0xc data 0x0 size 4
[S +0.026032] OK 0x0000000000000000
[R +0.026048] writel 0x58100000 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x0 size 4
[S +0.026055] OK
[R +0.026070] writel 0x58100010 0x100000
sse_counter_control_write SSE system counter control framen write:
offset 0x10 data 0x100000 size 4
[S +0.026077] OK
[R +0.026091] writel 0x58100000 0x5
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x5 size 4
[S +0.026098] OK
[R +0.026113] clock_step 5000
[S +0.026121] OK 11250
[R +0.026140] readl 0x58100008
sse_counter_control_read SSE system counter control frame read: offset
0x8 data 0x6e size 4
[S +0.026145] OK 0x000000000000006e
[R +0.026160] readl 0x5810000c
sse_counter_control_read SSE system counter control frame read: offset
0xc data 0x0 size 4
[S +0.026167] OK 0x0000000000000000
ok 1 /arm/sse-timer/counter
[R +0.026200] writel 0x4802e008 0x0
[S +0.026205] OK
[R +0.026220] writel 0x58100000 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x0 size 4
[S +0.026228] OK
[R +0.026244] writel 0x4800002c 0x0
[S +0.026248] OK
[R +0.026263] writel 0x4800004c 0x0
[S +0.026268] OK
[R +0.026283] writel 0x58100008 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x8 data 0x0 size 4
[S +0.026290] OK
[R +0.026305] writel 0x5810000c 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0xc data 0x0 size 4
[S +0.026311] OK
[R +0.026327] writel 0x4802e008 0x1
[S +0.026331] OK
[R +0.026346] writel 0x50080070 0x1
[S +0.026352] OK
[R +0.026368] writel 0x58100000 0x1
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x1 size 4
[S +0.026377] OK
[R +0.026392] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x0 size 4
[S +0.026402] OK 0x0000000000000000
[R +0.026417] readl 0x48000000
sse_timer_read SSE system timer read: offset 0x0 data 0x0 size 4
[S +0.026424] OK 0x0000000000000000
[R +0.026441] readl 0x48000004
sse_timer_read SSE system timer read: offset 0x4 data 0x0 size 4
[S +0.026450] OK 0x0000000000000000
[R +0.026468] writel 0x4800002c 0x1
sse_timer_write SSE system timer write: offset 0x2c data 0x1 size 4
[S +0.026479] OK
[R +0.026495] clock_step 3125
[S +0.026503] OK 14375
[R +0.026518] readl 0x48000000
sse_timer_read SSE system timer read: offset 0x0 data 0x64 size 4
[S +0.026524] OK 0x0000000000000064
[R +0.026540] readl 0x48000004
sse_timer_read SSE system timer read: offset 0x4 data 0x0 size 4
[S +0.026549] OK 0x0000000000000000
[R +0.026565] writel 0x48000020 0xfa0
sse_timer_write SSE system timer write: offset 0x20 data 0xfa0 size 4
[S +0.026572] OK
[R +0.026587] writel 0x48000024 0x0
sse_timer_write SSE system timer write: offset 0x24 data 0x0 size 4
[S +0.026595] OK
[R +0.026610] readl 0x48000028
sse_timer_read SSE system timer read: offset 0x28 data 0xf3c size 4
[S +0.026617] OK 0x0000000000000f3c
[R +0.026633] clock_step 121875
[S +0.026640] OK 136250
[R +0.026655] readl 0x48000028
sse_timer_read SSE system timer read: offset 0x28 data 0x0 size 4
[S +0.026662] OK 0x0000000000000000
[R +0.026677] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x5 size 4
[S +0.026685] OK 0x0000000000000005
[R +0.026699] writel 0x48000048 0xc8
sse_timer_write SSE system timer write: offset 0x48 data 0xc8 size 4
[S +0.026706] OK
[R +0.026722] writel 0x4800004c 0x1
sse_timer_write SSE system timer write: offset 0x4c data 0x1 size 4
[S +0.026729] OK
[R +0.026744] readl 0x48000040
sse_timer_read SSE system timer read: offset 0x40 data 0x1068 size 4
[S +0.026751] OK 0x0000000000001068
[R +0.026767] readl 0x48000044
sse_timer_read SSE system timer read: offset 0x44 data 0x0 size 4
[S +0.026773] OK 0x0000000000000000
[R +0.026787] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x1 size 4
[S +0.026794] OK 0x0000000000000001
[R +0.026809] clock_step 3125
[S +0.026817] OK 139375
[R +0.026832] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x1 size 4
[S +0.026839] OK 0x0000000000000001
[R +0.026855] clock_step 3125
[S +0.026863] OK 142500
[R +0.026878] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x5 size 4
[S +0.026883] OK 0x0000000000000005
[R +0.026899] readl 0x48000040
sse_timer_read SSE system timer read: offset 0x40 data 0x1130 size 4
[S +0.026908] OK 0x0000000000001130
[R +0.026922] readl 0x48000044
sse_timer_read SSE system timer read: offset 0x44 data 0x0 size 4
[S +0.026931] OK 0x0000000000000000
[R +0.026947] clock_step 3125
[S +0.026954] OK 145625
[R +0.026970] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x5 size 4
[S +0.026975] OK 0x0000000000000005
[R +0.026989] writel 0x4800004c 0x1
sse_timer_write SSE system timer write: offset 0x4c data 0x1 size 4
[S +0.026996] OK
[R +0.027011] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x1 size 4
[S +0.027018] OK 0x0000000000000001
[R +0.027033] clock_step 3125
[S +0.027041] OK 148750
[R +0.027054] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x5 size 4
[S +0.027059] OK 0x0000000000000005
[R +0.027075] readl 0x48000040
sse_timer_read SSE system timer read: offset 0x40 data 0x11f8 size 4
[S +0.027082] OK 0x00000000000011f8
[R +0.027098] readl 0x48000044
sse_timer_read SSE system timer read: offset 0x44 data 0x0 size 4
[S +0.027103] OK 0x0000000000000000
[R +0.027119] writel 0x4800004c 0x0
sse_timer_write SSE system timer write: offset 0x4c data 0x0 size 4
[S +0.027136] OK
[R +0.027151] clock_step 8858370048000
[S +0.027160] OK 8858370196750
[R +0.027176] readl 0x48000000
sse_timer_read SSE system timer read: offset 0x0 data 0x1130 size 4
[S +0.027186] OK 0x0000000000001130
[R +0.027201] readl 0x48000004
sse_timer_read SSE system timer read: offset 0x4 data 0x42 size 4
[S +0.027206] OK 0x0000000000000042
[R +0.027222] writel 0x4800004c 0x1
sse_timer_write SSE system timer write: offset 0x4c data 0x1 size 4
[S +0.027230] OK
[R +0.027246] readl 0x48000040
sse_timer_read SSE system timer read: offset 0x40 data 0x11f8 size 4
[S +0.027255] OK 0x00000000000011f8
[R +0.027271] readl 0x48000044
sse_timer_read SSE system timer read: offset 0x44 data 0x42 size 4
[S +0.027278] OK 0x0000000000000042
ok 2 /arm/sse-timer/timer
[R +0.027312] writel 0x4802e008 0x0
[S +0.027316] OK
[R +0.027334] writel 0x58100000 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x0 size 4
[S +0.027342] OK
[R +0.027357] writel 0x4800002c 0x0
sse_timer_write SSE system timer write: offset 0x2c data 0x0 size 4
[S +0.027362] OK
[R +0.027378] writel 0x4800004c 0x0
sse_timer_write SSE system timer write: offset 0x4c data 0x0 size 4
[S +0.027387] OK
[R +0.027400] writel 0x58100008 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x8 data 0x0 size 4
[S +0.027406] OK
[R +0.027422] writel 0x5810000c 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0xc data 0x0 size 4
[S +0.027428] OK
[R +0.027443] writel 0x4802e008 0x1
[S +0.027448] OK
[R +0.027464] writel 0x50080070 0x1
[S +0.027469] OK
[R +0.027484] writel 0x58100000 0x1
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x1 size 4
[S +0.027493] OK
[R +0.027511] writel 0x4800002c 0x1
sse_timer_write SSE system timer write: offset 0x2c data 0x1 size 4
[S +0.027520] OK
[R +0.027536] writel 0x48000020 0xfa0
sse_timer_write SSE system timer write: offset 0x20 data 0xfa0 size 4
[S +0.027546] OK
[R +0.027561] writel 0x48000024 0x0
sse_timer_write SSE system timer write: offset 0x24 data 0x0 size 4
[S +0.027569] OK
[R +0.027585] clock_step 62500
[S +0.027595] OK 8858370259250
[R +0.027610] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x1 size 4
[S +0.027617] OK 0x0000000000000001
[R +0.027633] writel 0x58100000 0x0
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x0 size 4
[S +0.027640] OK
[R +0.027655] writel 0x58100010 0x100000
sse_counter_control_write SSE system counter control framen write:
offset 0x10 data 0x100000 size 4
[S +0.027666] OK
[R +0.027681] writel 0x58100000 0x5
sse_counter_control_write SSE system counter control framen write:
offset 0x0 data 0x5 size 4
[S +0.027688] OK
[R +0.027703] clock_step 62500
[S +0.027711] OK 8858370321750
[R +0.027726] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x1 size 4
[S +0.027732] OK 0x0000000000000001
[R +0.027748] clock_step 937375
[S +0.027755] OK 8858371259125
[R +0.027768] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x1 size 4
[S +0.027775] OK 0x0000000000000001
[R +0.027791] clock_step 125
[S +0.027797] OK 8858371259250
[R +0.027812] readl 0x4800002c
sse_timer_read SSE system timer read: offset 0x2c data 0x5 size 4
[S +0.027819] OK 0x0000000000000005
ok 3 /arm/sse-timer/timer-scale-change
# End of sse-timer tests
# End of arm tests
[I +0.028089] CLOSED


On Fri, Dec 13, 2024 at 2:40=E2=80=AFPM Nabih Estefan <nabihestefan@google.=
com> wrote:
>
> V2: Removed scripts/meson-buildoptions.sh.tmp Extra file that slipped
> through the cracks and shouldn't be in this patch
>
> Recent CDMSK Watchdog changes (eff9dc5660fad3a610171c56a5ec3fada245e519)
> updated the CDMSK APB Watchdog to not free run out of reset. That led to
> this test failing since it never triggers the watchdog to start running.
> No watchdog running means that the timer and counter in the test cannot
> start, leading to failures in the assert statements throughout the test.
> Adding a reset and enable of the watchdog to the reset function solves
> this problem by enabling the watchdog and thus letting the timer and
> counter run as expected
>
> Also renaming the reset_counter_and_timer function since it now also
> affects the watchdog.
>
> To reproduce the failure at HEAD:
> ./configure --target-list=3Darm-softmmu
> make -j check-report-qtest-arm.junit.xml
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/sse-timer-test.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/sse-timer-test.c b/tests/qtest/sse-timer-test.c
> index fd5635d4c9..d7a53ac23a 100644
> --- a/tests/qtest/sse-timer-test.c
> +++ b/tests/qtest/sse-timer-test.c
> @@ -29,6 +29,13 @@
>  /* Base of the System Counter control frame */
>  #define COUNTER_BASE 0x58100000
>
> +/* Base of the MSSDK APB Watchdog Device */
> +#define WDOG_BASE 0x4802e000
> +
> +/* CMSDK Watchdog offsets */
> +#define WDOGLOAD 0
> +#define WDOGCONTROL 8
> +
>  /* SSE counter register offsets in the control frame */
>  #define CNTCR 0
>  #define CNTSR 0x4
> @@ -63,24 +70,26 @@ static void clock_step_ticks(uint64_t ticks)
>      clock_step(FOUR_TICKS * (ticks >> 2));
>  }
>
> -static void reset_counter_and_timer(void)
> +static void reset_watchdog_counter_and_timer(void)
>  {
>      /*
> -     * Reset the system counter and the timer between tests. This
> +     * Reset the system watchdog, counter and the timer between tests. T=
his
>       * isn't a full reset, but it's sufficient for what the tests check.
>       */
> +    writel(WDOG_BASE + WDOGCONTROL, 0);
>      writel(COUNTER_BASE + CNTCR, 0);
>      writel(TIMER_BASE + CNTP_CTL, 0);
>      writel(TIMER_BASE + CNTP_AIVAL_CTL, 0);
>      writel(COUNTER_BASE + CNTCV_LO, 0);
>      writel(COUNTER_BASE + CNTCV_HI, 0);
> +    writel(WDOG_BASE + WDOGCONTROL, 1);
>  }
>
>  static void test_counter(void)
>  {
>      /* Basic counter functionality test */
>
> -    reset_counter_and_timer();
> +    reset_watchdog_counter_and_timer();
>      /* The counter should start disabled: check that it doesn't move */
>      clock_step_ticks(100);
>      g_assert_cmpuint(readl(COUNTER_BASE + CNTCV_LO), =3D=3D, 0);
> @@ -103,7 +112,7 @@ static void test_timer(void)
>  {
>      /* Basic timer functionality test */
>
> -    reset_counter_and_timer();
> +    reset_watchdog_counter_and_timer();
>      /*
>       * The timer is behind a Peripheral Protection Controller, and
>       * qtest accesses are always non-secure (no memory attributes),
> @@ -195,7 +204,7 @@ static void test_timer_scale_change(void)
>       * Test that the timer responds correctly to counter
>       * scaling changes while it has an active timer.
>       */
> -    reset_counter_and_timer();
> +    reset_watchdog_counter_and_timer();
>      /* Give ourselves access to the timer, and enable the counter and ti=
mer */
>      writel(PERIPHNSPPC0, 1);
>      writel(COUNTER_BASE + CNTCR, 1);
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

