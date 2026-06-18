Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA3CD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa8Bs-0000kg-Bd; Thu, 18 Jun 2026 04:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa8Bo-0000kB-IX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:33:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa8Bk-0002h4-0r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 04:33:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8Uikv1278549
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iQotpPyCSFUONpcIBr7HyJtYMcRvPdmgonY3fv39pQY=; b=N3P9Nnpdq6aH0kfc
 Gm6FkCrx5bgP6mDy+zXkZ12w+zB3P32DZzITwOE/3+T83MweFJrtBt1WWDBVE6RV
 CdSvn1EbhvZ3ArnAaEgRkDMW/RwUUD3ipcycR3P9QN1mHhXyNBPkn9/osS0yVP7L
 Wa8RqpLQW9u60mkumca4/57gEfy5ghjbTCldrZohIDiq1QYdOCetWxIj8fXWdEGZ
 5PvOD64S/+Iqg50M6YKe4KtWQYBnizNO9idXfZYUmLSX5DeGTcQ8dpuFljvvxOu1
 bbTY81DueRXIiD4AG9oDDtqWHQe/VPqjTqaW+GspdNCeR7sQB2l0LIjC0giBmLb4
 pceZpg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2juq4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:33:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9158f2c4b55so142836485a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781771604; x=1782376404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iQotpPyCSFUONpcIBr7HyJtYMcRvPdmgonY3fv39pQY=;
 b=GRNfUZAHKu7s6sJFJ7MCswKYeFM8EiIV9nyLieJf1zaqyhXXlxJg7D4xd+s7/7jiV5
 qMvLv4FtO9UQhvAkv0DwyZ5B1Uqd+5/Co+84ImxLWUA7jYtjJ3jfJ5vd8OZVUmVJCiHX
 XsfEsmriz1ePdwoPvBKs3hSPt00AX9HyMe0T+H4A/msQQqPjNYyU7WQ1I1UWS3iaEJd9
 vlUjQPixqrfN11kbHDXaLzCGX7igM5pPlUXV6w6SZLZaMbL4NYBdWXDKLobxk94CT7et
 8Pib5jjBVnrYlltkWescivClH2xJ/+Y3baEMj+mJXHnVWQurwHAIbvrb0zBj3gUdy6zJ
 9zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781771604; x=1782376404;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQotpPyCSFUONpcIBr7HyJtYMcRvPdmgonY3fv39pQY=;
 b=QRcXGXs7eWST83VQrDMvtB3o+AMvONs6qQrI8vXg9dBvM1Hm335ildkYFcPjA5j9w7
 4/3kFQB81zvWHDBH9IYqWEl3XRkrXi3d04rb+vkCNofWsjsBWNcvqVoinACfnFC2VANx
 hOtmQF3yqVO0HTIbmkXjEn9teFe/+MkSVIjJC3XG8bzF1Hgdv9Y4QsWBwCPwpBclWGtj
 WqKvBrX+a7+mTKLhMLYpzY8VgepE+GT5xI5tvzvXw3ea6MsoivxECanCsLy4IeJnDoQl
 lec6CwWTcHbt2BbMhpAVzaW3arWjwuPmmFtS3hQJZX99BHlmn6btCD4w+gqclAi6b4pd
 A4/g==
X-Gm-Message-State: AOJu0YwQBhHyMyWpxxnc+qi0YiV25uIJng1apdE9a91Rc0jnA9BFAdh8
 SQ4Zrq4igSUv26mE2RCAwa+caHSSYGAhSzL7nf0Rrz8gRNlObNSV4lOMGm6hJBfXJnNinSViyPw
 iouQNqsZSOKf60O4MofppffmjiWsPaMDqnGpA1NIZETaYoxSzNpIxvgYvVQ==
X-Gm-Gg: Acq92OFQa8QOKOxv4tS9/Fl2CvzPqE1dfgiXkOKPIKK/awhb9lvVwvQ28zRrIcuM3TG
 epwNjGgexgJNY9OB9ggmO+m5LSg6asnSZi+0FMRJZFXc6bJehhZoQMaaHAyZ0DI3aNPa20EyBHx
 zQZ/HDYpfRUu76mAth9mohFyE7gZKDx97imbnzctz7DzN4PHbZRj8+bH+7UmEDaQfxgQOkQwSAb
 E/ESCJTLa9GuMw6lMuUUjup0URcCkV6d3AdPlWK1kWCSuMJsCPgMOwLLfEkFBf+5nJsA2/W/yHo
 pJpr0JRey0trV2iz3lTGDaJTzftSP6xK72Mf3ECMZD42nVMIVnAZyHqqKcy/oohURubnOXwHzAY
 BQ41SkxivlRjNk5zOXgmSeXcpHNczpnE=
X-Received: by 2002:a05:620a:6885:b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-91f8de8ad0fmr165002285a.33.1781771604632; 
 Thu, 18 Jun 2026 01:33:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6885:b0:917:fcec:cfe0 with SMTP id
 af79cd13be357-91f8de8ad0fmr164999185a.33.1781771604201; 
 Thu, 18 Jun 2026 01:33:24 -0700 (PDT)
Received: from [192.168.69.213] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d9d87sm23179175e9.2.2026.06.18.01.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 01:33:23 -0700 (PDT)
Message-ID: <977b7644-2511-4ded-9f7c-81dd610b6f04@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 10:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5 qemu] GNU/Hurd support
To: Damien Zammit <damien@zamaudio.com>, bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
References: <20260208055858.2166524-1-damien@zamaudio.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260208055858.2166524-1-damien@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA3OCBTYWx0ZWRfX1XfF9NKuzuNk
 70lJcvbfQ9zA0Hr+G7hSrVUiUr6/9lMOmAHmLjIURetXPjqwa3U+KY+y0PVKveY2emliAsJhZfG
 CAjTREI7YSNyMkv6huT69UMdfeGjGhh7rhAOp2hbh+u8HgLM+p2DBh58ug+N3ZYX3h8p68iSyKq
 hRse1E7XlgdebVzNXL3SkkZREYArBnrXIFd4Z9nOBDc+UXU/mp7kvn1hbsTP14+jX8vsbhfd3A3
 p7T0nIDgJEcTJykVcgvMJ8CHUgAel+ebwcvPNxX8nYRCsxvJijxcY4I7Fb4F6gZsdsie8NyGLAj
 +laq7g7LYY6IjSQBxM88XV8kNfsCxfUb/EeQP9+HH2GOIq6zaXBn+7TnISYBXVy6sHiWaxdDUIb
 DYOd/+cJThRipB9r+WSTKBeq0nYduqXhgtW5qYKN72RibvgptRGLUrTKcOeCAWtSw4g426YKeiV
 xWTDnGLZu1aU7CvHjlA==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33ad55 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KvG6bqRRxy8NK_BgXPsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 7JTRqeDya_4jroqYJ420RzwUhL066aDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA3OCBTYWx0ZWRfX+NsLKtFZWjB7
 yjx5coVGYR9rzy3jZWDqmiOlFRloohrsMhilE2LzLm7ExSv5aEDrIcs2uaOZf2pUVxTy9Zkbg74
 hw8oLey8mwt1hjiy+hgwakjnuONjplY=
X-Proofpoint-GUID: 7JTRqeDya_4jroqYJ420RzwUhL066aDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Damien,

On 8/2/26 06:59, Damien Zammit wrote:
> Hi,
> 
> This patchset is hopefully my final attempt to upstream qemu support for GNU/Hurd.
> All review comments have been considered and addressed in the patches.
> Some people want minimal diff to tpm header, others want me to delete code.
> I went with the reduced diff because it's only one line of code change to fix it,
> and passed review originally in other attempts.
> 
> This has been rebased onto:
> * cd5a79dc98 (origin/master, origin/HEAD) Merge tag 'for_upstream' of ...
> 
> TESTED: Compiles on GNU/Hurd using:
> 	../configure --target-list=i386-softmmu,x86_64-softmmu
> 	ninja
> 
> Executed qemu-system-{i386,x86_64} on GNU/Hurd x86_64 successfully.

Could we get this configuration integrated in our CI to be sure
it won't bitrot?

See how we test OpenBSD or Haiku for example:

tests/vm/Makefile.include:28:X86_IMAGES := freebsd netbsd openbsd 
haiku.x86_64

Thanks,

Phil.

