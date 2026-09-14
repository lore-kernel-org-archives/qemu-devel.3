Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5B1C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BJa-0007dI-KE; Mon, 14 Sep 2026 14:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6BJY-0007c4-GS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:22:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6BJW-0006Bc-Oh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:22:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EGxL1Q1365535
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GKkK3t6chgEMhmMqsKaCObAUfYK9h/ot7bRxKmluDvc=; b=JQPCKM72aX5i1Zza
 n4ht6YYpI1uLLmq5FNN9TBCPg58UfhOj8/zyqFZn1/LUziuH2P4CYBcjEOoYMbs+
 OoxvDtljTGjB3vwTanV99KppflVOs65YmHpD3MKtj9HTLzckICCdpzHQZhrET9GF
 +zu8mrbLIr5znQuaDg+5/g/mj7Z8y/MabtaQL4izxowTPeqc5AlmFIB/9dlDEyvI
 dcikO2joqybswaGBeFHdh4E4MoF+6rlsMw2eDho6LV0cup7vd90xh8kExHFu5Gqx
 t5D+cNlHeAG7ZZeErqkZ3sjQiE5WcmLRjDuawZgLZLU13kTBHIo7pYSkgS7Vftkw
 /K3rYw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9rat1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:21:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396901263b6so7190178a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789410116; x=1790014916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GKkK3t6chgEMhmMqsKaCObAUfYK9h/ot7bRxKmluDvc=;
 b=QlrUzCOsztLRaSmtRF2gQ4hEaKw86SzikHoyJ/Kw+cS91mdzVOnzBSJyJPAJGDZsJ5
 FVUjJWZl36+/emVZrOeqxs6EHnXjykwK9WkfbvvCc2QTcert842+3C3fdF557TcS5kpp
 4n6w5zvNNRLN8AKGhX28ShFH/SlMpM4Jk25WP1763/tmry9qeSp2u+kEmKH/+bDxoRXq
 vP/P+XLj3sdF0wiJJg9Sa3x6jQ2BWZPeLFdiROaPxUWQgShpVdFoTV5aWSMMerQptEQb
 eeVJaYe/+7zrZ1iFMwtJyII5d8c/uCgm0713sANplJzUCpyJXAVxj7lNcrMHr93qChlH
 e3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789410116; x=1790014916;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GKkK3t6chgEMhmMqsKaCObAUfYK9h/ot7bRxKmluDvc=;
 b=rgIXyyfz1GuefWERSNiBvBlG7Zc/SN4NqEhR7UvVE2h5o5Nj9tKQzqLxSNw5d4edn4
 1t092ttUq0UUhN2amY3ZcJx6kTG4Y3ECr/GLM3yPe4T7oMM2zyIjbI/jPiiong8QOpMv
 TBnwyWkCs9YzlnY/gh3d4IMgQ3NwqMRExM9rObCv1KCuD4ykyqfJ+hBlDIVebRzyFu2m
 IAAGdKVJgWkcLlv1zLvo1tnfCKm3Zz06UlsfH7eX8/JVXC5OckgBM9b5RN8RpWmz6L1P
 BStG0WtmoualbRV0SoN1Ftw7w29lObzDme9kMgQ0dvywa9+knCDB77+TY211IUCYaqPI
 nleg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8jnGkERlOSUkV4lMfQDHiRTAOkN/eujiQKmlQLrTzk2kFPqB/Dww1P/7aYS7Gz4ObDcn7RDp+xb/h@nongnu.org
X-Gm-Message-State: AFuF++mNCZiw703XrYvC0dy0Yvtpm8XCz9/HllMZ794bMJiFAlGg7lEm
 QOtL++KDYJQPKJKb1/GpQAMDsoZqylj0qNvvTAJkd2KQzyq31TToNlwqVTasxKbdARvKzSt4bK3
 2m/XR22KsNkdMYL640dnWrBOL9ZAgXjC32hRefz1fwV5fSH9+tWDW3bDL9A==
X-Gm-Gg: AYBFou3xrVwIEg8sBlEJDXTu0w66UxhDYVfQZQ3KTn+EhdGYyNBRB5a4utqqg15xFhB
 RjCerzabpn9DL32QwCLbWhYLnmDUpBuh0RVGx0N+EJO4o/EW1anT+9B3jGM+jn77nf7BddQALsV
 0LeXYFxXMi5C/Iyrh+ghDhrBmv6f3BTpjmpB/QI/LaAzF9ztzSiMGYqHSBpZKxI8O09A+t8Hqji
 lKObDAzZDkxtZHQdlt3ibU536O2rSyHzzOp8tdl95XwwU4nn2f1gcgasCK7ywcEfOTMBIkbp2Nn
 STqrJ6PIrlpfeWHpaKckLNKj1ebc/Pw+YIgDgWsADTxRLN2OwWZqfCSUgyHBGZ78RK37QUlCT1v
 9n2odN7bX8rRCMtK/zS8lhDD3xC1wWaCWtVvKcOT0pKs/3nfY5Lt/0XMS945LTtAMn5mi
X-Received: by 2002:a17:90b:4a0f:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39debf7613bmr6439783a91.6.1789410115803; 
 Mon, 14 Sep 2026 11:21:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0f:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39debf7613bmr6439745a91.6.1789410115334; 
 Mon, 14 Sep 2026 11:21:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8f1f7sm23843830c88.11.2026.09.14.11.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:21:54 -0700 (PDT)
Message-ID: <42c559b5-d5f8-4fe0-9f39-5633b9443be1@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 11:21:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
 <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
 <CABgObfY68FT-V=G1Sks865FtEwEwB9SKyHx1YTLtG_4x9WDseA@mail.gmail.com>
 <871pavd8ry.fsf@draig.linaro.org>
 <1a8155b3-92f2-452c-bd0f-884c3e0bef69@oss.qualcomm.com>
 <858ea3b2-689c-4110-92e2-237b7aa87fb6@oss.qualcomm.com>
 <CAFEAcA_f_u6KgojmixnKBn=v1nLybMXYn5MBycrjCtgSP1J7TQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_f_u6KgojmixnKBn=v1nLybMXYn5MBycrjCtgSP1J7TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa83b44 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vUdPm7KmsIlIxGD9oLAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI2MCBTYWx0ZWRfX9JBW3OQ+iLC9
 7jTWqirljqIRgwVh+wRCblJf+GunldkKfifdqn9lvOBu0+78gxVVPDT6WskJvBY92q0mrpwRioj
 KxWF+z1QryFitruKKOMTUu8UksblQp5nSp8ZSPxow2PcA7+J/vZwxCowkJ2sNEAnQ0rgvDcbZpF
 mMLZXOKGIra9ClebUBePFMgFGcFJHgJDELISrvvAf8BuNeqh5xPUCvg4irbePZvciEne73PKBPY
 gvWvRo5cITSXYszy8J8kGMZpPVg8M2BNIuUA09kc3B+s6cRuRhqIVQtieIi59bOfqvvU88VTtC7
 jzdkVmig7De2rj0cSE40nl5NdA8ENYY8nHZ3Df68l3n+eYCHXAAT3lYwNIYM9xqioi92AruhnXw
 ya4m6u9rlQ/2HGE4DachqUJ1r/FeQo9J8FYmsVaooLFxeJTWMNjIWYVrpH3pbGwnggJb+NKgq8i
 KtjpH/hrk9qSS0/hKFA==
X-Proofpoint-GUID: hYGOyZ-SOZz3C1rvfDxkYmUknvxVzSFV
X-Proofpoint-ORIG-GUID: hYGOyZ-SOZz3C1rvfDxkYmUknvxVzSFV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI2MCBTYWx0ZWRfX5cEUsjThBWDK
 0fruvKKAMDtNTQAMPbRBsfQGWtOBbOQ3JLLGizPO6s2k0kAtsry2+ngW/hy3qeZEVcgQPhFZi99
 rkq01m/YaZsRkDIWPYgRX8U09cbKcQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140260
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

On 9/14/2026 11:13 AM, Peter Maydell wrote:
> On Mon, 14 Sept 2026 at 19:10, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> For vdso, we could simply build them as part of tests/tcg and tcg-tests
>> target, without having tests associated. This way they are always built,
>> and people can update them by simply copying them if needed.
> 
> Then they'd need to be an odd special case for --disable-tests,
> I suspect, since we always want the vdso built even if we're
> not building test cases.
>

Since vdso binaries are checked in tree, maybe it's fair to assume
people can build without --disable-tests when they want to update them?

> -- PMM


