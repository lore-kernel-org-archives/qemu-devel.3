Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F9606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JnvKvkTx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cIjm/kwE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOug-0005Ac-Nu; Mon, 23 Nov 2026 02:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xVOuU-00059k-07
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xVOuS-0003uS-Cx
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795420577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9uMHyfkA7haUkAAd2aWrcBS0BPZiPITB05oV7SGK+M=;
 b=JnvKvkTxmHlSsF2v30AsewtTA7QpILnEXQ8IWbxizDSMbMVaBGxplNlPWi/187DT+vGzJN
 dDjNCpUuOfVbaKwN6U4nm+q1E8I7La/EpyS0XZL9MYaI0hjajROYbJk8ujLCk2wAm5H3/C
 ymiZkfjrjw9/InOzMW2hNxhu4xrRTS8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-TS_uZUFDOMmSnhQ33Viz7Q-1; Mon, 23 Nov 2026 07:56:15 +0000
X-MC-Unique: TS_uZUFDOMmSnhQ33Viz7Q-1
X-Mimecast-MFC-AGG-ID: TS_uZUFDOMmSnhQ33Viz7Q_1795420575
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2efdd509c6bso38096895ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 23:56:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795420574; cv=none;
 d=google.com; s=arc-20260327;
 b=Oej1/500ZaNA84E9FNRa+deDBSefQyiOcUHmVRAR2Qtu9wYrxowLim5Cn0noPEehCb
 bKZyRmwuCzSyIk0xlavlt+cery8Tw9cJbg1Efz0u1z4pqHEXQchQuquwdmmEkzRysJK5
 P1X+nBnropM35isAg2kK6K7Ky0S3WIwAHMsCH+7RvDXfHA6LM+KbXRdTw1JAHNx7JS+9
 IthmfoWQ0M9WO3CRs+OHI/tfXydD0FLqvH5ay/8qEpTm+Ddp4Z00FvzMniTj3Th4//mR
 A4xG8bvGMHrnlwuOnZhcuDpA7ITZDCuOv53xilxrzQcF+P4o4CTXWGDVR9rHA2IK0oH0
 3ALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/9uMHyfkA7haUkAAd2aWrcBS0BPZiPITB05oV7SGK+M=;
 fh=pgrTKy0X1NH3HlpUys1eZb3ySEPm4qYEWbngXSClj54=;
 b=bVkIp91K8rdu+qorKXjYiwdo8w9/PHUs9DBU52No+E0yrjwZwfcZw6nY6YC5rHkrfs
 2Hvx/8WUWkCqUcTBaswWtXOVaPRnSeWK4Ea8hrVhIsdt2SlGcVAybkAcm7NM7JCF1M6V
 V9oGUB/JKuEBPNw2bAiPZjNxdBwFS5Nd0dC0rnYywwq0hQoefTIDpt4O0ogR7+7mDIeB
 gNCttrV9fyJQmwsMwGMbAr89NgEVd1XteUbbFUzJ0C2ooZZUvbqMjnQKbjzmlX9HLGMy
 iyVU8TH9Yvu97RroTf8Td7BOOSj4sj9Oi09dlzhtcwGWwzZn//dbvQXDlBaCO2Qi6/WT
 TuvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795420574; x=1796025374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/9uMHyfkA7haUkAAd2aWrcBS0BPZiPITB05oV7SGK+M=;
 b=cIjm/kwEURtgn6ZBmCF5Tsu0DEN8U4ef3Azdu2rd2tPcC6ofUZi95Yt+TIlARXVKXz
 yD/1uGf/lm7ApHfQ279xS3YxtRo0tHk8Me7DauTJW8y3S+bCI4oVKdAsTP2qVGvjQSwl
 aDK+ke7Buh6MAkqkQix+EdgY+uA2xb+urqMsUhvLHYN6GizjKTyF0GCIdFPzqQC7x5JI
 RUIXWmozzzqB+D6g6Ef+ZFf1mraUsj/P8ISaybQdmziAndntAlfr2mXaVKuoURvoDSnN
 BVxRox5Jwl7zwpqNyfBalCLItPqDzWzJ+EAaiVDt7xEU+II13mNTfnCJnDxVWubkhZxy
 6F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795420574; x=1796025374;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/9uMHyfkA7haUkAAd2aWrcBS0BPZiPITB05oV7SGK+M=;
 b=q9ua0flZg1c1dvKNiTMrmjondAvs8kB7tZogWsOnByLYFwcDpm1dhb9vxoC1Gqrz0R
 iPjJZvvq2D5DxI0CEeBgo+0szgmpEZoF+2T90h92KEeeXZWUBtfORrvjp+UHu8xHADUY
 eUJFbMMf7HvV//xzk67azkV4zHL4NY61JCuAhiAeWfGHp/i1pvP3m8i1ACarRmh1aQcR
 jwsovB1u1HYS3Fen8XpM/r31KhtfSU1GjC8TduXM4+0IXpj7KE9jaxL+DNkB75MSxth/
 E5Up8iIisEnSn9hmBUlk9oJOH2yAQ2eTUZc5hC/UQEGEi8fVmJWAQ/7nnf1JEjVExXRG
 WssA==
X-Gm-Message-State: APuU4Z/jW3C9Lb2ovX79CkpMbPo8LTErLyw+dvGHt4eexGZ9QSkUrla5
 YSpnfwyh5u2IaU7XyA/V2fZbCHipeuOhbGcZ0S09pFfD8FjTvuQ+d1HZaW7U6lkja5P6K/sHNUw
 f1VjCAwGkUL02Yfab1e3aOpM7jeFo9Wg6nU7YbKkXtEw4zhcq3/tCAoV2Ok4b1rZQc7DX2QZZBm
 41RGepd8hRDJh5nVXBiB6uj0VxiSsW84Y=
X-Gm-Gg: AZFdTZeHIqkc2h1RK6vHr06AYqI3vSU8ZgRBiJo0KgIo6pPbfCnnhLZxtT9BWXGo9M0
 mP/V3ILcbJ3vkdOcpMOpbUkdYDtJI/FYwUOhTXBnpsVKR/3DWLun7sn8K+64/cp3AoFCVwO2bPf
 U/v0YrJg7JcyZrUrM38xYEf61SXaE//SyuaYkuHjWYljuPGuzLmVRIDEYykf7dwHxTg7hQynTff
 2eWLF30a9Ue6KyIdE2ecqoU4KQH4b7JAYKqv5W34P/TcwCWMN8cKNa74Nz4AUV1ZoK9SrvrNmfH
 Mg==
X-Received: by 2002:a17:903:198d:b0:2f0:39c6:8ee5 with SMTP id
 d9443c01a7336-2f03f27787fmr111898105ad.52.1795420574492; 
 Sun, 22 Nov 2026 23:56:14 -0800 (PST)
X-Received: by 2002:a17:903:198d:b0:2f0:39c6:8ee5 with SMTP id
 d9443c01a7336-2f03f27787fmr111898045ad.52.1795420574045; Sun, 22 Nov 2026
 23:56:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122112213.1645993-1-zhuwei@sangfor.com.cn>
 <20261122112213.1645993-2-zhuwei@sangfor.com.cn>
In-Reply-To: <20261122112213.1645993-2-zhuwei@sangfor.com.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Nov 2026 11:56:02 +0400
X-Gm-Features: Aa3M54pGL-85dItFUYiU_JqbtS3VDI7o7JppDkFTUaRy6nn-wjurg4VM39kLlsw
Message-ID: <CAMxuvaywsDg9vdF1A+=bsxo3y=iG0uX+ZQH9WBw8+7tiXa2rkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ui: fix QEMUCursor leak in
 qemu_graphic_console_finalize()
To: Zhu Wei <zachwade.k@gmail.com>
Cc: qemu-devel@nongnu.org, niming <niming@sangfor.com.cn>, 
 zhuwei <zhuwei@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 3:22=E2=80=AFPM Zhu Wei <zachwade.k@gmail.com> wrot=
e:
>
> From: zhuwei <zhuwei@sangfor.com.cn>
>
> qemu_console_set_cursor() stores the cursor in QemuGraphicConsole.cursor
> with a reference taken by cursor_ref().  qemu_graphic_console_finalize()
> only drops the reference on c->device, so the reference held by c->cursor
> is never released.  As a result the reference count of the QEMUCursor,
> and the pixel data it owns, never reach zero when the console is
> finalized, leaking both.
>
> Release the reference in qemu_graphic_console_finalize() with
> g_clear_pointer(&c->cursor, cursor_unref), which is the same pattern
> already used for the spice display cursor.
>
> Fixes: 385ac97f8fad ("ui: keep current cursor with QemuConsole")
> Signed-off-by: niming <niming@sangfor.com.cn>
> Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
> ---
>  ui/console.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/console.c b/ui/console.c
> index c995abc5d1..327bbc4a5c 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -469,6 +469,9 @@ qemu_graphic_console_finalize(Object *obj)
>      QemuGraphicConsole *c =3D QEMU_GRAPHIC_CONSOLE(obj);
>
>      g_clear_pointer(&c->device, object_unref);
> +
> +    /* Release the reference taken by qemu_console_set_cursor() */
> +    g_clear_pointer(&c->cursor, cursor_unref);

without this comment,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  }
>
>  static void
> --
> 2.56.0
>


