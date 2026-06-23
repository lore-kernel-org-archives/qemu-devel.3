Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B090CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwto-0008CA-3A; Tue, 23 Jun 2026 04:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwtm-0008An-Jj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:54:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwtl-0007cY-51
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:54:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6cdw53338372
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Evw06LwIUU9xKKO5f13XI0u3tss4Sg29ko4x1YyeAzo=; b=htsSg0DJncQhSi9O
 mIteDP4DTgZ7JZglIjGiT5HSerIH41WL3FpVtqv/wXNwU+mXnPRa4t2IuvOEZ1Um
 J6Q6SBiLVxp69KgBAHbepbQfXRF4ax71W0BZVKU1I0BVh8xfsA+u78hC+IPrpEE+
 R3p7CGrHrNetw79HlT/OtycNfqojgOLvvItdvJyI3BSfV/EzOBAinTNga3YUUJX5
 ewh0apE7Ie5ipDvurso3EygYhfYLLjL4OR06Ca+Wn4b8EsRnlYU4mmpTYdFjOKOV
 Gw3aogr+1c+d+XfGkFkY/kT0fIgjK8Ed0p+/KCDCTsjYlZAm0VAp/ola4PMd8hex
 /4br7w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjhdh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:54:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cecf8bb835so89304376d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782204863; x=1782809663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Evw06LwIUU9xKKO5f13XI0u3tss4Sg29ko4x1YyeAzo=;
 b=XI2oYNpMOxZXT1tZExsguZwJSikznWEisbn9kKmuhI9YUwP0dxh6h0FKRbTuywaNKK
 zjWREx89KIQbuk8WIovnPkX5SOahc5xeaO9GVxm/A0NdBjGY7sb5ynM0rzG56b9OPhWO
 fDKx4tJehVq7lJw/x8iCsz0SI4yUWy9Y53FKnJiB+I05kHGHWMuVDwkkQabj5mFFNwm6
 ay7rI2QtHYor/n835lmFRc3ptIflrYum/ZLwFSxVSPh6QODeUhFPL0clfIfmpfnTKaIS
 HuounMlORjWhKdLpKTyefh7an38unLlJdz29Vo/1ZGsXGVySNOUt36ZZveqmSauwsuhK
 e/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204863; x=1782809663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Evw06LwIUU9xKKO5f13XI0u3tss4Sg29ko4x1YyeAzo=;
 b=S4Vapxh9uXiYwHMd87Vhjxg+XzN1MxvQsxz6kP6Bx+Qiv98pKL4QDwif18juwWmmn6
 YxrOIihn3QKm/eUfHLEnFHlpgNahGOR/PKcZyzvLlww5oJjGDZOKUERk+C7884pUqDWM
 pP4Fmic3mMqpBJR6wt9FaLTcAXQyVEZ02dxfMDIngJovO1DhPOdP96a2vgrGzNNOplCY
 NBZr7Bg5z+ze6zqGAlXBfjSTLT1aoQgdlqdhwKMwsZisuq7QJnkJEQjkOLw0IwTOpT+C
 ExJgaSm6MCzzPjTShpGVzUmUSpXO3oN2lhEdBOfWEw+mubenjeiDISljuSUtLzHPGnPY
 YUJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mkDQixoozsZ2p0u8xm82ccX3FrZLRdMoNC7r6yuEPRabK79FpfHUIvYo6jbUznPDOkAYrWzs5gjsV@nongnu.org
X-Gm-Message-State: AOJu0YxE3/XwviJ36bx2G1omjJu6RkRFX+SbxyKOif/AyYPI2Nx6+p99
 8+nulf26EAAy4Th/rOVTu9uHFwLH1oxfQHoRYHSu8GkcHjRdOJfDM45OBfeRiXCTFICDId3v7N0
 Hgy2hTFjUy8s2yEcfvAGoKJ+LBYJwOSvzziN1R3OYOmQ6fCzlGe1yrx6u4A==
X-Gm-Gg: AfdE7clon5ZBL23XRGjL1l5FRDMUzyJgpQyTbl/LWfoe9TEHvhBCf5n5SImESow7Kge
 5vY80Lr2G6x0+5F+W7PaMLPtvnmQ4OolcM4IsarVeuplKIOuOxRCWk51pXavfIN//Mm0a6YPOZJ
 XHcKfODeJcWNx1UbBxxIozbP5VnULh7GtIblc2Uog6krfNe3cPgABl7cwj9vKHP0nSlhGHaPuSF
 40a6OHKRv6scMZI7BPtrJdx3HIOHmLarRA4JwvOH8Jl6UNbalUTLxstwn6URN5XNRlG6kjTX6lB
 3APY7GTUMvg0m4NxN9IiHLTk/lD7XO0BMQZBKPPc7Spe4SoWJbedDk1EsD5VdoQ+HWHI53Vl3e3
 7cibeT+zWri3lPXDqSjWcPyazgeKyrz8UJvQ2F4HDB8kuzsCpk67ePXWnvYyeTw==
X-Received: by 2002:a05:620a:701c:b0:915:db15:4e39 with SMTP id
 af79cd13be357-92646583bd8mr356947585a.28.1782204862777; 
 Tue, 23 Jun 2026 01:54:22 -0700 (PDT)
X-Received: by 2002:a05:620a:701c:b0:915:db15:4e39 with SMTP id
 af79cd13be357-92646583bd8mr356945685a.28.1782204862403; 
 Tue, 23 Jun 2026 01:54:22 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b856f92sm4132248a12.11.2026.06.23.01.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:54:21 -0700 (PDT)
Message-ID: <68401733-1563-454d-aab7-b7790144f299@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] igb: Add VMState support for TRL state
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
 <20260622-igb-trl-v7-2-abb960e767ac@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622-igb-trl-v7-2-abb960e767ac@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX/FVBgDfhFRjy
 Krqwrj6TdKedareLG1H1a5g+Sn+XGLGKYxkpqwrqKr0CXSR91PernPR3dDO5rtFyV6osQsam2pc
 98hZ4PIob6y4qZKwxi5q3Uu8p1/axXvHErVZdjFBRYrPre7bbfT4kcD1cN8hny7FHtWAy0rYsF5
 thtPChmMACSR700SbhhQ2DB+rkbnmi5h36X3z3WpgTCERCMvvU9dDYI7KCvR12kRFJhNFyvqIrO
 MRjEpZoVxoRGEdUhOMiFkPd/3lq5tGT6s5hKd7hGzWhW0b7eSxiIjA08J2MbAZ7FLElSpQRuUpA
 Oo8kNm3D44b4nB3MNTGK4ysuacuf12EbDJgwNM5Uts+mro4wc8OXZo2QvaMSt6fsorgG85AnWYS
 9uD2gbf9E4FeRRo12a+Fp2cqGiM2RpLMPgbeMoP1M4b/cd9EDo8funuFYVojrd0BKqnvKYx8d/R
 kkGr/rWcmL9zbjCfGCQ==
X-Proofpoint-GUID: aQq48gr0LBuPLBAYGX1UAofaamlzlRrw
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a49bf cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX2A5PSnxiCIum
 wTXCyecIvu8Hg1aTj5AGZDelaYayObENS+YXE7oYa/lw9/KifJH/0l8jHM9AEIjz6f1zBe5Q9LW
 oiJsrIsZCCW2BRjDq9Wl/ApgYAWozRc=
X-Proofpoint-ORIG-GUID: aQq48gr0LBuPLBAYGX1UAofaamlzlRrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230071
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

On 22/6/26 21:05, Josh Hilke wrote:
> Add VMState representation for the Transmit Rate Limiter (TRL) state to
> support migration. This includes the TRL timers and target rates per
> queue.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

