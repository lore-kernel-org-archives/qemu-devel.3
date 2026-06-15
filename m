Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F0CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBOG-0006Wc-44; Mon, 15 Jun 2026 13:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBOD-0006W0-LJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:46:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBOB-0005BZ-Mq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:46:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhc5u3139958
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lh6mC3Kfcle3d2MgpCQmhbIA8lev3FPIMY76o0qRQUA=; b=VMmcA98jgtP9vMEi
 gI8sGC+jsfdnqaD8znLApb/ImRWQw+sq/e8yjTGdRJe7WgDKt/0MNfkru5Fe9ydu
 DqOSxbe8wYqUCVO+5LBh3RBNlTeg6SKbk5SNrw0mVdpekHkeOuYoojWoIdHULCv+
 vQ7h08uYEiOzThAw30x+ZypanLe0KP+W3bwJWLIJzm+WhfvGGkfpzB6hvsdoETDp
 fSPFRP3OujAJD3dhchQQ7MptWXGqzf9a6dJvvvvs6aJKRY5pfj2sZbH1xR+YAyD5
 m8vSBlwW9TIkktmsoG6Ih9ILl2FMuGELxMdPD0lHa2iX2T/5b80FWVX/04XofyAo
 jUWuMA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9829c0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:46:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3074d4102a9so10352876eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545580; x=1782150380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lh6mC3Kfcle3d2MgpCQmhbIA8lev3FPIMY76o0qRQUA=;
 b=VZ1C2ZPdM+mCd29XDnK27FFIZfsDGaByvHZ3ItAt08PfdQgUlMFjcrmiGMHyCyu92n
 cBvTivyeaKzjIV68cjPhss2shPyD139XLL3g+700SylEjr2LLAU7VI8AaUNmpnSgbMqh
 +Idaq7RPMO9xi+srY6jVL6bduuy94WX7j+p9OFgadDeUWMfO8j41btEFuBDooXolnSxc
 2rvLv13GmmTevkyD/tMHy5JQTfcYCNfYiNPZ/OYkyh7O/aXiL3UEI1KPU9wpB2XeSCbY
 JBvNTr1+/22tJOHRapAJZeHdBn4ntkiUMY6/ew+B17DNr++/l3OYk/oq8in2sVSHZupQ
 GAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545580; x=1782150380;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lh6mC3Kfcle3d2MgpCQmhbIA8lev3FPIMY76o0qRQUA=;
 b=gY9Tu1sOEDHzxhQnJTV2BQ2qDTgXk2rdQUGCXLY4IHV0epRUbYiIYVzb7NpMAJ88Am
 D7vI5pze398riTxebSQLtL1YLOBqn/1xHqim6omeBlPMG0qyHI/VYFkfBb3ul5MtedHe
 KRQX1bXWDhaHbLXAecPCtOw1pfgzNWqBnXAa7Ti9cTXIVrtr9J/AG/wM3I8pfYMTIUPk
 dKrKuux36rUFG7mfU27C/ApwrHbGurpZD2fX+648qstPrExBbT/g96cbkxPoGXiKRy50
 kYRjskZ12bUziUTGwG2ofJoBZ7YUuVB11dkYQ9ClyRRdQZhb51vMdhvXUdKa3FVDt6rK
 Uy3Q==
X-Gm-Message-State: AOJu0Yz08OSm6vEm7x25O262sy68w2R5ts0ETURcHQo2vyAMnCWqOhrj
 VRpdW8m0hRGwoiZs8UiqgJcKAaR2F4SjeUn9iD0116C+gtpgdpqL1dUI0TwJShK1a6FF3NucNuG
 8d6pzZkunDpwG0ouhU6BLZ/p2ijM7YdJFyP2ae/HAGJQDPhpwDPFulWWWgg==
X-Gm-Gg: Acq92OHfwGkusrbFgbz6Ch0wg7KxlA/lgExbtIK0sOR+PA7UReDL+GYfPdIgS2OrSbP
 9qGCkcCjntqcimvnPkKqGUhaS/2BpjpYtc6prV6lZQs8NV3/f8cdtSJpxROcQV8b7flMnVnzfbC
 2YhWKFNU6QwOXlwciotf5eqcjG6PfXfGMmEiOc/oO7T3Jqt06L/hCahAdtm9fpim3SYyhLZTnPf
 46xYXhxRMrw7EDE5wprua/zYb4pzXAIiS/vKMiV8YGdpE90I3XQNEa2K0xj7d1OgSGnAR5OSpXk
 Asj/lGDYgGN2YQOr1D5euSJ9luP1aL5GyT4piiYWCRf6SR5/y962hdfZsMIrnifPkxDSlhSM4Uu
 /kxIz7lJiS0gpSXpej8ZAvLG4UUA2L4OLHJ99Pw+0S8SsUdD9SZabpQ8R5KQi1OKmJO1XLged9J
 P52oCOCiOcpX33pg==
X-Received: by 2002:a05:693c:2b01:b0:304:8366:9fb6 with SMTP id
 5a478bee46e88-3081ff64a9amr8677301eec.2.1781545579513; 
 Mon, 15 Jun 2026 10:46:19 -0700 (PDT)
X-Received: by 2002:a05:693c:2b01:b0:304:8366:9fb6 with SMTP id
 5a478bee46e88-3081ff64a9amr8677272eec.2.1781545578992; 
 Mon, 15 Jun 2026 10:46:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b910c51sm10909562c88.4.2026.06.15.10.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:46:18 -0700 (PDT)
Message-ID: <102068b3-f181-49f4-addc-4444afbc03a9@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:46:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: use int64_t for the syscall filter return
 value
To: Ziyang Zhang <functioner@sjtu.edu.cn>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260612055642.589337-1-functioner@sjtu.edu.cn>
 <20260612055642.589337-2-functioner@sjtu.edu.cn>
 <87se6sdonm.fsf@draig.linaro.org>
 <bd162496-6325-4f96-8ad7-72fbfb3e89f8@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bd162496-6325-4f96-8ad7-72fbfb3e89f8@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a303a6c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=8h3r6ry6AAAA:20 a=p0WdMEafAAAA:8 a=848vef1LFBXxolqLDqAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Nb9rLF6YNU9T-yZQvAzzWD3_bSkHTn7V
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OCBTYWx0ZWRfX5Djefc6kTQGz
 ow1y04cE2INJ+loLh9AzkqVrct3OJ8w0hvy2ES/b3gJiKxyxLTscEfSCMV3s1+Doq+6aWlirm67
 zKBgJShTnAmJFhTW4kfQc07yWX04ifs=
X-Proofpoint-ORIG-GUID: Nb9rLF6YNU9T-yZQvAzzWD3_bSkHTn7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OCBTYWx0ZWRfXxHhKaAdmLFQQ
 7J174heg8Pf31qfaxv5t0r744gWWTHHlJyOVZiDOLYk4YwQ+pW/u+k1rx8xRpAw6rWQYyoiJsvd
 D4BvEjyp/sWWeq3vxQ/O7pYdxPxyH57BxIToulvQkvgVNQaYGFC+ddZq0w767R/meAwBmuGHzGX
 8dU40y+CSUn7jDds/jDUiXJDq+srODoUft1XU8Tj/RVo3K0SasOl9m6ryBdBV2VveFJuzNgsjsQ
 EnLSVELghGFIu96aEUyaS8BJtsG2GtI5wkiYOdJreCRf9NQP49Qa2I2C2Wb46DoBihtfmWDvRm/
 rFcBEfxJpKIyBx9Ci1Awec8iMxRFJc1K/9JvzqN9wV74mHnyz26rzkfiPL0wsk3PgPQJ+5zktJT
 hlwjKLZZVOdXPA2pfu0ofNpDFekbqJglw5PtrLdES7CEtjj+sFUpGG9DICBLZriCHz1rOXOlhdB
 fM+y352toCXDadvW/pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150188
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

Hi Ziyang,

On 6/12/2026 5:48 AM, Ziyang Zhang wrote:
> On Fri, 12 Jun 2026 11:43:57 +0100, Alex Bennée wrote:
>> All of the arguments here are abi_long which go to int32_t or
>> target_long->int64_t so perhaps we should be using that for all args to
>> ensure signedness is correct?
> You're right that abi_long is signed. I only changed the return value to
> keep this callback consistent with the two syscall callbacks that
> existed from the first version of the plugin syscall API:
> qemu_plugin_vcpu_syscall_cb_t and qemu_plugin_vcpu_syscall_ret_cb_t.
> Both use int64_t for num and int64_t for the return value, while the
> entry callback passes a1..a8 as uint64_t. This patch matches that.
> 
> I'd prefer to keep the arguments as uint64_t. They don't share a single
> signedness: pointers and size_t are unsigned, while offsets and fds are
> signed. At this boundary they are just register-width words that the
> handler casts per syscall, so the correct extension is per-argument-type
> (glibc handles them that way too [1]), and forcing them all to int64_t
> would be wrong for pointer arguments in particular.
> 
> Changing the whole argument vector would also touch several APIs and all
> their callers, which is well beyond the scope of this small signedness
> fix. So I'd rather keep it to the return value, the one part of this
> interface with a well-defined signed meaning.
> 
> [1] https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/linux/
> x86_64/x32/sysdep.h#L50
> 
> Thanks,
> Ziyang Zhang
> 

We can't expose target dependent types, so having unsigned types for
args and ret was the correct thing to do. This way, a plugin can decide
to use any bit pattern, and upper part is discarded if needed.

For args, we explicitly clamp values depending on target:
https://gitlab.com/qemu-project/qemu/-/blob/master/plugins/core.c?ref_type=heads#L554

For ret, the type conversion is handled by writing ret to a temporary
variable, before sending it back:
https://gitlab.com/qemu-project/qemu/-/blob/master/linux-user/syscall.c?ref_type=heads#L14622

Indeed, there is an inconsistency between syscall_ret and syscall_filter
on that. However, they do different things:
- syscall_ret will read the value, so having a signed is mandatory.
`if ret < 0` needs to work.
- syscall_filter will only set it, so having a signed in not mandatory.
`*ret = -1` still does what is expected.

From that, I'm not sure any change is needed, but feel free to point a
use case I missed where this matter for syscall filter.

Regards,
Pierrick

