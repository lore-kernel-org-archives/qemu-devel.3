Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3F1C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05lU-000639-Sd; Fri, 28 Aug 2026 19:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05lT-00062d-60
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:13:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05lR-0006un-I1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:13:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMT685731508
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8pGOaxUJwlWVf6xWdDjxOB9bi/I58GAA10DuIMydq6I=; b=mLBYTj/L86Sjh+ET
 GCU9hNwEOsTPgafBnfHJD7m1tnepaDteec+03NAz9uJ44QV9xa8Ur27PavXg2kaB
 AjtG8xm0m7tepDQVYUiRGRMXIHJ8xqBgFet41NaksdBzizoerS9Z5h96TGVloBkE
 wwMIktHvo1SSu9SrE6dkmME5OhtBZVYbJUPwILTb6drQYTRoTZ+HirYr2PIPI0lJ
 HiK8QhocDNKlnZaNaFt/6TfJjFeqVZnzoo546DN7xwkyV7AGejrhTcDOT9iCI3eD
 6t40tGCxURM6KGctDvjLrDVsOGON9RpzpuxG5BbxIkVocmJ59+mJsfwUPsGaLz0s
 r6BnJg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbhgtrcqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:13:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-396901263b6so2420041a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958815; x=1788563615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8pGOaxUJwlWVf6xWdDjxOB9bi/I58GAA10DuIMydq6I=;
 b=AMv820rKj1weLrxDx/j5dzK5th4ZwFt7koUOf7jSzwhabodVHWwOBxr8yO0C1Z2nIp
 CeVd7IiAVjQFyCkN27B1rOy34X4x75nOs5yLNeO8I5mpBx9rsVR+dG9uU55IYCS+B8lQ
 BB0h3jrm3Wj3bhIYSQSC41B7ErW4F486eIl5WcoYqmQcuOgnk+etGqiOyJavlxodhkwE
 v5XhGpl8MfyoDdfiVlK9PsetrwfD+feQ6J7mki/V8wrjTTpfb3Gs8GpLa+W5fyqFWfM7
 7o/1Zug2ygRnUuhiU247L5UGw4IWFQDzZ5804vGqr+KS8cWqBOYQcN5uaqV4UaAUL/m5
 V1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958815; x=1788563615;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pGOaxUJwlWVf6xWdDjxOB9bi/I58GAA10DuIMydq6I=;
 b=e+hNj1D5nNbk4ahbuZ1MnO3+Ug3U6SAB1yMe9hUTkQx0Oi9dnNlT4AbtEGcRaS8IlL
 9XwUTvVi2hTyDoG57zl7AROI4cs0UlmawHjGMzlI5Dc7ANseFcfKW7bRqAlxivbScN8j
 Z38i3YX/REptpdw0PQO+vFcLxQbw/1QrC2zAY3Yt5rOUdm4ZI4f+B2MzbbE2SY2Gir7q
 AeM2BrE/G40xqlxz1XqGao0ofdaueZGOZUgvJcc6Qfq/B69eUZi8tRVtG+i3rrqcnQKL
 7a6sQQod2pyMncksnMseVXeYIKDugILj0Zh1l9ORqeShW9uX5R/O+GXSzSgX31zhsh9S
 PoJQ==
X-Gm-Message-State: AFuF++nb9687Bu+zWYUS+rRa6rXKJjayH0mL2aM/6VGQjIEFvtbVFL2Y
 VZe4bYDebxTkdN3pSyFVaUygl2pGP0T5y5t+X+nV7jJONRiF+ziRlIgSeUsjYKNgJ85c62kvNzy
 ww+kz4Be2IbaS6BRcNu/zKqzgHLqh82hFTFTav4nj97LCztRfhfB8JD6L7wkTolSYfQ==
X-Gm-Gg: AYBFou0hK+DuUKxpnAx7vRQlWVsxMWxbIKybDVGfu7835krAThARm1vxG2usWWXnlzf
 P/ft7g18UCXGf99W5GgiYmRa7HRihNwcE1sWg1NwdbQCURRrzyk5iis7Q3pLMxPntEMMDk7+ijP
 lHNGEo4KVNtf3o8okmeqSx3yvpTCPgn9lJIci0l66kyT7sDBDsBFGbHWUqFvrNQhbAQnvehGfeH
 mU46GEbbJFcprheCg4t4PGoAlGta4mlxJ2AOnRaLd4ZNTYHGC56gRpuUY44dgL61AhSZsJhGxym
 WBqS+ExuVcC8IkH62cxjAmPWWE+twju5p7zo1Kl32IX8V3SMC+2rCv6+QO7PMxhVzO9N2lVpAG0
 YXLU62Qsav2uCYEkOgKMnmC6VzbEx/RxLeUC3SZFVlfE+U0xogjF7Vjn1M5XCve+bqW94
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-396d0f75f2fmr19982490a91.11.1787958814786; 
 Fri, 28 Aug 2026 16:13:34 -0700 (PDT)
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-396d0f75f2fmr19982415a91.11.1787958814270; 
 Fri, 28 Aug 2026 16:13:34 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d3fdf6sm10119388c88.6.2026.08.28.16.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 16:13:33 -0700 (PDT)
Message-ID: <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:13:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMiBTYWx0ZWRfXxcKrOl31jKfA
 Q99jg/lSP4fmCGTnDsYar/3MaFpGr8W9XJBLOhFv495lajNVzgdoj56ccsKS6E4+Z7nVm2Pmrqw
 wCLeHV75QVsAAV7+qaH/bnPZXdw5yHA=
X-Proofpoint-GUID: UE8T13HLEUNyzsBApGDaJBQKejLfdl3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMiBTYWx0ZWRfXxuFCkg9aFWfk
 IdlOTyXHzwJwOzwbvOWt6eEbXBihZzKP2dLaKBl56GX5EIHeNu/Op6Vn4GiefzwtSSIKcQKEY5C
 SX7AYCe5BkM+bejj7FxlNntIokx1reUPdkWcP1CZylHRCLnWK88ddLXp24ByeHu7BH2ImTd7/cv
 JGUZ79UrceAJpF/qHr8vGg9re/ZXJI07Klusobgh59BkEtlFi1Ts1YBA3HEfo7GlOHGZj/Oi6xs
 1Rop8F6gVSj6Q8S72CCXnHQGUDN+jloRxxT3bAzxyUUruYPdwL+UeWO3AaDjsw7J4n0ekjgBMs7
 1yvJ9vC3lMXXBWyJMU+sv6jjEGPvdP+xgP8Va0Gi0ojirLdpV1nU7SBM7mujOVh126MhrITXt31
 /Bt5yr6LuErKWxifyBGN/WBo29B7hOHQTStlkwnrN+/sCwf/3aiSHcFcU+rGfO9QGN9N23Db+97
 mMRpnnCbb+DZQzdgbyw==
X-Proofpoint-ORIG-GUID: UE8T13HLEUNyzsBApGDaJBQKejLfdl3m
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a92161f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=BIMoBbIzgqyw9w_Ie0IA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/28/2026 3:58 PM, Pierrick Bouvier wrote:
> Now that we can link a single-binary with at least two targets (arm, aarch64),
> we want to make sure that we expose the same set of machines (later devices and
> cpus) than target binaries. For that, we implemented a static filtering based on
> target interfaces that each machine will implement to declare which targets have
> this machine.
> 
> However, we discovered that this static filtering is not enough. Indeed, some
> machines and devices do not depend only on target, and their presence can depend
> on Kconfig or host/target combination. Thus, our static approach can't work, and
> we need something more flexible.
> 
> The goal of this series is to focus on the filtering mechanism, not on the
> qemu-system binary itself, even though it's included here to give a full picture
> of what we are building.
> 
> v3
> --
> 
> Suggested by Richard, we simply use a callback added to TypeInfo.
> Added full example with a single binary for arm+aarch64, and then
> arm+aarch64+microblaze.
> Also, added scripts/single-binary-compare-cmdline.sh, which compares list of
> cpus, devices and machines between single-binary and original binaries.
> This is what we can use in CI to ensure we correctly tagged all QOM types.
>

After applying this series, and running
scripts/single-binary-compare-cmdline.sh, you'll see than many devices
are visible for microblaze, and should not.

microblaze+arm is a more interesting combination than riscv+arm because
riscv has a lot of devices in common with arm. On the opposite,
microblaze has a very reduced set (no virtio, no pci, etc).

I would like to focus the conversation on how to filter the remaining
types. We could maybe generate something directly from Kconfig output,
so we don't need boilerplate for each CONFIG_X entry.

I understand the discussion has shifted to what qemu-system and its cli
should look like. Even if we end up creating a new cli from scratch, we
still need to solve the filtering part (or at least express the
constraints in a way that allows to filter it).

Thus, I hope we can stay focus on this series, and find something that
work all together. All ideas are welcome!

Regards,
Pierrick

