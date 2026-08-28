Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDCCC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztLW-0004oO-6R; Fri, 28 Aug 2026 05:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztLU-0004o8-Me
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:58:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztLS-0005wW-Ll
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 05:58:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66h0l1940941
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1cO2YqVh5AwhSHl4tCAmWKpp2PO/QpnZjnjhu+PU1G4=; b=ih2ncH7B7LO15w5M
 Ic5qWDCVBcrSL5mSEXW0haLHm7bCPq2OeHZhKh6TVVTnK260ofOgxYD6KSsByJTO
 GtYTQ/eDefNoANqtB8Xehd93cgfWMx62xDU2oI+yUqQC+Y28YwYlhRjhdEIUj7a7
 WvWAVY+NouMV5Ngs04ItIEZE44bDePGNnjPxjtPXgTScgFvNYAhRkhPf6kaMmVKt
 IO6APhF/KQcUf9DdsWMdd12vPB+2BYesrz0p9FlN6CxAk0gtR5Q/WOzQOhsREnSb
 FAUV1BFu+1gWbR32+ohEQPday41M3/DbKTLUb9oHNG2BAwsd2eAonZ1xrH0Caskd
 iKnQQw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs1718-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:57:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93903622880so214076785a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787911076; x=1788515876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1cO2YqVh5AwhSHl4tCAmWKpp2PO/QpnZjnjhu+PU1G4=;
 b=IFfDRfDR28WLuhShWpiLGe0WoLBmyGVY9Eq7nMKaBJnN9SjTvwqRY5BQJmSl9AUpYj
 ZMZfPUMQFepvU2vcYL9ZfgcQTZc8w3ErPqe/e5UHmGl4saZz+CfH8biS/R3OA/53bDw2
 3hZTXDWLTGpze+EPgDpA3jSc8MO4tBgLHBxrCtK7yOZR0ezMh16c9xowc/o2Rqf3ZG3B
 PNaJiMTDNDpkWNdA8cF+UlFiTDpeXYxNhOln0vX61zaNheBHJ71uXGFfQmNEuMrL/gLn
 7A3XuN7mTdjz5iLbtl61foqCOc8vfKfQERjBA12TxRy4RP58veUxp21TwXSj4NG/TVbe
 caMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911076; x=1788515876;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1cO2YqVh5AwhSHl4tCAmWKpp2PO/QpnZjnjhu+PU1G4=;
 b=l264YWDfXhfQ2sZGt8DNt6HkUeqI6FprgG+9UrbZ941qaPgNyz87RNbCX9e+c56JqA
 +8weSgzLMqgS5y/tR7kASCxrGUDi7eos6P+UDPvpz0Wwquy7z+P6y14AnCFVSqn5NAmw
 s8oWX+nwYdEjit+xgXTaPJNoT7f5LRysUVZL6dLj4Eh7tB6XjmFNE7q5tkZRQqsZtdzt
 BRXC91PeVPQnyMmzh2mxKxl9ME2pXb9Um5E61NT+03iHa4K+BS72ZmJBjMBhweGPKoEl
 QAQHfRmJlVZ8i6CHlkoNgiJ/2QO7f9AqIzXAerjYKjheJ0uIK+Y81wbVtK4sd17ApzQT
 VcXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6g+QwvXXi23vzGb2TKpsAvpajNtuapsgy3pOwzrRb6Jki1C2fF4sftauQZTcAEHBOkmIiy/JTfGWh@nongnu.org
X-Gm-Message-State: AFuF++l0E8ZL1qwsAt9k+UzEtpRD48tD7pu5KHjW4Em6JV8MVZc9cjzy
 GlOF9Ti1Suif+STx+Np1NPuv0cGOBg6eVgrMPxPor9wMcZODbeAztS5GW12VMWTbYWVswzLqKDi
 lmgHc5I+cfE/0uWJyilANVC2h25Yvl2fww/idrMWP0XtrD341sky8SnJBBg==
X-Gm-Gg: AR+sD115RxKuWo2Ssa947UlBkhFG3uHeOCfBkd1eKVgwoFUgglIsHGxgCqE+h7bR3sl
 /4Bl0wtJ2jr9ZpBdhW7RV8OO0jOyUE91g1FWmEPVbAIUSk9wD54iR0DeUFeo3g0XP4gIZD5pdnS
 rBiv0Bs+yNiiG/ucmFWM69tHJInAu8wvyGzkcoCJeHZKGOQZ8us2003HumIxnq1Mw67QWPKKkRP
 3NJO3xo6QWUiL88/fxhyfn9sbflRl5VSkIXUUcNDBUUI5tKNy+LoODzqNTFP3HhLy4RDYH/JmbW
 ViYdY714y+bXMk2lyVXBVx5zPHsBkkobuwitVPWF8h95ohjIdZhQw/gBwyVkF9U/+jU7gPGkvun
 itqXWEV24IWRA+5dLpBUeHHPlvqp3yOWcVQ==
X-Received: by 2002:ac8:5716:0:b0:52d:9ab4:7775 with SMTP id
 d75a77b69052e-52fa1ddb165mr142235231cf.21.1787911075775; 
 Fri, 28 Aug 2026 02:57:55 -0700 (PDT)
X-Received: by 2002:ac8:5716:0:b0:52d:9ab4:7775 with SMTP id
 d75a77b69052e-52fa1ddb165mr142234941cf.21.1787911075367; 
 Fri, 28 Aug 2026 02:57:55 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91ca11d0sm44334875e9.1.2026.08.28.02.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 02:57:54 -0700 (PDT)
Message-ID: <23f04b70-b78e-4234-ac97-2feba4d38b0d@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 11:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] single-binary: merge experimental qemu-system before
 filtering
Content-Language: en-US
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a915ba4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=OZJQg_frYNS5A_9qpbQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4NSBTYWx0ZWRfXzyXY2Dmht2l6
 mWpvVUoBf6929agXKdCJ3LNzsALzsYKlrwd6tJg033+1Ubz83GZEr5G83OPhRAJ+Og9iuddAad9
 p5Bts47x8jHOo3dnrT6loaTAc3q1tJkfcOlg/juu0gzQ5ve6nJZFJ4wlgBJ1RoBsBboM2M+F0AI
 skIoc3odliMAPC0Kasv7udsnNNlMAeQ42xKIIuoa2qqyJDQ9h928MWTcBAQJOBmExivKX33z2RA
 qrMW3qJAGh6HY7dAwfDSRimnrf9yQYedimbD9WcxthJSmRJFgQsbeFTgf+oNhkLWYluSGxH/ipo
 P1VryZWUsp8stWWMjSfsdmqnJOqF0tmHmH89IxxFYDhG62iqgOAxszPO6xwqWJS2R6G2RjEbAXH
 Pv9FSnORB/5nLCAQK3MprQ3TVRxchKBpeg0Z7dmZ/UNPc+AKsDuNIkt2BrHg7IMb/BLJ8nEcZG5
 Ci7cnkvW6rbzjYagm6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4NSBTYWx0ZWRfXxDbLxQ6CFS8H
 qJgEqisuhLZ+U5DlntLSS9vb1Vwe4SgHSXQT8Z7x+OTVkCyhVGaGVPmm/rt+ucDPUJ45BqZqAVp
 JWTpbUzxwgtV4X/Dk15HtqWh7seZAFU=
X-Proofpoint-GUID: 6eEDiyEe-aY2_Y957Xm7iiJG6ZCWLEQZ
X-Proofpoint-ORIG-GUID: 6eEDiyEe-aY2_Y957Xm7iiJG6ZCWLEQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Yonggang,

On 28/8/26 09:44, Yonggang Luo wrote:
> Hi,


> Proposal A: -target plus -M target:machine
> ------------------------------------------

> Proposal B: target only in -M or argv[0] (alternative)
> -----------------------------------------------------

> Please pick A or B; the rest of this RFC is the same either way.
I appreciate your interest in having a heterogeneous QEMU,
still I don't understand why you are rushing us here. We are
discussing on it since about 3 years. QEMU is a big project
used by many persons in distinct ways, this is a big change;
we took a long term view, safer but unfortunately slower.
If you have an urgent need you can do any of your proposal
in your fork.

We anounced 'single binary' and 'heterogenous emulation' as
distinct projects, and there is confutions around that which
we are trying to clarify first.


The 'single binary' is a contract we agreed with the
community, instead of having multiple binaries each one running
a single target, we propose a single one able to run all these
targets but a single one at a time, possibly picked with the
'-target foo' command line option. Nothing more than that.
This simplifies our build system and likely maintenance.
No change on the user interface.


The 'heterogeneous emulation' comes after (and only after) that.
It is a disruptive change, I don't want any of the current
machines to be exposed there. We want machines to be composable.
This is a design decision. The list of things to fix before
getting there is huge. Re-exposing the current machines there
will only hide all the bugs we noticed and those we haven't yet.
This is not the path we want to take.


Regards,

Phil.

