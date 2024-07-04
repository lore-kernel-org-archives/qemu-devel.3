Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805E0C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKWT-0004bw-GQ; Thu, 04 Jul 2024 07:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sPKWS-0004be-1q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:21:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sPKWQ-00071o-Gl
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:21:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d3aso1592755ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720092065; x=1720696865; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T0ioiLs5pfHqlFH+w6kJjoyXDC8cGWFPBF7SaH8CYk=;
 b=caYif3BHN/DGVPOR4BPpV8czCccztPfjvId9xs+6+ZznsB02G/d99PjRG3vQRI//eF
 zDRCCsjEQKXVD9nJKif8uswS+ktrma+ysY6//vwCrsHBNQZFWz8dMToHUrwgoOdVCeI4
 2+bclmJ3Fz8ww6vCzXcdXwgEK/VhCjxoSMcDCrUz0hU4PkLF3BbVycyNL2CUQUlsHoBM
 438GbdBfQ0aXsOfbWdN7sG4Wfm6mPcMN2UMLjeS/18uxsJlFvnVJmJ0CeoJYI/9jKN6Z
 zljA2aClsiHs4AtiZou6UMozZqEF51sh0f7N/d8ZIXB8keh/T52erKaBhmvLI1xCopM6
 iaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720092065; x=1720696865;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2T0ioiLs5pfHqlFH+w6kJjoyXDC8cGWFPBF7SaH8CYk=;
 b=pMq5RO5Si9tfcBJPiBr7y30GGXrVluFjNCCGeT6wQdN3tqQweYonf36bW/iZl1N4jw
 e4QAN1FUGQ7VOcnRInltBDYuovuQsFvCnRtNPnHMG6EvBwhaESFojc71aC1TsNaukKOk
 cKCwyfV1vkRdr46rFKPgyKwGa7qaEZpaSYTWXGSOh3H4TKeiUhCH9cvg08DBWM8+50EV
 UrXc05sXI/hpZtvEIb1csSueHFnwbr/gsX2y+RZpog8BjycwtnCtA+PsQbreiqq0WXf9
 GGpHVpn3lZV7Hocb5N47uWFRkF3qAd8j7VtVSxpPXwK+9fvG5k6jiduuddk3WwnLSOBe
 eltw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtzsfmQUJHGfqdtl0imGllKZU514O3TsB3a34J+mgQdvtDR7ssoQo+ZRoGlGNuhABD+1zYT3/38HY1GIhdUZ6J9LE/1Ks=
X-Gm-Message-State: AOJu0Yxxt333VHqcsk3RiF9mjPjCCg8eYEtzvosvvxnFwUdDg/H9IK29
 3aIFO6iUVyXaUBgQveDf1BFOpfOtXcv2kaPfiJYZFTwS5y+V75zY
X-Google-Smtp-Source: AGHT+IF90E1UGQo8SCgludsGP9YprZELy+LV48R2ZQHeWICYJK6X8tEhW5f49/ZEBJW+1F1JIiNAxA==
X-Received: by 2002:a17:902:cec9:b0:1f7:3a5b:2f0 with SMTP id
 d9443c01a7336-1fb33eccb36mr10997985ad.44.1720092064837; 
 Thu, 04 Jul 2024 04:21:04 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d1c78sm122937005ad.23.2024.07.04.04.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 04:21:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 21:20:59 +1000
Message-Id: <D2GPQVG9Q7RY.1HUJR9EC96HWC@gmail.com>
Cc: "Prasad Pandit" <pjp@fedoraproject.org>
Subject: Re: [PULL 02/12] tests/qtest/migration-test: enable on s390x with TCG
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>, "Richard
 Henderson" <richard.henderson@linaro.org>
X-Mailer: aerc 0.17.0
References: <20240702103310.347201-1-thuth@redhat.com>
 <20240702103310.347201-3-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-3-thuth@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Jul 2, 2024 at 8:33 PM AEST, Thomas Huth wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
>
> s390x with TCG is more stable now. Enable it.

Ah, you did a more complete version of my flic fix that migrates all the
state. I didn't see that go by but yeah I suspect that was probably the
correct thing to do. Thanks for that.

Should the s390x flic migrate fix could be got to stable, perhaps?

There's some kvm-unit-tests s390x migration tests that can be enabled
after the fix too don't forget.

Thanks,
Nick

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Message-Id: <20240525131241.378473-3-npiggin@gmail.com>
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
> [thuth: Added "with TCG" to the commit message]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/migration-test.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 571fc1334c..70b606b888 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3823,16 +3823,6 @@ int main(int argc, char **argv)
>                         test_vmstate_checker_script);
>  #endif
> =20
> -    /*
> -     * On s390x with TCG, migration is observed to hang due to the 'pend=
ing'
> -     * state of the flic interrupt controller not being migrated or
> -     * reconstructed post-migration. Disable it until the problem is res=
olved.
> -     */
> -    if (g_str_equal(arch, "s390x") && !has_kvm) {
> -        g_test_message("Skipping tests: s390x host with KVM is required"=
);
> -        goto test_add_done;
> -    }
> -
>      if (is_x86) {
>          migration_test_add("/migration/precopy/unix/suspend/live",
>                             test_precopy_unix_suspend_live);
> @@ -4036,8 +4026,6 @@ int main(int argc, char **argv)
>                             test_vcpu_dirty_limit);
>      }
> =20
> -test_add_done:
> -
>      ret =3D g_test_run();
> =20
>      g_assert_cmpint(ret, =3D=3D, 0);


