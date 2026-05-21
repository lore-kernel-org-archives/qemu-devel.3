Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D99CD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Or-0005VN-NE; Thu, 21 May 2026 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQ3Op-0005V0-KC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:25:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQ3Oo-0002oF-03
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:25:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9AMJv3556011
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6qh32qqnamXR3fHGkVOEuuAN8/2DITsvrXG1ZAuUswk=; b=K/z+nYPm6szeojKz
 N/MrDtP9R3IGw1vd9t+VPep5GdRPDdgfrlKGK8PDG2HeBElq1IalEqyRmf4nPF1e
 Gj6ZMguwAWcgB6Isb31UICXEwgXmQon9jDRfhOjGs47pB6BqKElUwKmwArvNhPhW
 tQ9Hvjmn2TF4XMsueyJKitvSQPNkVPQepwCxRMUWS/rHInIp9y5sj0i5UrFNHebu
 SYH1SlKLjpVI2fMNLaqBDPYIgHX9mtWh1Sz9IIZdFD6CNZcTVNRq/C6AVbJ06Vsr
 QLza3hQUc7m0Gluc87oBcJZUlEjN9wrgcw9zqctcrtLs/HdrgH29t1kHKgx7ENPA
 DgNB+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6mpjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:25:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90d6fe98316so1364318385a.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779369915; x=1779974715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6qh32qqnamXR3fHGkVOEuuAN8/2DITsvrXG1ZAuUswk=;
 b=eYYGM3m0ZSr7mnfDzw4ukAmheXs+xArZX0zRGmob0vfU5HdwGQr9dz1aTbwxScN11P
 6ehmcrDnIXzRG0AxTEOyo/rnUyk1vTdc4jIG8N428KaLlKAvFE/dPRXV/5Co1UkfO59N
 GLA8creXjvJU3ge28sgkXN3Mgz8y762V8iFXy0rBPM+KHeaaaqZa7MP2F92OcNkP0AZ5
 zZBWaobPOO/j5ZoZPE3ESLQizBXq/5zozat1wTx4FWjUM2UmQNWs7AaAsGq6X/7r3guN
 3CtFZi1EpzkLIEPAUEvdyT/7wtTLyGtz0VB03Nf25ml+/xOyaZIA2TlExjkHWcssLJQ4
 KRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369915; x=1779974715;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qh32qqnamXR3fHGkVOEuuAN8/2DITsvrXG1ZAuUswk=;
 b=LFy3a17tLtQ4zWecNqWULFbSh6UQWigYmodmr776Hh4DddKtK4fuWzz2dECoA8fiRi
 iUdPKD8GB/Ien1EkYVuRIQSV6dtGuwMaFKbl8p8RSwiN/nTU+KEADcPnJR7SyUvxdBUZ
 pe5AXZvhCRdMiJFxhcPg2T8ajbmoPSwPBqvo1hX5TlIp55ZF8elyqFM+mi4Ed+Pvg/mQ
 tIbUcWov5zlFlRJD/Qg419Z6ws9y5tTaAgiBgOSnwx8aFvRwLvL9UClWLIt81376GK8g
 i6Ade5zuJo2G8s+pFM1ne345osVCvx6jz5Hu7BC2e40Me9NFTSJ4Bt/jhB59pwy1b+Km
 y3Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QF64KwiJQ9ChCs/bV5/CfNazn/6M3eNPvnw50w0Wk7VdGtzXux9xflaSQg8TA7AEr9kRSJV6BLSQi@nongnu.org
X-Gm-Message-State: AOJu0YxiyQR8edc6gsnhbZxkGvs1fJLeN+XW7B2AzMl1vHlWA1w76pt+
 LRvPoBf/4GUT41Yv/1IFlfSgUfht+PCdWzyALqDPHZb0ItWZqgfU49fqF0O3XtgK3DEckYSdMUm
 lejRkOCaoDr2mIedlSv7KKQjrduqTrDRXZvPpC+41D5dgVxTgfNrOVjrpXg==
X-Gm-Gg: Acq92OFvqjcRdUfDKMzYgPtQ256ID7QYShSh2Wl8mezvZihI94KSREFdQT7IOiKlSka
 xIxRaVhEwsu3MZ3CjDRoybrhpjJAhwXvboYLVpyr3PeUUv3vZ1KbkQpn/Wj6Cnt7/C32KS1aX8F
 igZufgwylYO64Xc2hhvgwTChPsTLk2k+vG7p8QkbqigQmmoRSrUFkYKdu5I01sJ+3pcE6eG6sSl
 BhnVTdTdlYqbxGIcMmnAUzBqt42wUF/kbxSbJ6UpjwIaXftC0VzTOOU8ys2+HMriWxBMJB0IGnu
 TE3ohVj4ouLxvRj55kidIgHuUxGtb1cUd8B9xAOC4cSW451Cn9rIDxLanWcRW2+pxtEJiPD2qet
 IrozLQ0N7U6EaqDZGvqbgitXEvE/fJ3g8r8WLSj84W5eRy5kPQc5oDA==
X-Received: by 2002:a05:620a:3729:b0:914:7b1e:a5db with SMTP id
 af79cd13be357-914a2a2c93cmr384569485a.4.1779369914990; 
 Thu, 21 May 2026 06:25:14 -0700 (PDT)
X-Received: by 2002:a05:620a:3729:b0:914:7b1e:a5db with SMTP id
 af79cd13be357-914a2a2c93cmr384560285a.4.1779369914200; 
 Thu, 21 May 2026 06:25:14 -0700 (PDT)
Received: from [10.157.3.27] ([97.64.79.159]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914abb99240sm89185785a.26.2026.05.21.06.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:25:13 -0700 (PDT)
Message-ID: <96a48300-ec95-4291-8cb8-439d255de9aa@oss.qualcomm.com>
Date: Thu, 21 May 2026 08:25:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: capture filesystem, CPU, memory and kernel info
 in logs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260521103624.1645809-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521103624.1645809-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0f07bc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iFpTQzQ+bcdAZ+erNHz97w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=8D4zzwVXToasGhQ33DgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ft1Z0XtmxB4UoWrg-kOtO-9P8Ggkq00N
X-Proofpoint-GUID: ft1Z0XtmxB4UoWrg-kOtO-9P8Ggkq00N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzNCBTYWx0ZWRfXyriC4GnipUBw
 9vx068rZ5oaYXZi7TOwGJcrfEyaO1S6pWPGqFQ2YyiU3EuWA8oyLsHlp92jDpzqOI0D4iiq7gJe
 jrv1ymJeOoJLrxE2d8ZlQXOLqN6wefMerkGvgfM0/ayh6Ko/AwD+0QkxuPP2h+mLqa6jJ5/Vcix
 /QMWCzRh8kg/rXv/SvujEdS53i+WP0WFa8xKAG45giUuwpOJCF30ZWkonFtQavxgWIspaZW6Gzk
 QVeOg2wYImYBKPi+zH4u2M44Wa7SqXcAQP0Qa4hx+aMB5rT+TIL7KsBEqdrDxu5olUmtWA6Bm3u
 5KccSaaedbAFN28kbJJjzXUVtvd25lFPER6Je8LuPQBX+XHpfwKj7DdSCQybCZdIL6mZO7Of0Bv
 Fj+mtIpIGFkqBFgyuVQBZRLZPgNokJrG0ggJEaFnWEAvzS39HbP4zpO3O8AI9RiZm1CxkZx0xxa
 W1pQsjY6SSn9xwPBByg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210134
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

On 5/21/2026 5:36 AM, Daniel P. Berrangé wrote:
> For tests we have often had wierd failures that are related to the
> runner environment. For example, tests that fail only with specific
> filesystem setups.
> 
> Since we don't control the runners directly, it is important to
> capture info about the environment to aid in failure diagnosis.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest-template.yml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Good idea,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Maybe add a ls -al /dev and id -a, to sort out potential right issues to
access devices?

Regards,
Pierrick

