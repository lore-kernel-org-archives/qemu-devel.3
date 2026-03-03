Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E98EDA6BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxThW-0004jx-1H; Tue, 03 Mar 2026 12:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxThK-0004j8-00
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:38:19 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxThH-0007rD-QL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:38:17 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65f90233e28so10781335a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 09:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772559492; x=1773164292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/z0dXxvGl5QsPtn38cyS8n1CQBtfBfnYJVYwjxwfi0=;
 b=sko3JRzjDgO8nvN9XovuEUpZVoES1kGRmwvHfEQaEAGAcz4b3aqTZsCCrUPftkBzOy
 WipjBXP2JoynbbcazDgxQ3NGaK+yfaQWtGRF6rdv4uPQ6nM4E1Kjd+5sSBH741L2gu0r
 z8Mh+/qtjxG8Fp1WNgy63JHlFSojxZk4BVli/rcY/O35Snc00XaBXsEkmLci0T3upQX1
 7r+ij2MCdSi6NzeYYDJYRWKWYNc6SS4agDzLRMsy3ClyOmdnMIAsZgIa2pvQf5hM485L
 usPYjjJg11Z9YlALkJMIHp3kcgskfIlTY67xLJhVyDsAtkPEoGa5V2rgwnrbA85JFoko
 u8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772559492; x=1773164292;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/z0dXxvGl5QsPtn38cyS8n1CQBtfBfnYJVYwjxwfi0=;
 b=XCsYBTrCBptQZjswuwe1uhuw+Mawg0Hkws3RIAEin7NBOgVOQxzmncD1qBHyZJnMXm
 4qkUIpqk/BK3XkwKXsmWhC/pzJPbuvg/2P+sDUwi44sVjbbn64S4HUvxqRHVzhR60Eds
 yK3JqNTDUGsdBzVJxMDRvZtHhI5Ec487E8/Anz43W232gsCb+n2KDkocqVzZEosA9e1n
 DHuetAoLj0g7ARHlPOyes+xHDYBiMCPxa1z+wKYDFQbbGUtDfbFU4TiTG2TKoVNlw7CM
 nbEZTap5NkFc5FCOEkSC2WykFhJGKlJGo6Gb7klSqQOPiG9B+KSDOj86F7wXl4uqyQ4L
 ywPQ==
X-Gm-Message-State: AOJu0Yz4StGYzyLfnBpe01FniM0hUm9blfjcNWfGyMIh1HuPAc1WUl2a
 T+Z/1eeUtVV7kAM2ynmRgpaOX+ivAe32AQMDPxe/dCJ+l0ovznuYbRgDS5gv4/xBV7M=
X-Gm-Gg: ATEYQzwLYabbBx1k7cBX6Q+3AEkSpLRGBEupq+XdECOTUxWs7SBWSJ1il9kJeNHjZia
 DToQJg9cKqBF/jAYOjTEZUFTgoeivLm7ISF8LuRaVoX3ZZu5J2urADLUJRUUH5hTBSdMfoz2TIf
 f6VCA6CNeh+3K2yDBDUgADCvODIoAtedJduoHIjsDfnyr7rGu5WmD+nNelR4nMAkmp8JWCj1nrR
 I2gdw31bY8at5g7jo1wBDFI9aVGHrNVFL2uUUsheb9WW9QvqQA0wiut40ABQL/HVPXKS6BRldMG
 Hr7GLc8q2DjR0z8hvGVahDajqwJdtIUXkOs9t5y2HzF55k4nahTwjGvApZ/1R+8JO8mgOFDk3SJ
 fsdglrSsq7XYoZKpdkDzTMQx7eAB8k66+Ne1uuQb0VHr5Pst1sPv75BRQKFe+vDjKfm9pAW2vpE
 55E0hlxux0c8aElnqAHtsHobk=
X-Received: by 2002:a17:907:2689:b0:b93:7189:b83 with SMTP id
 a640c23a62f3a-b9376544a7amr1242706166b.44.1772559492083; 
 Tue, 03 Mar 2026 09:38:12 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd361c3sm4547722a12.2.2026.03.03.09.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 09:38:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7E4405F7BE;
 Tue, 03 Mar 2026 17:38:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 3/5] rcu: Use call_rcu() in synchronize_rcu()
In-Reply-To: <20260115-force_rcu-v3-3-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Thu, 15 Jan 2026 14:38:52 +0900")
References: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
 <20260115-force_rcu-v3-3-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 17:38:10 +0000
Message-ID: <87ldg8reyl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> Previously, synchronize_rcu() was a single-threaded implementation that
> is protected with a mutex. It was used only in the RCU thread and tests,
> and real users instead use call_rcu(), which relies on the RCU thread.
>
> The usage of synchronize_rcu() in tests did not accurately represent
> real use cases because it caused locking with the mutex, which never
> happened in real use cases, and it did not exercise the logic in the
> RCU thread.
>
> Add a new implementation of synchronize_rcu() which uses call_rcu() to
> represent real use cases in tests. The old synchronize_rcu() is now
> renamed to enter_qs() and only used in the RCU thread, making the mutex
> unnecessary.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Can we have an a-b or r-b from the RCU maintainers for these changes?

> ---
>  util/rcu.c | 51 +++++++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)
>
> diff --git a/util/rcu.c b/util/rcu.c
> index acac9446ea98..3c4af9d213c8 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -38,7 +38,7 @@
>=20=20
>  /*
>   * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
> - * Bits 1 and above are defined in synchronize_rcu.
> + * Bits 1 and above are defined in enter_qs().
>   */
>  #define RCU_GP_LOCKED           (1UL << 0)
>  #define RCU_GP_CTR              (1UL << 1)
> @@ -52,7 +52,6 @@ QemuEvent rcu_gp_event;
>  static int in_drain_call_rcu;
>  static int rcu_call_count;
>  static QemuMutex rcu_registry_lock;
> -static QemuMutex rcu_sync_lock;
>=20=20
>  /*
>   * Check whether a quiescent state was crossed between the beginning of
> @@ -111,7 +110,7 @@ static void wait_for_readers(void)
>           *
>           * If this is the last iteration, this barrier also prevents
>           * frees from seeping upwards, and orders the two wait phases
> -         * on architectures with 32-bit longs; see synchronize_rcu().
> +         * on architectures with 32-bit longs; see enter_qs().
>           */
>          smp_mb_global();
>=20=20
> @@ -137,9 +136,9 @@ static void wait_for_readers(void)
>           * wait too much time.
>           *
>           * rcu_register_thread() may add nodes to &registry; it will not
> -         * wake up synchronize_rcu, but that is okay because at least an=
other
> +         * wake up enter_qs(), but that is okay because at least another
>           * thread must exit its RCU read-side critical section before
> -         * synchronize_rcu is done.  The next iteration of the loop will
> +         * enter_qs() is done.  The next iteration of the loop will
>           * move the new thread's rcu_reader from &registry to &qsreaders,
>           * because rcu_gp_ongoing() will return false.
>           *
> @@ -171,10 +170,8 @@ static void wait_for_readers(void)
>      QLIST_SWAP(&registry, &qsreaders, node);
>  }
>=20=20
> -void synchronize_rcu(void)
> +static void enter_qs(void)
>  {
> -    QEMU_LOCK_GUARD(&rcu_sync_lock);
> -
>      /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
>       * Pairs with smp_mb_placeholder() in rcu_read_lock().
>       *
> @@ -289,7 +286,7 @@ static void *call_rcu_thread(void *opaque)
>=20=20
>          /*
>           * Fetch rcu_call_count now, we only must process elements that =
were
> -         * added before synchronize_rcu() starts.
> +         * added before enter_qs() starts.
>           */
>          for (;;) {
>              qemu_event_reset(&rcu_call_ready_event);
> @@ -304,7 +301,7 @@ static void *call_rcu_thread(void *opaque)
>              qemu_event_wait(&rcu_call_ready_event);
>          }
>=20=20
> -        synchronize_rcu();
> +        enter_qs();
>          qatomic_sub(&rcu_call_count, n);
>          bql_lock();
>          while (n > 0) {
> @@ -337,15 +334,24 @@ void call_rcu1(struct rcu_head *node, void (*func)(=
struct rcu_head *node))
>  }
>=20=20
>=20=20
> -struct rcu_drain {
> +typedef struct Sync {
>      struct rcu_head rcu;
> -    QemuEvent drain_complete_event;
> -};
> +    QemuEvent complete_event;
> +} Sync;
>=20=20
> -static void drain_rcu_callback(struct rcu_head *node)
> +static void sync_rcu_callback(Sync *sync)
>  {
> -    struct rcu_drain *event =3D (struct rcu_drain *)node;
> -    qemu_event_set(&event->drain_complete_event);
> +    qemu_event_set(&sync->complete_event);
> +}
> +
> +void synchronize_rcu(void)
> +{
> +    Sync sync;
> +
> +    qemu_event_init(&sync.complete_event, false);
> +    call_rcu(&sync, sync_rcu_callback, rcu);
> +    qemu_event_wait(&sync.complete_event);
> +    qemu_event_destroy(&sync.complete_event);
>  }
>=20=20
>  /*
> @@ -359,11 +365,11 @@ static void drain_rcu_callback(struct rcu_head *nod=
e)
>=20=20
>  void drain_call_rcu(void)
>  {
> -    struct rcu_drain rcu_drain;
> +    Sync sync;
>      bool locked =3D bql_locked();
>=20=20
> -    memset(&rcu_drain, 0, sizeof(struct rcu_drain));
> -    qemu_event_init(&rcu_drain.drain_complete_event, false);
> +    memset(&sync, 0, sizeof(sync));
> +    qemu_event_init(&sync.complete_event, false);
>=20=20
>      if (locked) {
>          bql_unlock();
> @@ -383,8 +389,8 @@ void drain_call_rcu(void)
>       */
>=20=20
>      qatomic_inc(&in_drain_call_rcu);
> -    call_rcu1(&rcu_drain.rcu, drain_rcu_callback);
> -    qemu_event_wait(&rcu_drain.drain_complete_event);
> +    call_rcu(&sync, sync_rcu_callback, rcu);
> +    qemu_event_wait(&sync.complete_event);
>      qatomic_dec(&in_drain_call_rcu);
>=20=20
>      if (locked) {
> @@ -427,7 +433,6 @@ static void rcu_init_complete(void)
>      QemuThread thread;
>=20=20
>      qemu_mutex_init(&rcu_registry_lock);
> -    qemu_mutex_init(&rcu_sync_lock);
>      qemu_event_init(&rcu_gp_event, true);
>=20=20
>      qemu_event_init(&rcu_call_ready_event, false);
> @@ -460,7 +465,6 @@ static void rcu_init_lock(void)
>          return;
>      }
>=20=20
> -    qemu_mutex_lock(&rcu_sync_lock);
>      qemu_mutex_lock(&rcu_registry_lock);
>  }
>=20=20
> @@ -471,7 +475,6 @@ static void rcu_init_unlock(void)
>      }
>=20=20
>      qemu_mutex_unlock(&rcu_registry_lock);
> -    qemu_mutex_unlock(&rcu_sync_lock);
>  }
>=20=20
>  static void rcu_init_child(void)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

