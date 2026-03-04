Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692DEFCE33
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqQz-0004KC-DV; Wed, 04 Mar 2026 12:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqQy-0004Jm-3E
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:54:56 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqQw-0008Gj-GS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:54:55 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b935cd1c6f3so1102053166b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772646892; x=1773251692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yp2wCDfkX52PE9xLXYKB/g+kAscR2K6+4gWi9pa63sg=;
 b=s1LvLjhuNVfSEuLihMpVmRU/phTfKgvK6fkBJOo2b45Gcr8om8FU1GFB076aJwpHwb
 zJKx4s3gKkth2YPZPTC2sLdcMx4kyXa2TKQg3+sfmjKSTxpyOu0qux4gZHkJltooe7qq
 tPcDdcMZnfetj00Bx4KU80/DioWLPnwCILrI1pFWhP/X5LtQ9F43vetU9B5Bq0DOcK0q
 uq7AkyVJcKpSd3GNYRIoBRhBriHyCUGLmq8omRyHBxz085PF+zVlyDf+ZhhfzaVFqoq8
 3UTmuy9v+VSqLhh42d+EpQzKiqupHfQuDELVP3ylpOBHY2RPsqVbzPCEBIi8SSdNcUWb
 O4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772646892; x=1773251692;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yp2wCDfkX52PE9xLXYKB/g+kAscR2K6+4gWi9pa63sg=;
 b=p+GehUijMCi/B5x7wKvrJbj9Qph5t2N4f4TMSz8vsLct1BBtzLgODd9Cs1kdP9il4j
 XBxEA/UqGSNILoCNkT8NP4A6OW4RJiQBdXBMpWcEORCdCT+FaJ3fL7qm79eOQUGWKLCa
 vKER8C9q2sm7aY3bImJ5v8N8Okyn9TQ+HW4ftEJMzgDT5kzLPZwsEMyzXft1iwyKJy6b
 x0KYuNTv2umVWfKCt0e3M2yfi41YHpz8LzUrFEyz1iOCcBjXJmyMxrI7emcCKN5Zllg8
 fJxfovUS6V3uXnwJlx9Zm+rUX1DOivZ8guwO5eLPQ43xuVvK1NXIC3qTKwexotuFXdir
 e1fw==
X-Gm-Message-State: AOJu0YzZd99GJAtF4PhwuVhO2rjD73jgyGbMs0votbqUytm+HxrS17TF
 pA93xsKkNbMSQSZO/Z9MruIe09yw9bHR5CWVYTtdk+He5rqHysEPxRiXxKGn5EmADyw=
X-Gm-Gg: ATEYQzxFMjvIq+pIVte+vG6q4cEukLjgl7FxhMV5iHpRVB+U4Pqz9ptahvkltXAgOaw
 MLGz99RGK/Na+UX2fljMPn/6pQDMyPogDxod44kzHKvcTCD/x6XtTSW8bp4aUDl+QMlTBpG8iiA
 5YAZwBYwbiCxPEdqa/VmCxruj0eDpYBLdASNjwAwerUx1uzm+VA60D1IUkEZrFhrNQG79QbL+EF
 v9dm5elD0qqEnWTGTVVviut5Wuqf3xSBTt23JbFkcZZXp2waG+/KJuzbwzwHiQHM9l7RZ2MNsWF
 vR44qeecPGlH9sj8pG0mXkPGpXUSZPrvmWh2TdStk9NqtZq/qlZa2BTIkV5WtXuV9jG60NQzyhE
 132qRQlPXQ4cP1Ese1/3l6+H9TZWtUP7kYtm8ByY1pyCjfrO8CnE+ZZ8hVnQKuySKiVf+HEFszI
 s79+Gcadfmq90MUiQv9Nw7iL+oWXf1ZWMOWQ==
X-Received: by 2002:a17:906:6a28:b0:b73:4fbb:37a2 with SMTP id
 a640c23a62f3a-b93f11bb9e1mr190841966b.5.1772646892489; 
 Wed, 04 Mar 2026 09:54:52 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae612f7sm792530566b.36.2026.03.04.09.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:54:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B8345F832;
 Wed, 04 Mar 2026 17:54:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com,  marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com,  sid.manning@oss.qualcomm.com,  ale@rev.ng,
 anjo@rev.ng,  berrange@redhat.com
Subject: Re: [PATCH v3 0/1] Update hexagon cross container to 22.1.0
In-Reply-To: <87tsuvo509.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 04 Mar 2026 17:53:42 +0000")
References: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
 <87tsuvo509.fsf@draig.linaro.org>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 17:54:51 +0000
Message-ID: <87o6l3o4yc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Brian Cain <brian.cain@oss.qualcomm.com> writes:
>
>> *** Note *** that this patch should not land without
>> "tests/tcg/multiarch/linux-test: use portable alternative for dirent64",
>> a newer musl present in this toolchain exposes this test issue.
>>
>> Changes in v3:
>>  * change debian from 12->13
>
> Actually I meant to grab this one, but I get merge conflicts :-/

Conflicts with:

e2d4646a026 * tests/docker: upgrade most non-lcitool debian tests to debian=
 13

>
>
>>
>> Changes in v2:
>> * none -> v2 was unintentionally chosen for the first rev of
>> this patch.  :(
>>
>> v2: https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.ca=
in@oss.qualcomm.com/
>> v1: <none>
>>
>> Brian Cain (1):
>>   tests/docker: Update hexagon cross toolchain to 22.1.0
>>
>>  .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

