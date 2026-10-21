Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7F606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sNd8s0Nt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUMS-0002FN-6q; Wed, 21 Oct 2026 07:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJUMH-0002EG-RI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:19:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJUMG-0000K8-48
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:19:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1ec92f655so6754375e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792581585; x=1793186385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VK7sIs9p9eEIMxZVA75Zagqe1JiWYStkjUv52yC1C3E=;
 b=sNd8s0NtKwrflbQ6ua82jYDWqcCm9kooAvqXVi1m6wa7OMVNpwZSBbbKgPj/+K1zvU
 Ax3oXRxU83c6KpE43Wby7cr6eGX6Zym1kAGOI0RPUFl1SaJ7U8lVq/azs+yn7jTSJ/7J
 ErbwW1TN40gOu8GG4/w72W8yzaGf0wfeLfpw18V8SErm9C4xvXL8GD5kBoBvm+0tsAFn
 ugQhH60oSYbnS2qcDSvh1IgjSODuwLBqKuGuTWNQN/EKnCwDmBXcgF7X79HOe5mdHhbP
 43/ae/ihxjiwvqjVy5Vv5ewcMJR1wW5YKcIYv1/LF+GVbovBW9KZ7wrd7f8wv7pOJvCP
 Sydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792581585; x=1793186385;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VK7sIs9p9eEIMxZVA75Zagqe1JiWYStkjUv52yC1C3E=;
 b=h5bDd+/aybfUOWpqQdniItTneEQoLPiiS/2PYbWT8OOZn+8OJwlEnkXeMVkI8k2upu
 6XE6RQWCTh6uU40WzrYS4c0aJMeowInJ1VBsR/UuvvU8qiiz4/7h1q2gCxOWyLhxdjYa
 qntrUJqWieQGz7eazHczinQr+czKDZxSeUe36W3UTaY9IynxBJh4+rbn76RBHx5rotcN
 8cXHSTUKLylLCxkhsw8lquRn2nOjUlxyuA4nBr7O1vmsxvzZg6fNmf0ZiKRu5es99Pn/
 6QIG4DCd5ocaHe4O5a8SuMVF+UvsGYTzZvvtsyOeJvlq+wvRrPyX7BP21bqVy3tkp/zN
 Hv5Q==
X-Gm-Message-State: AFq9FYKFvx4oF+fGIsAUBMk3MORy00hQD3tAlnA1GcSoiNFU/dfTcmQX
 SH19FhaysCVUMj2peTuyYMSAQpgdzyoev3skadzcvCWqohAFNB6s1nwo9MPHy04xDI8=
X-Gm-Gg: AYBFou23muT5SCdOY4LATheJEWSgYNd/Hs4fJysDmOnEgVXq/iha06Q7rkjWePovaU8
 GT5Xc5DfmTzkpsG6odcpZdHR+FHFVezACXNgNap4Xa31vzgIiTFSyJNpTz7KOq33rqnDVGWv63u
 44QnOgK6gOqnx5kG6r18ywuC4b29kMkJkMSVcAFBsv3GvqXwxOVjIoHv5FIX+5telGQKRE1nLCC
 e9iSyp2c+XN+Zkz3+B5RoMheC4u3aw9tlKHdO7g+P5m3w8UqHf/mGVwuBY1V5/as43sr8QHCb0H
 +4NZYwQcyEMDJ9m13SDNkHeeYVQ4lk+27NivVl/OvKg9KSCjfkuZgCtLiy5bj533/K98WVPFOkH
 f9P7fJrFC56e18tVEh2bINS2n0ilfyPTrnXpRF5oy6csV4I7dcjvHwMaxV5CdsKtrl7ojxYBO/8
 pE4hAwTnbg608ZgOnT8J568fIICNzDOtqXYhggBHC/kJdPk1NSbYW70YFUT8LXYeI8AMZucXYUH
 F0XbW5YF+vn764WoEGM7lzbR6HKN6znPn+t+qXrM6kZTw2m7eUyVNs=
X-Received: by 2002:a05:600c:46cb:b0:4a2:158:1e8 with SMTP id
 5b1f17b1804b1-4a2015802b7mr14037985e9.13.1792581584578; 
 Wed, 21 Oct 2026 04:19:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm5136107f8f.6.2026.10.21.04.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:19:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E9ECD5F828;
 Wed, 21 Oct 2026 12:19:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Gerd Hoffman
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Matthew
 Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 7/9] glib-compat: fix g_autofd fallback warnings
In-Reply-To: <20261021-nohmp-next-v2-7-85471fca83db@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Wed, 21 Oct 2026 11:51:10 +0400")
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
 <20261021-nohmp-next-v2-7-85471fca83db@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Wed, 21 Oct 2026 12:19:42 +0100
Message-ID: <87a4o71esx.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The g_autofd fallback is warning because it uses symbols from >=3D2.66
>
> Fixes: 1599015a7a1a ("glib-compat: add fallback for g_clear_fd/g_autofd")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

