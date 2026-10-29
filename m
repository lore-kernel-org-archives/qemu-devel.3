Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88D606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xBfxJg/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTu5-00018J-96; Thu, 29 Oct 2026 13:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMTtT-0008QP-6c
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMTtP-0001Va-VW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso20600365e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793294782; x=1793899582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qD1e0wQvkGZQVWGQVox4zxh1YRfmW4ygvKq6lDPuVbM=;
 b=xBfxJg/qh9GbCNDg9I2DxSLXuLsiJJjvBLpV1heMqiAzQfvyIWMI0iMt+XvFeT83uH
 suln1Anrqp20UHlzWEXWWfTAxOeA1exfuXz5w50kGPuDLprgZySMTxdpxx8YlyYQpTEH
 KKYnXV/sx9K1ApmXAg+Nh5YCGl5g+VciwJ7ewKvJ2N99W2xB0JU1fp40Gjfsy5UB6IiU
 4mjpG1xchUpTWLjFFEcG0+Do6pRaRUsXoNHbQzks65zcvsAl6mAAD1FyQ/4crcWeE+TX
 512MormuTmk45kPp8DQTxI6/VVq+HtXblm4lddIQ8K5zbZInEap0q4wQvQJkoZu5tBXu
 ejww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294782; x=1793899582;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qD1e0wQvkGZQVWGQVox4zxh1YRfmW4ygvKq6lDPuVbM=;
 b=r0WXrkkPCqdqCR8xFARjmMWNqSecNO1dJqQuWust3O1QEj4aIn2ecbAtN/OzSy/ONu
 dA7NDBQx5mZcuYn+wqs+RjiG+6QW6PzZfqocNqdwDNFz+O4QnbLdwFjCseHVECCVrw7+
 UwrRF7Y0VebG2pTbYfkV6zpiM4vq7N1ThuhL4JxYeWMW4YjEpoXmqwnpF0NBfo1D+wcR
 uHTkYwLt5nw9i00EvaxboboBQkS7XyF5OgOsZxoM14x8RlliUyUsTcWcx6FqtkJYVMIg
 efPh0iP8qfUVs74WxhcHJSUCv1kS47nVPSVGyrRR0o1okKz6Y23bgdRDlPbhXZWaFbLS
 ojLQ==
X-Gm-Message-State: AFq9FYJLSTd7cVvbmzxJolyOmIqrEjrnOY1tE/nk2+W5LDLWu7Xr49zZ
 nnWRIILDp05Q2IfGml+E5PjxPK1GQEuYZTMENH4C0WRppgQ6FmJD/X6vfe350NknNws=
X-Gm-Gg: AYBFou2AsTSwVYgGQCXHfaH3GJMscp7YhbXMbxl1m7swYFSngrpvNWQRKbW7jRnZ/yD
 NkhWBhH1AQK2W4pcaGKsvdvr3Tx0H0PuOKmIz1XG7kJ3G8Zy5GowIaubGMuKbMbb0qekIkPldbQ
 AQ+BZNtF0tWwNT3dEmKU85lR8tIM0sYTGWpQ7znO+ZXmseYJyvFbN2r9TiqlaYCqGmsumiOL5ug
 ipECZrv0c5ZL9lvfOidNNv2eB21Zkk9KEbR2IdgN9gGZ1kPFAZe7LDCtHU05AbaQTE4GEFqdnbT
 rBbcf1FpEydfMTc/MTIeZeVCoijqyEpENnQFDtEE6b08mjn5u4QTyC6n4rdnHgANU1u+iRvUvdI
 K3i+Iz/k10UvkAcMNc7/tgRrq9o+iw6VnpnYunaEuysnwCHnVzRaGLvLV6yE5dxFKwoJ0L9xPu6
 PzVIN/F979TLJeteNk3hRN+bVIrrqqqt/NAhDRqyqr7+L4Zd1HP53n/ZgfJILQJyBCdkxNjKnDO
 PwcrlUEvq51Fjm/tHqqNFqKeVUAZvzdOAi1x8DwWKpObelVA9n3g5aucN0XlZ/3q5RKp0oEOUSC
 fqVH9PgtIICAB2rE2V+WgC9XM/E/VUIiia+9B2mlYJ+QIh6fwQ==
X-Received: by 2002:a05:600c:8b63:b0:4a2:a8c:22b0 with SMTP id
 5b1f17b1804b1-4a9643d5090mr133956915e9.1.1793294782083; 
 Thu, 29 Oct 2026 10:26:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm78550475e9.14.2026.10.29.10.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:26:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C82E45F898;
 Thu, 29 Oct 2026 17:26:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Chao
 Liu <chao.liu@processmission.com>,  Tyrone Ting <kfting@nuvoton.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Hao Wu
 <wuhaotsh@google.com>,  Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/8] scripts/checkpatch: validate fixes against
 origin/master
In-Reply-To: <c8bc6def-3c86-4fac-a84b-6664d40d5006@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 29 Oct 2026 09:12:23 -0800")
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-2-alex.bennee@linaro.org>
 <c8bc6def-3c86-4fac-a84b-6664d40d5006@oss.qualcomm.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Thu, 29 Oct 2026 17:26:20 +0000
Message-ID: <8733toa05f.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 10/29/2026 8:13 AM, Alex Benn=C3=A9e wrote:
>> The current check for a referenced fix commit relies on the developer
>> keeping their master branch up to date which is not always grunted. If
>> you create your branches directly from origin/master this will keep
>> failing.
>>=20
>> Given that origin/master should always be up to date (module the
>> developer eschewing convention) lets use that in the test instead.
>>=20
>> checkpatch complains about the line lengths but this seems to be
>> standard for the perl script so I didn't try and fix it.
>>
>
> Or... you can use something else as origin, with origin/master not being
> updated, and master as a tracking branch to upstream/master, and in this
> case, this patch doesn't work.
>
> Using master instead of origin/master has the advantage to not hardcode
> what your remotes should be.

origin is the default when you clone a repo. We could get really complex
and query the tracking remote for the current branch. But if your deeply
forked then that obviates the test.

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  scripts/checkpatch.pl | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 82f62f60212..60e8b6bf7bc 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1913,9 +1913,9 @@ sub process {
>>  				}
>>  				if (which("git") ne "" && -e "$gitroot") {
>>  					my $hash =3D defined($cid) ? $cid : $orig_commit;
>> -					`git merge-base --is-ancestor $hash master 2>/dev/null`;
>> +					`git merge-base --is-ancestor $hash origin/master 2>/dev/null`;
>>  					if ($? !=3D 0) {
>> -						WARN("Fixes: commit $hash is not an ancestor of master\n" . $here=
curr);
>> +						WARN("Fixes: commit $hash is not an ancestor of origin/master\n" =
. $herecurr);
>>  					}
>>  				}
>>  			}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

