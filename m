Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7587DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBSg-0004aa-T3; Wed, 12 Aug 2026 12:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuBSV-0004SS-Ca
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:05:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuBSO-0001Nm-Ow
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:05:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbUxm320249
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLneLVqopeYbl3opjTW7Gb2+UbuTqEGgnKayLVcDTPs=; b=H72s570816IcD6+v
 nsFmIHxH9WphrukG2PD6Ex0ZJvgqROzBxww9HFxRZ68jxMc4iPzFigWie5qkdM+/
 o5vqmXqqyLkmY2K3IcPHmFE3GWYB+miaHjpi69H3Qx54Ysr3QPUaFyUjGThFh+ye
 yxUe0oLjrYbnx/Rt+z2B+7DxKgg7ClYzNniEcqUKzRHKcuqlvDfAJJHd805M/ox/
 9KGfHst1hQAchAEq1mK1IHfk/lY8mXnH561iwz5bUPSXI3tFoWY23VGbLM423bFM
 wTztuqZAQnlzyqzZV1F4RkNUR4+3QQhq+npbnWQjE6MyB8dZo8DxN940PTGd36Qy
 vnj1EQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk40v7k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 16:05:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-907ca5abf1bso7416866d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786550720; x=1787155520; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tLneLVqopeYbl3opjTW7Gb2+UbuTqEGgnKayLVcDTPs=;
 b=RSR6hqf+Uauj2D/jtLX5+NDWAyPhwp0FNS3sNbsas84Gx4hmlxKx5K0inbWgA0QSQF
 pDoEQIz26lt+GtcAVMsB7Tm8V05/D3FqnFhyouP3J3XCOb9jN0p/ecWzj+IUo9B5YA1G
 W04gcax8zT/RLl/2yq524DPBxmgMAhyUHZdl9YtJT0YF4BdGUIXZmwAFwOSzOq5OSiWD
 qidKrkivzGMDze3IihTYfsYRJ+Uat4ppTekwVNYp1mvZRAEGDUbqCF/Ww0/NxEsAEGyq
 8kGhvCBnNwcPNhGLkAbu99WqRg4NsGMmiDzMLDbGu317hetDrbb9Tn+RN6SfvdI9F0BV
 +HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550720; x=1787155520;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLneLVqopeYbl3opjTW7Gb2+UbuTqEGgnKayLVcDTPs=;
 b=B/WemNMvxV6JgAaJF11oMeioQbqCjsDbNwPCbqZfb0rjGl/CO17jpBs/ROgAMNXIqi
 zE5AO+Arc9Jg9TVcW1/yD2SUL35NBZPjrgHkqX4oEFcbg8Q3TwZB5FtUaTc3jPyyA3pe
 p797QZi2fuhhbjNGkldvV4NP70oSzdp3MfkHZetKjmdVHvGQm4rEYBB60MJjtB9X+PLI
 QWUsD3HIOVbfJYuR6EyKy0wnCmCQizOHPaiDQggV1G62SQF0m81GeFWJjSzwDcQyl/fz
 8d5Cy4q34rdHHEpgYC4jIcsT6PJAzQ/I+2wfh9axbmsJi1w6zh3P7PgU5+A2LYcFBtSi
 0vWg==
X-Gm-Message-State: AOJu0Yzo/fsCHG+Od3cQp3Hf859sUyD7/KfDsBTI8MwJlnbCQSQKUKhp
 dmaF7wzVo1N7/NUt3OnjskkOdim4es0rkuXDwQheG2652fWA/YmNdzckA6FDiSCKiQI9gC3dwb1
 lItqW93llwJcS9fxQZcHWRTH+n/+8ZIc+8hEVh2ZCsfQv1yYWStogW3HEoQ==
X-Gm-Gg: AR+sD13Zv9IYckNJvEtVwvSSzgV9Q517JdGanJ8WSeWCSj1LjTZyRpp8vyIgH1eKuIS
 aDWFFUsv+kWUqhMKv/yBOqNEXGinajQDZx6JZvbHxyQQ8+x/e1Hc5X6+DTDbhFrkVPqDMn73r/z
 +1geH/DutTwgxOsY/lz5/FlRgdxqJUgj5mmBJNxUT8+pMvJ4KCana/lAVNxJbV83wYl+a6uw9RA
 GuRCXei1AK4qYEGit7Ciyh7Rl8DWX/RGXmukTEHJIJVdM+QVT5qkJqPz0cKHzh1EL0hLqWlRSHP
 exiZd6blFcTsgQUEJAAK74nhn6uZD1lHGP7uRLTqFuo0XeIeR2ICziJlmVFPmKVSAESdiFNmDkA
 AYLEdat3Q8tUqhUPm7LPQOZ4=
X-Received: by 2002:a05:622a:4086:b0:517:7e26:36a4 with SMTP id
 d75a77b69052e-52d6482decemr51694961cf.34.1786550720140; 
 Wed, 12 Aug 2026 09:05:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4086:b0:517:7e26:36a4 with SMTP id
 d75a77b69052e-52d6482decemr51693621cf.34.1786550719560; 
 Wed, 12 Aug 2026 09:05:19 -0700 (PDT)
Received: from [192.168.0.138] ([79.127.134.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0b0bdf8sm105871866b.58.2026.08.12.09.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 09:05:17 -0700 (PDT)
Message-ID: <a27c4385-71d8-43a6-9ea9-3f8e360ed321@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] monitor: Remove unnecessary 'block/block.h'
 header
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-11-philmd@oss.qualcomm.com>
 <CAJ+F1C+X4DNFWXn9AK8kxp6zyCUnau5SawaZbQLO+=Gjw07y3Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJ+F1C+X4DNFWXn9AK8kxp6zyCUnau5SawaZbQLO+=Gjw07y3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HSCQafOQlhg98K5m1_oBqlIap6t0lQhv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX5hzepf695r0F
 8ACGVcEtWx0B9vG4QW27DQZOAfilZviqTzhsbO3t1Lq4oGETuJNs4dhKhxPkro/SUE810Y6e68f
 7NpcHFYEbSF2+I6Olqo9WPIXwkkhv6UrdPGnJye3nIyXn8IjBEPFPnuxBB9K5YCjvX4xgOcqC2b
 Q4mbETqqycTxTfzfYNUC/VohiV4OZtk62YLd5cvj6K9P/94a5WdUbDSUh8iWJ1K6/+byzgyItqE
 GdsdCosfiOA+vd9C/5wj/R6O7QecSuXAv3jZhcAkv5/Ug4IbK8eljS3QDt0lFHrBDfAU2fl64Gl
 BfY3CDy2N8tntwj7KhVC5q1ExfpnwF0eC0/wPnZLBF1oWPcYnpUR+isKjLgKTvowgRkx83icxzX
 HH8FKr7RGW6EOHJ2QoUCUHnECFddqyhUYV5hGsgwk7Z10YdMd0L5lUOo067Ph2JyVWC/O4/VIWX
 WOCgo9clAf9e9ZLsNug==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7c99c1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=iDw3GeftGWU4ZHOe0o4/TA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9tDYajOzGLYUmkkAFd4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX8PxB8DzFcwXr
 CPMLHK6Vh4BrnQqWi6v2XMr0FO9qo4NE21KX5dbAcStiKKJQigwpro9wsBGE/lwYfSa33YimKQC
 o/22nMFaDlz4PbRDduGn8xrdK9KnQw8=
X-Proofpoint-ORIG-GUID: HSCQafOQlhg98K5m1_oBqlIap6t0lQhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 2026-08-12 16:00, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Wed, Aug 12, 2026 at 5:38 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Nothing here requires declarations from "block/block.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> breaks for me:
> [38/286] Compiling C object libsystem.a.p/net_vhost-vdpa.c.o
> FAILED: [code=1] libsystem.a.p/net_vhost-vdpa.c.o
> cc -m64 -Ilibsystem.a.p -I. -I.. -Isubprojects/libvduse
> -I../subprojects/libvduse -Iui -Iqapi -Itrace -Iui/shader
> -I/usr/include/p11-kit-1 -I/usr/include/libpng16
> -I/usr/include/pixman-1 -I/usr/include/spice-1 -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/sysprof-6
> -I/usr/include/gio-unix-2.0 -I/usr/include/spice-server
> -I/usr/include/opus -I/usr/include/cacard -I/usr/include/nss3
> -I/usr/include/nspr4 -I/usr/include/PCSC -I/usr/include/gstreamer-1.0
> -I/usr/include/libdrm -I/usr/include/orc-0.4 -I/usr/include/slirp
> -I/usr/local/include -I/usr/include/libusb-1.0 -I/usr/include/SDL2
> -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0
> -I/usr/include/cloudproviders -I/usr/include/cairo
> -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/glycin-2
> -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
> -I/usr/include/atk-1.0 -I/usr/lib64/pkgconfig/../../include/dbus-1.0
> -I/usr/lib64/pkgconfig/../../lib64/dbus-1.0/include
> -I/usr/include/fribidi -I/usr/include/libxml2 -I/usr/include/harfbuzz
> -I/usr/include/freetype2 -I/usr/include/vte-2.91 -I/usr/include/rav1e
> -I/usr/include/svt-av1 -I/usr/include/libvmaf -I/usr/include/webp
> -I/usr/include/virgl -I/usr/include/fuse3 -I/usr/include/pipewire-0.3
> -I/usr/include/spa-0.2 -fdiagnostics-color=auto -Wall -Winvalid-pch
> -Werror -std=gnu11 -O2 -g -mcx16 -msse2 -fno-link-libatomic
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
> -fzero-init-padding-bits=all -fzero-call-used-regs=used-gpr
> -fsanitize=address -fstack-protector-strong -fno-omit-frame-pointer
> -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2
> -Wformat-security -Wformat-y2k -Wignored-qualifiers
> -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute
> -Wmissing-prototypes -Wnested-externs -Wold-style-declaration
> -Wold-style-definition -Wredundant-decls -Wshadow=local
> -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings
> -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
> -isystem /home/elmarco/src/qemu.nmi/linux-headers -isystem
> linux-headers -iquote . -iquote /home/elmarco/src/qemu.nmi -iquote
> /home/elmarco/src/qemu.nmi/include -iquote
> /home/elmarco/src/qemu.nmi/host/include/x86_64 -iquote
> /home/elmarco/src/qemu.nmi/host/include/generic -iquote
> /home/elmarco/src/qemu.nmi/tcg/x86_64 -pthread -fPIE
> -fno-strict-aliasing -fno-strict-overflow -DHWY_SHARED_DEFINE
> -DAVIF_DLL -DEB_DLL -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600
> -DNCURSES_WIDECHAR=1 -D_GNU_SOURCE=1 -D_REENTRANT
> -DSTRUCT_IOVEC_DEFINED -DWITH_GZFILEOP -DCONFIG_SOFTMMU
> -DCOMPILING_SYSTEM_VS_USER -MD -MQ libsystem.a.p/net_vhost-vdpa.c.o
> -MF libsystem.a.p/net_vhost-vdpa.c.o.d -o
> libsystem.a.p/net_vhost-vdpa.c.o -c ../net/vhost-vdpa.c
> ../net/vhost-vdpa.c: In function ‘vhost_vdpa_net_load_cmd’:
> ../net/vhost-vdpa.c:714:24: error: implicit declaration of function
> ‘iov_size’ [-Wimplicit-function-declaration]
>    714 |     size_t data_size = iov_size(data_sg, data_num), cmd_size;
>        |                        ^~~~~~~~
> ../net/vhost-vdpa.c:714:24: error: nested extern declaration of
> ‘iov_size’ [-Werror=nested-externs]
> ../net/vhost-vdpa.c:742:5: error: implicit declaration of function
> ‘iov_from_buf’ [-Wimplicit-function-declaration]
>    742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
>        |     ^~~~~~~~~~~~
> ../net/vhost-vdpa.c:742:5: error: nested extern declaration of
> ‘iov_from_buf’ [-Werror=nested-externs]
> ../net/vhost-vdpa.c:744:5: error: implicit declaration of function
> ‘iov_to_buf’ [-Wimplicit-function-declaration]
>    744 |     iov_to_buf(data_sg, data_num, 0,
>        |     ^~~~~~~~~~
> ../net/vhost-vdpa.c:744:5: error: nested extern declaration of
> ‘iov_to_buf’ [-Werror=nested-externs]
> ../net/vhost-vdpa.c:748:5: error: implicit declaration of function
> ‘iov_copy’; did you mean ‘error_copy’?
> [-Wimplicit-function-declaration]
>    748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
>        |     ^~~~~~~~
>        |     error_copy
> ../net/vhost-vdpa.c:748:5: error: nested extern declaration of
> ‘iov_copy’ [-Werror=nested-externs]
> ../net/vhost-vdpa.c:760:5: error: implicit declaration of function
> ‘iov_discard_front’ [-Wimplicit-function-declaration]
>    760 |     iov_discard_front(&out_cursor, &dummy_cursor_iov_cnt, cmd_size);
>        |     ^~~~~~~~~~~~~~~~~
> ../net/vhost-vdpa.c:760:5: error: nested extern declaration of
> ‘iov_discard_front’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> [55/286] Compiling C object libsystem.a.p/system_physmem.c.o
> ninja: build stopped: subcommand failed.
TIL monitor_fd_param().

Anyway thanks, consider the following as "PATCH 9.5/16":
-- >8 --
Author: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Date:   Wed Aug 12 18:03:10 2026 +0200

     net/vhost-vdpa: Include missing 'qemu/iov.h' header

     vhost-vdpa.c uses methods declared in the "qemu/iov." header.
     Include it otherwise we get when refactoring unrelated headers:

       ../net/vhost-vdpa.c: In function ‘vhost_vdpa_net_load_cmd’:
       ../net/vhost-vdpa.c:714:24: error: implicit declaration of 
function ‘iov_size’
         714 |     size_t data_size = iov_size(data_sg, data_num), cmd_size;
             |                        ^~~~~~~~
       ../net/vhost-vdpa.c:714:24: error: nested extern declaration of 
‘iov_size’
       ../net/vhost-vdpa.c:742:5: error: implicit declaration of 
function ‘iov_from_buf’
         742 |     iov_from_buf(out_cursor, 1, 0, &ctrl, sizeof(ctrl));
             |     ^~~~~~~~~~~~
       ../net/vhost-vdpa.c:742:5: error: nested extern declaration of 
‘iov_from_buf’
       ../net/vhost-vdpa.c:744:5: error: implicit declaration of 
function ‘iov_to_buf’
         744 |     iov_to_buf(data_sg, data_num, 0,
             |     ^~~~~~~~~~
       ../net/vhost-vdpa.c:744:5: error: nested extern declaration of 
‘iov_to_buf’
       ../net/vhost-vdpa.c:748:5: error: implicit declaration of 
function ‘iov_copy’
         748 |     iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
             |     ^~~~~~~~

     Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index c526c2b2dc..1052361a4a 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -17,6 +17,7 @@
  #include "hw/virtio/vhost-vdpa.h"
  #include "qemu/config-file.h"
  #include "qemu/error-report.h"
+#include "qemu/iov.h"
  #include "qemu/log.h"
  #include "qemu/memalign.h"
  #include "qemu/option.h"
---

