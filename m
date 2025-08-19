Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A004CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoU1G-0004Em-Om; Tue, 19 Aug 2025 17:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoU1E-0004E1-Ug
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoU1D-0007z4-Jc
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755639442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vO4rLKWdrb6LdbjKhAcWgreoFfQnYtDttwySkQouk8=;
 b=dZfV3YkEtXyJaQa+EWMYLYofpay1Fa0Mtu/ru5D71jhKQzHyPtCW4FjuoUFEJVYjzIdQXY
 Hk8ZycIGUkfukdZzdafeRlNhvXZhJxY+HejuBENW7QOKByJz53AvzBwFNTv4VO/BCHNIX7
 lAiqocts1uyAzSiSUNpa8EbCgXD98zM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-ih7uWSKEOsKvahp8u-GxLQ-1; Tue, 19 Aug 2025 17:37:18 -0400
X-MC-Unique: ih7uWSKEOsKvahp8u-GxLQ-1
X-Mimecast-MFC-AGG-ID: ih7uWSKEOsKvahp8u-GxLQ_1755639437
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458067fdeso70378015ad.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 14:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755639437; x=1756244237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vO4rLKWdrb6LdbjKhAcWgreoFfQnYtDttwySkQouk8=;
 b=YtnxPXjLobLCv3XZswqWyvDUYlG04RUMyWswZzYFqBUt+neMo9iPWyHqlfhqY/Jsga
 BWtJgHc87K8ZKhDxUbnXDK9vLbUPG63jaHtpxegL5kVSYSLpWDtYHgpKIi05+dTfN8/3
 gdoVoAamCH+EW1lkTylkiH3V9/TOshGNzl8AAPRG9JWr/ismNLAKU52B0OKgwiHKNo2d
 aDM/pyc8YWawcKd+vvpVRXzMjejpMUf9iIuW1VrYuZezZjuNMUXutwfQntI6ttN0F/P/
 8jPvjd8HtcvRlNgL8mJ1AbCJO2fhlvaQwhBXGGNxBHI7LULQThkfrI8HtRkBQvMFuHlv
 hMRw==
X-Gm-Message-State: AOJu0YwFYbHeCGd3b87e5QES2+P7ea84aI/VWpCWNVVanx4Tau77P06c
 EbqWlozqeTEoRItp79BQH2Qco83bwQVlmS3pfYn5Sqi48xpqDZwYkGRb+nsHg7wOZg+ecxn2Qui
 Uu+GMJUCeJDwOjT1igUg4Uxrq9ae8aVzHr+N1M6V3Qi7qxAEKhSmauJe6Ae+leP7fwGvEYhbABQ
 p/qceij61itC242ZkIhfgOFC4THjaInZs=
X-Gm-Gg: ASbGncsbrCiuFqa+tQqz1kbA5nLJUXoaRr7Q/940esFmMOFBWkxNrmWXv/SbMe9bG4W
 kgmFC0bBGLTNm5Fi0gfGQIZ/GwFDrGhwv6INSrGJVSyRCRa8Hu1RG4uKXSXJrt6x/FgMaSg5v2v
 J0AEa0MiD34f4HtDE/XX5CTRyfbYkyIgNbsNRLnBsUpSMR9Xa1iPe5
X-Received: by 2002:a17:902:dad0:b0:240:4d5b:29b4 with SMTP id
 d9443c01a7336-245eee53899mr5830095ad.0.1755639437236; 
 Tue, 19 Aug 2025 14:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5jamcCeP0A/NvHgQOEdyTQF3ui+MkBz6LU8QQ/IThnSlKnGZk8Lsj0sSc/S/pJcemgDnlR22du+W+w3tsEW0=
X-Received: by 2002:a17:902:dad0:b0:240:4d5b:29b4 with SMTP id
 d9443c01a7336-245eee53899mr5829925ad.0.1755639436935; Tue, 19 Aug 2025
 14:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-14-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-14-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 17:37:04 -0400
X-Gm-Features: Ac12FXwLdn2EufWVwvGnekBsaZmYWTbEC9CGbVeN05pbqmotLw9p15-T1fJsMD4
Message-ID: <CAFn=p-ZveuA+4X5GkfPBxvcFESH43D48YWTiZnpo3GGKfkd0XA@mail.gmail.com>
Subject: Re: [PATCH 13/14] iotests/151: ensure subprocesses are cleaned up
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> The iotest 151 creates a bunch of subprocesses, with their stdout
> connected to a pipe but never reads any data from them and does
> not gurantee the processes are killed on cleanup.
>
> This triggers resource leak warnings from python when the
> subprocess.Popen object is garbage collected.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qemu-iotests/151 | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
> index f2ff9c5dac..06ee3585db 100755
> --- a/tests/qemu-iotests/151
> +++ b/tests/qemu-iotests/151
> @@ -263,6 +263,11 @@ class TestThrottledWithNbdExportBase(iotests.QMPTest=
Case):
>                          break
>                      except subprocess.TimeoutExpired:
>                          self.vm.qtest(f'clock_step {1 * 1000 * 1000 * 10=
00}')
> +                try:
> +                    p.kill()
> +                    p.stdout.close()
> +                except:
> +                    pass

You can decide how much you care here, but using "except Exception:"
will allow critical exceptions to still crash the program, like
KeyboardInterrupt and SystemExit et al. It's good hygiene for things
that may or may not hang so you can still use Ctrl+C.

>          except IndexError:
>              pass
>
> --
> 2.49.0
>


