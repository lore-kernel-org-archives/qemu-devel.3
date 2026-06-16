Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95615CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYKZ-00061v-IA; Tue, 16 Jun 2026 14:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYKX-00061l-KK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:16:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYKU-00014T-TE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:16:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH8wUe137530
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jfOJm7GaT1PAuY3BvA6aJeQ4/adrf/+H1sWD7NnHeDo=; b=LnLWTBC0gXOVrKyR
 pZi8CSOTjBExsh6lOvmdWpKhY+w540Fsq9w/DABD3eJPyu/7xNiBVn7a8NQD8/Qx
 Hclm1SI6rNZPHe3hgxjypK8K20zAc9WYrDnAYzCTE4jr3w5s5K3NdsurEndoOaTC
 ESovScllm6QQyb/CTsAgiE1FsK5luZzjDK1zQhXT1XGkZeJXpp7LBS5Xnhi0z4Vj
 DDf8WUCs5xhjNrpjlrVaX1gmstsmXjFVd3/EO0sn4AJKSjZKiS3x7OY5o60r/nIc
 lzavkKHPAqgyyk69m8iQ63Jbe2OYgUkrR2x3bociUfQoj16fVqPEHNign9gg+Xsr
 OSILiQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb35t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:16:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-307fe856724so2909984eec.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781633763; x=1782238563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfOJm7GaT1PAuY3BvA6aJeQ4/adrf/+H1sWD7NnHeDo=;
 b=C0vtFftzDfKQ9pkHulYO1LXrZgusGMPQ0tueSDgyE2iHMFpCfleaZgqQgudDzcT8g2
 zzO8K/pO2raTLJwRq/XJ3X4j/adno3ifchMmaS+L+a5WNJxc7bXhKZhjA1Ii4RK48Q8p
 QrBPY2ouqlyv1AKBhzONnzbltgjod0nPzjtCsbOxx+9dDx+FB1fKBn+4qbzSwtqDbc19
 O22jt1rvvn2rpyalffSoyRwzQ2Iyl8iRGxJA9fCqOqmB7af5fPQswixo7VEw6UwQTYq4
 8XzsVaJG+A8hAjbZsvfdO4/gZOCRk/bcWzKWJ1nE+m95FYCBL1RDTMIjhQCHuzBFgcTu
 thxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781633763; x=1782238563;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfOJm7GaT1PAuY3BvA6aJeQ4/adrf/+H1sWD7NnHeDo=;
 b=sd9rW9FIlLVgFsBvoxLqvlHVWu0F7+NiI74b6ZNP1bSfCRa8np4BtPKAJ1INHF7DGk
 25nKs4PEP5LAyWATvSPzI8RWNHpdxE+bRJUXUpZpoddfrzX98PW9YfZw90anx9OY+D0w
 vQTxemp3VkezPESp6UZGlgo7cQKRWjga1zqV6Bp0f1qEfZMvWqlT84f0GDttMlqL5N9j
 TuM8tgQFk0MUAW3fiaXFUnSI+wz+MlNMF/qZhptX3qjM10Khth7q8lM/4l19mPfi0IBs
 RDlSFnHDN3DgsbTl1mp0VNnqGxKZuBBsIFEZtYXXbV6OdR+317r+F7dGB83H8vWXz7xL
 A2Iw==
X-Gm-Message-State: AOJu0Yzco5yEZtvV1RehRCdf52n9glHiEYsuP1NY90QXYv1I5ECrwmen
 k9V6fE8Gd28ua1/7x0Vt3dLgYVPmFpJHxWjFedp4CBfVBqHEO1/ZL/cTz1XZmLSjlUoXXCIQyf7
 hqwGriIHGeRb3P4SO8XNMy27oyqMSoKVrhMQzdimzntMEDmn8LXTevl+wAw==
X-Gm-Gg: Acq92OE7AyPOxDus1uGasDmw5OhVrJ5F96qnntNojiiN3NS4cFZ9uk2c9hwt08gfYoy
 rZvtQ+JsBwxel/slHZYtx3RDzdZ0QZ4y8P+4jq3wu0fcdGT4v3dxSnPcyWxk5lgGiyoobB99T3G
 lWqYRS1C8K8U6KPpBV8/9xCh6BJfRS7Q1gKs81XNDYLL1/Lv7yheGYHkSGIEViiDRwNHhjiAnps
 Wmk1qIDRyoZ8S1/oflfBgkHM3UwI3d5Jl9z1UGXmZQ1+u2YGj+SHwcU7Mn7wkEKPNn8T10yZK6K
 j7EptsEyl1q6RIoai0kc2kxF+6gxtVQHL0u2k+HvCbZfslG84zJCSmvkJiwNj+q+yJ+/HEAqhEH
 z4VpnjhLmZFX/Trx+ZaEURauLnGOi/sGx2KZ7Gy568FRPmnIR3fGkoI6J+yzE7R5ImFg1P509v0
 x7IF4d3rD3385LPw==
X-Received: by 2002:a05:7301:7c0e:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30bc916a168mr335208eec.0.1781633763007; 
 Tue, 16 Jun 2026 11:16:03 -0700 (PDT)
X-Received: by 2002:a05:7301:7c0e:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30bc916a168mr335179eec.0.1781633762305; 
 Tue, 16 Jun 2026 11:16:02 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e4898c0sm20560200eec.3.2026.06.16.11.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:16:01 -0700 (PDT)
Message-ID: <72a4533f-067a-4539-99a5-ebbc34224167@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:16:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 armbru@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <ajEA4CybcZHwYEEF@redhat.com>
 <CAFEAcA_r2+S+iy4nu4Kv9Gjwsu_izq5iHUYs6vycq=dX-+Cpsw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_r2+S+iy4nu4Kv9Gjwsu_izq5iHUYs6vycq=dX-+Cpsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a3192e4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=Blg2mxtrOvp4FJxsj5kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4NyBTYWx0ZWRfX1Ton02q7/tUl
 7JYMkyHlddjy+AhzLFiR61fyfXhLr2XgXMqgOqsQqsEQy4Lqxpx+PgpQOKxIGycChZ7D4s5W0xH
 PgGei5orTTcy9gmkrHqeBUqJBe7GU1Y=
X-Proofpoint-ORIG-GUID: MaCI3apB0ncFYem6zKwh4VS2eVP-XkFX
X-Proofpoint-GUID: MaCI3apB0ncFYem6zKwh4VS2eVP-XkFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4NyBTYWx0ZWRfXwgXXKdkgdoTb
 QvD2JS98aetYExxA4LAjSOgptiTS8DMvxMt+ZoJBnsbDtVc+52B+6l8L6KhgvdipvlKAvGmnATn
 9Iaky214MDYQGQBI5b77vTuq88lRjTrBqnguzcSEoC6vW33bHCK4SFXKSQxHukWbVftlaEBudNQ
 g+CxqNpCcQJRMXfKi8MTftOHa74+ffk8WdzhJ3MIK+JBEF5fSDctcDFlmZjKkknkOB1Qw0NCDd2
 lIavgZT1sBJ6ShiwrgLyWivJ9qRVj2b7T8mMpn8FheZMRSGXmiRyG0PGiDVUWAK/v+X3RzocnIy
 Qt9z4IGFhzzFdWhjo2Vd69fwNgSGbczDq7Vi1dGaICm4OtI4R4mWgvDGuXGq8KJfmLHCadUNzNQ
 TOZCqWFhHP0Q4Ool0QiNRUvX08jyW5K0sSU3lb39wBu8R2cwQ7MgULV75t3z7bepy0eFFS/zQTz
 qNtJWQpGWyD4vfRR0vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160187
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/16/2026 1:30 AM, Peter Maydell wrote:
> On Tue, 16 Jun 2026 at 08:54, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Mon, Jun 15, 2026 at 01:17:23PM -0700, Pierrick Bouvier wrote:
>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>> configuration time (and not at build time), to not hurt build time.
>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>
>>> We can expect things to be mostly in sync since adding or removing a
>>> source or test file will trigger a configure step.
>>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>>> build things from scratch and always run the configure step.
>>>
>>> With this, it should be impossible by design to have an upstream
>>> MAINTAINERS file with non existing file entries.
>>
>> Accuracy of the MAINTAINERS file is an upstream-only concern, but
>> IIUC, this check is going to apply universally to every build of
>> QEMU which is undesirable. It is irrelevant to end users and not
>> appropriate to check in downsteam vendors forks.
>>

I accept the argument about downstream forks even though they are free
to remove the check since they are... forks.
However, it's relevant to users I think. It's very easy to move a file,
and forget to update associated MAINTAINERS entry, and the sooner we
catch that, the better. Similar, when a new file is added and not
covered by an entry in MAINTAINERS, it's very easy to miss that.

>> In a "normal" modern project this kind of check would be done in
>> a CI job on the merge request, since that's the only place it is
>> relevant. In our case, the nearest fit is the checkpatch.pl file.

It depends how fast you want to catch the problem.
Adding yet another round trip latency to a project that already has a
multi day latency for upstream is not a good thing IMHO.
Also, it brings yet another burden on top maintainers that will have to
deal with this new failure, fix it themselves, or recreate their staging
set for the next batch and wait for yet another day. More time spent,
more noise, more iteration, just for a missing line update in
MAINTAINERS file.

All that is nonexistent if no one can build it if it's incorrect. That's
why we use -Werror by default for instance. And if someone sends a patch
breaking this, you can be sure they didn't even try to build their own
code/doc/test.

Does that open your view on this approach?

> 
> You could put it in "make check", or (if you want to avoid the
> downstream-forks issue) in some sub-bit of "make check"
> that we don't check by default but do check in one of our CI jobs.
>

If argument above is still rejected, we can just add a CI job (calling
script directly). I'm not sure any kind of integration is needed. Also,
not sure where to fit that in any existing test suite to be honest.

> checkpatch isn't a great place for checks that you want to
> stay consistent on because so much of its output is "this
> is wrong/merely something to check, ignore".
>

I agree, checkpatch is not useful to enforce things. It would be
different if it was strictly enforced in CI, but that's not the case,
and won't be given the false positives it brings.

> -- PMM

Thanks for both of you for the feedback,
Pierrick

