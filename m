Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6971C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s77-0006Ul-Fk; Fri, 03 May 2024 08:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2s75-0006SR-Pk
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:34:07 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2s72-0002gP-Pu
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:34:07 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso1323564166b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739643; x=1715344443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PqLmK69BsFys4BXQpEqqpShQjibb6+oR2+a8gTQ0k/c=;
 b=ZdxI7P+qOIfK/o7Ye+5Icw+mxxqYipmaBinRwtn5K8qKdKtZWUUzaAj+epeXsXe0o4
 A39rn2i902ZRSZ/z6EsGpRUaICejWA5Y/xf835HQgahPEOLwf7vEBdQTrSv1CRmlDFO7
 hUAEAs9DMAIa7baYjhROyigC8V0H4URmSJywTAToXtOo9q78TED7hzRKNV0kn3BfNAkX
 VjqWqO/te/DS4iDwPxMQ7SWUBLDRifgKmakmD1NihRZ4EmknmXFvBtBzbQ5GULxjAJKm
 I++R8ID7nuiNrUQUnpb/8/loAXkFnmuQCvW4Zjtx/sw20FXXEIvArRyJiXMz1a6iOOoK
 /HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739643; x=1715344443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqLmK69BsFys4BXQpEqqpShQjibb6+oR2+a8gTQ0k/c=;
 b=YHbltc4GBwzrLUDFxzDgErx0z7mvo+cGWs/WV+TXZ2F4lB8n/876S5cNp2jcRQc6cI
 aFmd0Mj1jdDV/vmRO1TQ8ZYx5AYgi9H7nXk0odBKPCvIQ1yF8Euko2yUopQ2fn1sRdIG
 vv1mFlPWpoyoO3LIDAd4OdZejrQiF9IgSRvPZupyafoElpslOKGLw37RthcpvwT3lM1V
 DghbuG0aTNgn7Pz0neOPl6i63kPh1+sDguoRI8fx1rx6at5bEQ8OuS2eI391XQaXrQsA
 A45jVgDe51EkyhK5PjoYeYUi0x5qoGK68M6TwpvYRJ16CIpomZFWpJIwS6Ol7ujkSROm
 27lw==
X-Gm-Message-State: AOJu0YxLviVcfFmy3d/naFobi3N8gMC0t2ZroJ5aVZC9fgqyFL8zeQ6m
 jQsTh64f0AIDXSWG5u3ccSqFAVIAXkQszqts/XeVvGe3iCGuZMToK3spk7ai/50osa0dYSa4vM1
 X+WPb5JpDtz6kTX+cFwE7iYGPRelUuxWyqA8Hrw==
X-Google-Smtp-Source: AGHT+IGfceQxov+mMFmgsCI+0u2WDScpMl0s6robO8RLQBd9P7td6ades1yvgaZrBARkASf5Fh26e1FLvAFxdsrpZtg=
X-Received: by 2002:a50:99d8:0:b0:56e:24a5:587a with SMTP id
 n24-20020a5099d8000000b0056e24a5587amr1671836edb.11.1714739643003; Fri, 03
 May 2024 05:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-4-stefanha@redhat.com>
In-Reply-To: <20230515160506.1776883-4-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 13:33:51 +0100
Message-ID: <CAFEAcA9U8jtHFYY1xZ69=PoR1imgzrTB9aK5aoe+vZJtQrU1Jg@mail.gmail.com>
Subject: Re: [PULL v2 03/16] block/block-backend: add block layer APIs
 resembling Linux ZonedBlockDevice ioctls
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sam Li <faithilikerun@gmail.com>, 
 Hannes Reinecke <hare@suse.de>, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 15 May 2023 at 17:07, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Sam Li <faithilikerun@gmail.com>
>
> Add zoned device option to host_device BlockDriver. It will be presented only
> for zoned host block devices. By adding zone management operations to the
> host_block_device BlockDriver, users can use the new block layer APIs
> including Report Zone and four zone management operations
> (open, close, finish, reset, reset_all).
>
> Qemu-io uses the new APIs to perform zoned storage commands of the device:
> zone_report(zrp), zone_open(zo), zone_close(zc), zone_reset(zrs),
> zone_finish(zf).
>
> For example, to test zone_report, use following command:
> $ ./build/qemu-io --image-opts -n driver=host_device, filename=/dev/nullb0
> -c "zrp offset nr_zones"

Hi; Coverity points out an issue in this commit (CID 1544771):

> +static int zone_report_f(BlockBackend *blk, int argc, char **argv)
> +{
> +    int ret;
> +    int64_t offset;
> +    unsigned int nr_zones;
> +
> +    ++optind;
> +    offset = cvtnum(argv[optind]);
> +    ++optind;
> +    nr_zones = cvtnum(argv[optind]);

cvtnum() can fail and return a negative value on error
(e.g. if the number in the string is out of range),
but we are not checking for that. Instead we stuff
the value into an 'unsigned int' and then pass that to
g_new(), which will result in our trying to allocate a large
amount of memory.

Here, and also in the other functions below that use cvtnum(),
I think we should follow the pattern for use of that function
that is used in the pre-existing code in this function:

 int64_t foo; /* NB: not an unsigned or some smaller type */

 foo = cvtnum(arg)
 if (foo < 0) {
     print_cvtnum_err(foo, arg);
     return foo; /* or otherwise handle returning an error upward */
 }

It looks like all the uses of cvtnum in this patch should be
adjusted to handle errors.

thanks
-- PMM

