Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FABCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHOE-00085m-58; Wed, 10 Jun 2026 07:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHOC-00085D-Fl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:46:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHOB-0002Ch-32
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:46:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNUI1968477
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TMlog90bAeJhxIBbGMEF0MinoG4m7UeAMGnZoM2AxWg=; b=QCVdq3mkEIhK57Qv
 WP2iUxHsikQQUR8Ng6zMAgxSQtTQK03btuI3Y8AmynUp9Kb5qYq39E0mlJROkdXc
 sfqgsQ2OnoP91+fDle0d5mwc2DldyJn3Cp41QYWfc5deDWGve2Wp9WjACN3WqiOy
 PD6+LjMV7j76aoy8nq0LTfHGf0Xn7A+jmi3Kri6AUYAtJ4SJDSyNXireENO0u7/E
 Q275AbLLPLwJcrmbs75dHcBKbO9kdWyBMDwntJuWk7IZ2DgeCCIAZDu589iSnqR2
 qZzt4pvsox3g+ovIWZ9tOJoZbk+WhnKnmYLwiQS022zH7x9gua7q1QWdhkOl9VrX
 rXQ0ow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epxuvj022-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:46:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178aed25baso137777921cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781091989; x=1781696789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TMlog90bAeJhxIBbGMEF0MinoG4m7UeAMGnZoM2AxWg=;
 b=Ztk3vmaN77KtST4LjKj2JVJ+uXqtvqgETpbwjmGdzr/LD9iMscKVGknCfYMx44LXGe
 NIwY7XXWVo791U34y/1fFeOkaxb0uVbW8sHlKGLIZzU8hg3IB76SIIlj8DKQwOvJHDRS
 US8V28Oy+1+cildzu8k46AfOUg5J9nBF6bQhfjyf/y1szSDLChXngbDH5e6+P5Nb6tu0
 2wfmOxKIw4uC23AsYuampfZKROsBmTeGU5llaGOALH6/XapNikg6TT0neKuyQC6JkwYl
 F8Hw7FWyxlBVH8/H+cbC/qwycVQmtVOfWHK1vQIY5WZBqfAJcfM5Fkj1rzqLPIhpo47A
 Zyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091989; x=1781696789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TMlog90bAeJhxIBbGMEF0MinoG4m7UeAMGnZoM2AxWg=;
 b=KqD5zapM/psMUaSz7cJ32qQP4xpTR62+0CJFnJNe3/ykvQyIKYs4LvfEJApsnU1oXZ
 H11qxxDTepimyFU32FSBnQuJeQchGLzbq+t5RdvRI4FFEcwyDbe5wtM5/k/ybmrwx15n
 /DFQ9GgSDQIn8MdYAw8xFJOGwZTs/GNhfZ4NoPk6joRsK0NkXtwGhgLelHk1bf+UfmdM
 n0z/HCp/Da9QdD0UGs2mRrFrex6NoK5kqOsEnLg4ysJc0E86nKDkM72CfKNtEgsA3YpA
 GSfKPw5Z6zxqhwLCR2INQTMu5mMesMAqqDlIGxGCr2eN9tpbLtvcCDMyscXtgHgT/+nN
 Du8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ms2GaYGss4C5mf17ELugQGEPHSmTiGLLBEPq/+7sG8R6HcXHCpo/mFOHpxhCTgwMl1PUM94rsi+09@nongnu.org
X-Gm-Message-State: AOJu0YwqoteEI0KhpNYl9mLBstkzaJ+7d9xOnV2UJIipcaJhPz7w6SEB
 WtGgx5G/xnFB/hcoLtHVk5zaShsg6lOLjFDA79503su50OrtOIs0mNIABMf+cdVHcTLn9UqQYVO
 Tj1/VK3fm0aIfCtOUrxp/nGEMQabKioxASQuP3IeVXIOh5ApbyqxeGzahXg==
X-Gm-Gg: Acq92OEo+Dy0/2blKqFi9zSMiN2rObbb4hhRKTmBWwnh3I9/9Xp/Vvv9iM/+MFzxsoW
 NOAfl00g+NaF18Q9sreT3S+0PT1FViU/6Ee8Vx8AKui2f67N0ktL238MTll9CYdf5DUjxwfh19P
 G7kTzI7fNE8GazDj3EgvpY4Qs2EsxUG43klO+ZIyiRGPGk9WGzY/lrLqlycVRAmiwOR47fE9eOP
 CQxgNLLECAvN1JODeTNlqK+re6k+iPMqG5gY/tiJPfp61mjJiEke9AtXmvWCNkjBd0VMCbyXJWK
 yPl0r6VyFDetlaOwcHX9dzk9gPo/X7+83MN2zDCvo71mQBTmBNH4OGr3BXxLZ0Dmx2fHVyeEs8Q
 ure+NtWADXVU0EFCX1MebORUg5/fIy4pSvGOSgbs59a545ABCTmZvfXVG18dKs4wz5ugfB7HSw8
 vAj+o=
X-Received: by 2002:a05:622a:7911:b0:517:8069:8b07 with SMTP id
 d75a77b69052e-51795b6dc71mr258320791cf.29.1781091988540; 
 Wed, 10 Jun 2026 04:46:28 -0700 (PDT)
X-Received: by 2002:a05:622a:7911:b0:517:8069:8b07 with SMTP id
 d75a77b69052e-51795b6dc71mr258320351cf.29.1781091987965; 
 Wed, 10 Jun 2026 04:46:27 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055307a35sm1173498966b.52.2026.06.10.04.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:46:26 -0700 (PDT)
Message-ID: <ad198b72-e66f-4aae-943e-93c695d8d6a0@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] hw/input: keep QemuInputHandlerState in adb-kbd
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-12-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-12-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O9BZOcS-AfwrGQSGxRgqU56YtcLn_101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX+w/JMfrRj5GO
 hArOR2Jv+SuF14Cl/sDz3+KE3vEBLS+07NZJ/s1xSp1Eg0uyoO0qBhlJphlMscPXZLgjOfhdj96
 o/68ddirgEGE5MdnHcJAQifvqzmFEogE4w+nV9uQ95+4AheVDTuo9A1rEQPtjUyaEXyLXvyhFpw
 QEGE+f7wcR2IoldKKZlCuksws4D6JHm92KDRSZygOPOB34d0pFd9NP/+OXRiV7QxE21u9T0dhJL
 82hR6RUJMdcXM0rKR3OP6KVrViijIXyjxUrPOH2MKd+VxI1sSu0Gp6rxmyfTPjtr4XdtIfvJfjw
 mNfH9xK2sDBQST1O0yR+MJLt0AqdlAPem2YsGDv6QYm5XcHmFiqlguaPHdLYv8ZBZlEQ4iiT4Xo
 yrlTCIzuu1Qlm0yfU5IWcmrMZaCHNArq5Vfcxmfh9+w/qJUPolMojw37FBCq5GXCOQagz6oK8+S
 5bdhQEP+kwa4GuHzh3w==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a294e95 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: O9BZOcS-AfwrGQSGxRgqU56YtcLn_101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100112
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Track the input handled state, and dispose it on unrealize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/input/adb-kbd.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

