Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E16D58D5C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaZX-000750-M9; Mon, 25 Nov 2024 10:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tFaZT-00070F-Ol
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:00:15 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tFaZS-0006E6-8I
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:00:15 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85714347e80so934393241.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732546813; x=1733151613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/DLDntUdD026t5lQXU73I+m3Bvzt3snP0zn8/j+zHE=;
 b=MasaAMQZ179NgO5SJQsgTXkuZDgIVPCXNrruLDfqrKGmOhGKn7hgzB+Du739hMkBEg
 EcWo6LVe/9BfVM8vNB4GkdmIXOdjN6NmckJwScAppqaOBIYldEENNaxfnObplWByMVcQ
 lw9tI80BWSH1S1geMtphSurXuKjPAs83MHL59diL6D3g9BXCKyvvnxo/xE6cIxwHyHif
 kaDjSZ4ZDTBAK/wxUDlAlkDUaCaMLTsHwGXIuic3TwmlxKKxAbNP0Wocd0mQovW4hRKW
 tOt9xgDGGlQi6rXr+umSceTqnOXAO2DFRVP3g/dSXnx0DsgKyvT3Qe+DdAifMy3CQycq
 R9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732546813; x=1733151613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/DLDntUdD026t5lQXU73I+m3Bvzt3snP0zn8/j+zHE=;
 b=lM9WE3PbvYF0d6HKbV6Ilcv+xdpkMQC9CBrTPK6bcpBb0KNbt3OfE4OTrhr4mAs87f
 pMO1fygFcRSGeRGriNJIVh9vK3gzPk85jtFD4U1MzLtJI27PCtSOjQC3tANprYoPIeMN
 cki4kgXZrRuTsE8vetzu/vo9x8dxPEfRHGf0STmCJNg41GQR8JjKVRPxBOoQo4OfxFl7
 EEGPHOMWaTQ4/4xjBJPUG0NKDSsWqL4K4GGUR+VYif6KYgejX+B2JoURu+jhSznY+dq/
 zSDE88lZf42wUlyuJ48+5ruGvbuzCqeh2zaxJREFhFFYzJVySOS/bo/RfheSXNCWKEJX
 JM4w==
X-Gm-Message-State: AOJu0YwyLBzMYB+FxhrkhuuhShwua7xwFExvzeDVwZRXyZSoWcDkRsCs
 2VkdRCiBmPWkZgDXGlAzCIOZFGdnVafasXQ9LexhWguLtEvph8AW0/1GV43SFqXFdCZPjprqhbq
 EC2EKuyN0BYDGm/E52mA9ZKTOVT9Weg==
X-Gm-Gg: ASbGncvx+cA3fqwvLxSXKbf+YYIUBuyXY4CxucVuFWq0Ys4jSB5WipPP84g58ZyIasE
 CNiGrUKT6+MkbN8HFzSy4RC7tM12CIyrW
X-Google-Smtp-Source: AGHT+IHWS4/Ber2kIEQ562871yZgnxuGhh29K5Aq7zLLw4geIsthI7Aj0zIuzNmmjV7Amz5qX+1xq4eyTXZaaDbk/Hc=
X-Received: by 2002:a05:6122:1d4a:b0:50d:44fd:5b68 with SMTP id
 71dfb90a1353d-51500ae8bc3mr11909338e0c.10.1732546811732; Mon, 25 Nov 2024
 07:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
 <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
 <CAFfO_h5LHsgng5itQTEO30SUT_jn02Pdi-0uYvyZCgRPJfcueA@mail.gmail.com>
 <2970cc68-a34c-4751-b4a3-d7fac416d7d3@amazon.com>
 <CAFfO_h47fHYfiU9vgU61UT+jSnv9YCO8jTy+hB77+AQc+NZ7+w@mail.gmail.com>
In-Reply-To: <CAFfO_h47fHYfiU9vgU61UT+jSnv9YCO8jTy+hB77+AQc+NZ7+w@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 25 Nov 2024 21:00:18 +0600
Message-ID: <CAFfO_h4xpJY=sz2O8TcYqwdXALZ=g6MQk=w0-_EuPkgKPcG11A@mail.gmail.com>
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Nov 18, 2024 at 7:12=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Ping.
>

Ping...
This is a small one that can be reviewed and picked up for merging. Thanks!

Regards,
Dorjoy

