Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4382AF9D0C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdSx-0004Pu-Cp; Tue, 14 Apr 2026 09:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wCdSw-0004Pa-3z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:06:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wCdSu-0004Zi-1f
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:06:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EBNt7k3681496
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 13:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0RxmAJe6dLdE8/FOuGKE3BwD5ypwsE+/3qV3Rf+wv+g=; b=b2qmQPX1Atb4RKDn
 tQhNOJ+8aZySYevAnsFaFr1jpDOqPfTJ1AdnKGuIL+Q8SLvq9OVGr1kWLIEmfd5t
 4d8fsnlmJp6ntcCK1AJMIZO/plxiR1sd8JE/ceM7juBjkSRNdBDPaPLp20FBhfOn
 X+WxFu9j3mMsVgCNQLOmZOVcH5demW1Kj/A53f/gS071UojuKdUt0CmcJQeh8T2n
 dkpRMnI4Uh27+rjouvNAgmaQGMChIbmFym53+zRyunmkt515zTtY/WzdnRgn8d57
 t9sd+MaEOwmTagbutfSV6Iu6aEs+gbENLe4rDImcd0va4GRsz1XdDUzTBXtqlrDh
 7LltaQ==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d2s3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 13:05:58 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-42306db7f0dso8215770fac.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776171958; cv=none;
 d=google.com; s=arc-20240605;
 b=C3sjWdfARIK/vKl6Q6DxbqPEYBfKR11hQ0MY04XIxsbkT3lODp8WiuK9K4PNAZZP8Z
 L/0mucL7f4FapnELCsForFeu/XsgtMLaEH/tsUunxzC2OEoDoxBXN8vwTtFZS+OnZ1O8
 93WKjxzLyPtqaEHLPAI+noOUCfIPxWlCCFdxLxB7n63IJ82Q5Rfrepj8/CmKq6Q3hOKS
 43fr0NkzOxwCqHBIRVpuY4GxqhuytRd1jcGf8c72n0FDK8F+sv2kOVXTEmAjvermKzNW
 JqmR42ZfJD7Wjw8IBB9oZpOiPLJ/HB54jr+vON+Mk5aQ+xP6yp/O3Mr/B0YOp+xSLDWw
 woeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0RxmAJe6dLdE8/FOuGKE3BwD5ypwsE+/3qV3Rf+wv+g=;
 fh=YesfOMoVjEIRJ2JxWd+x6zu8qRGVGlQN4RCrIgUBajY=;
 b=iS76Tx0AorgozF9DjbUcE/xsaRtmbE44VJJKPHYS+RfxQmaciWjIUURD3Tx+n2QZYc
 3HN1kE/b1Ek0TSby0P7FPrvxZPw9WTF02VRZuOsjRLYC9h8tN0wPtvn+Iiah29zFjOBg
 B+B0Ch2+sPlDZdvw39aYm7WPKoH5zamuv9pdZY+xoDEchhfFD7YKB8Vt33SllxJkNTkW
 12zT4mfGgzVeNfyHACj/pOovMZyTRdVs4HPVm92M8oCFIMRjHBk55nt09hPPCUfJ/ztP
 /zQylgAniKskCYN0jUAthyH5u+lTW7q40gXqojNaH+qBVzE/X+m+otBTPRVcXFETND0E
 R5ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776171958; x=1776776758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RxmAJe6dLdE8/FOuGKE3BwD5ypwsE+/3qV3Rf+wv+g=;
 b=MWLNvd+8FjNVhjz+/YVxpevgXoarVN1/ksWBmeg5jX0/x7snEQZ5Jf13jP6wViTDot
 GXeqYAvo3BA2U2QK2J21/qA30bRZKcaWRY/VN+d+Zs0OUjFyXtptCQi+ulpg2GgZktKQ
 1Kx5n3Iq6T5QFC9poC7Qu+bOUqeXuS3pgPAbss22lcBSHB5Xxszvztx3D2ud4r9VzRf8
 ICbsZUCuzAHzRRQbb9yo7Ap6JiqKho0LiRzKRSRy1qA/cPNqshQrTGRTzCKrIG5hMaSl
 ufph/AWG9FhjuWiu5IC3/0dNsBh13JbwlUWLUHmHZI9HFllNHT/3sXk7q7SmfNiq4o9H
 eqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171958; x=1776776758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0RxmAJe6dLdE8/FOuGKE3BwD5ypwsE+/3qV3Rf+wv+g=;
 b=Y9FUcXkltdSselPbe5z+bsW4zGdDY/0kM58bjPvolUQYMJb1ETpdPEJe8lW/8ve0Rg
 hpgP86Y2yuoLHEcJqDhbZ7Q9g2LrCHoYvo6p/olq35cDp799+T4y2afVAVCxT4e5EM+C
 IoVh63ZHSGG/P70Upj/d7/Y3WfZsRRP+MaKi+DjBeDjK89KvKEi+P4rvmiiGe71oWIVh
 2EXq1SdgcoGebExSVUBCuDpZJsAyOlcy/w43wcG6OLLU1Q1AqzGYPrfpRoQ6s5RBmtfl
 3pawOqE5qE/2kB4g8ll0+f0ZOA4Ji0JtUxoN8M20WS3uS3XnWVP/m2ZYYjBSy1F/mDO8
 NoPg==
X-Gm-Message-State: AOJu0YyKbIo7nR3nDHxwDvJT+e3z9CFeZ66TlMuzoqwI8V/v16+xb2uY
 IpRh+x8DMuw+k69yBIQTv7rHiIbB6sSQ99nLbv/3IiqiEM5LHnPTLAsiM05UmHwUXOqXh7dYlKJ
 8bdF7+TETMTw7s57+/9j/02PlumTMaSl9mjUPgmzgTtpCnE7l69UVt/FrAJcdGgAW+6pgOo/r73
 AK785HVR8KDCK0Te8jCWNQkVRqvHzW1ui1
X-Gm-Gg: AeBDietYgrB/0Ur8LShgySVcZM0IXnmn2pGd8PgOT0l8Tiif2EFmnOVjv1923x3arh7
 7If/aKdtRZZ5vZS04Kfq7yGNa69FLYSBqyyHdOkKh9PAUgH8zQd0LBbtEy8EadRFVupfh21OD79
 hwjUK/dvfxBhqUogleApOUerDQFaFvjepmofgg80nvoqUNkEdWsfpUsMX7VmzoFeqKiquadxhSA
 mgn0+N9W3mqrMipBg==
X-Received: by 2002:a05:6871:8211:b0:417:304f:5011 with SMTP id
 586e51a60fabf-423e0ec53ebmr9818600fac.17.1776171957703; 
 Tue, 14 Apr 2026 06:05:57 -0700 (PDT)
X-Received: by 2002:a05:6871:8211:b0:417:304f:5011 with SMTP id
 586e51a60fabf-423e0ec53ebmr9818567fac.17.1776171957147; Tue, 14 Apr 2026
 06:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <70cca2a5cdde3e6531e5c8f1e399e0b584d51ad6.1776096073.git.matheus.bernardino@oss.qualcomm.com>
 <79b575cb-5d7d-4e3a-80f1-5b67ac7cad9f@linaro.org>
In-Reply-To: <79b575cb-5d7d-4e3a-80f1-5b67ac7cad9f@linaro.org>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 10:05:45 -0300
X-Gm-Features: AQROBzDTex43H0XoGGsx4IUW7J103hL6FYl0fd4a7H9BEZzqEOA6IpPaf2JF3Co
Message-ID: <CABrGZ+HHZBQzqeh3aHEEQNQ0iWAHmnFYQaN=1R5DLaXJQLUOrQ@mail.gmail.com>
Subject: Re: [PATCH] accel/hvf: fix double hv_vcpu_destroy() causing teardown
 error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, slp@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, mads@ynddal.dk,
 brian.cain@oss.qualcomm.com, mark.burton@oss.qualcomm.com,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEyMyBTYWx0ZWRfXyW4r7PJM0zIQ
 xQYi/7WbOH9E8BXiRaTPCwElp4k8fpsOKJ65eqs7VmxvvmuQLytW/tr20/Z7hDM3BOHWAUKWlI/
 0n/pP6vQ+0IY4sFoMUdTpBqmyI+Ts739ZC80fOHWspxpj8nYpW2ojWFuhPEKsL5M165KgGhHn7n
 FuvIsBH0bzUB899DQ9ivGCNc8XXecGL3xxF6/RUGNvvNPPUPE/AdhH4aYGRDZhgTj7l7YZOPUMN
 A2fA/uEpr4UbrgbTGRYeVv42QjWeYdYkrtJPN6yEXoNG2igtTShkw7ubBYE2GLmFW7yZORrFlIh
 Mq207p/6ejUuN1Xfe5tqaFzHbtUu/U+IfKXwJ+ZVi1V6f/ymjJAgfeA3CdcQdJ4hcWAYPS1HXdC
 LgSbDkVy93c5JxUW6mz0Gpg5RSb3TwDgYEffu+Nwq/LwgnF9Vcin2ZonsXIraUodOVO4edTS8n5
 67ywkkFLbW5slUbmaAg==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de3bb6 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8 a=NuZbqqDDIbgeQlSeM54A:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hfML9Njv7zU-LO1YmFAUl4O7eoMn7z_r
X-Proofpoint-ORIG-GUID: hfML9Njv7zU-LO1YmFAUl4O7eoMn7z_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Apr 13, 2026 at 7:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Matheus,
>
> On 13/4/26 18:01, Matheus Tavares Bernardino wrote:
>
> > @@ -113,9 +113,6 @@ static void do_hvf_get_vcpu_exec_time(CPUState *cpu=
, run_on_cpu_data arg)
> >
> >   static void hvf_vcpu_destroy(CPUState *cpu)
> >   {
> > -    hv_return_t ret =3D hv_vcpu_destroy(cpu->accel->fd);
> > -    assert_hvf_ok(ret);
>
> That would break x86. I suppose I screwed something in commit
> feee55d36a1 ("accel/hvf: Implement hvf_arch_vcpu_destroy"). This
> was part of my split-accel work which as of today I flushed out
> of my head so don't recall well.
>
> At any rate, better to remove the duplicate call in ARM's
> hvf_arch_vcpu_destroy(), WDYT?

Ah, indeed, I hadn't noticed x86's callstack. Let's do that, I'll send a re=
-roll

