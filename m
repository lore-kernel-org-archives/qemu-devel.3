Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3003CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUzx-000050-6o; Fri, 22 May 2026 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzt-0008Vh-I5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUzr-0006lY-7m
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:53:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGanKb1733041
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qr2fBXwtm5EFF+jWer/caM
 8CYNEtFNWLzO+Xp17Z0iY=; b=LREdiEAFNHuvph1B9sKpnHEETcDygtzPJFDWB9
 QVSWxGoKeskg0yL3Gp135v5ODhmBZOaGYBe4PURIV/Y0ZH+8Kd74Nb56f4DvwDUj
 OJm7vq+6E8niUOAzwvmZTyzziOVwSiOjNaDBBrlNYCZjJ633hxoKSoPkVsKpkmqw
 bcaG/Blh3I5twb2KMHt6tnWlxIpdZEFuCabpf8KRlqmK1UU4cyUaqMujmXLxuCOC
 WrMDniWNYn3j//PjKTglbe0wUSxNYeyu5QztqArMvWvdTpeqy1yzdJIWe4/MO9EO
 6nA4X5VrkHTbSFOCmicMjdzCxWBCSaft6ofHMwUfmDwf6VCQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq8gjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:53:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f2d983d109so3749315eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779476001; x=1780080801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qr2fBXwtm5EFF+jWer/caM8CYNEtFNWLzO+Xp17Z0iY=;
 b=HUrEvXzvGKpugIFEZzFpVuhRLTrKQ9nXfg5BFFzoCuqFKa7nh0SEyTFdZdj7n9+AAt
 8O+5ULSvf5crqCy/zviQXa9DXNWlL4FpxGxo6O7DlWnwx7HNNhDA7gCYHGGVmzuPsj3y
 Yog0j/5K903yREBHiYNmFU6Fe8ZeQplvz7eHHL47b5VwNnrKS2mpHzO8Of4VMehuzdIW
 spZfWMfRx12CLCLat2I67eCoTzoz9UL5MYwl7W5JDCI0DK6MAzurvBgl7kiwdiy8Ph3L
 svQmBcotT/7GVuklfd7DGyzKNz3/o/S1615/fawU61KGFa8INI5gNRJcty8VN3+oFbUr
 oRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476001; x=1780080801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2fBXwtm5EFF+jWer/caM8CYNEtFNWLzO+Xp17Z0iY=;
 b=jTGOOCJIECSRFqeitPzlZDtjUI5/0ALRiYmnzNHF/r+ZIr0Jty8CP2oP/NHdlcKpAv
 slnImhV2kxyp0gS+zlw95YsS1Fjn28Fii8XxylAK/XBINIwXmevtCL+vyVzoTy4m00Vt
 zs0CIGVN+R1mEbciMw+sJw+hoLGlFqBI7rUmCs62LOsUuzydfYboTHWH9joiY7/7ZI7E
 xoK6fgZH/ugOOItqeGlkRgtvUX3kOSAcC0dZyZYtYiWLE8s/jVO3kxTf3H3wf1SXNkmC
 izzKC41WOtplyWtEhVC0IqmLM0rLpfU9wuzIFoXS6XTpV9YjijeJsbCKOkLo24vPy6F2
 ZZoA==
X-Gm-Message-State: AOJu0Yxjzqc7n83Ja7giIwmwSP5IsxdtR24K4caE+BHt3uiqNfmc7EjH
 C3+e563ZQy5PYEBJqhOL6+8ItHxqIDzdUyHVb8UTFlYUACwjomJqGiRpHGZ/TC9t9QnbX3yqt6/
 AO8//xbTUNG0OXzvw9Elycs44e3NSehPIpdFXJSmn1TWo69nr0vYakWpo8rsUrAX+Nr+f
X-Gm-Gg: Acq92OGZdyXGciSdHPxa3iebVOnicTb9xyFQWPCe+lQxwlqZwoZJvnqDXrBPsKCwrd6
 QA+CsviGHIuAUWBfeSXyV2vJoevMyAcMpU3B5bkF+xnNjkmcBgMFcOmg09Rm6sSjY4y9GlSEVu6
 ZYlCDkQpZfCuOKOESYi8SdXgto2KaHU+D+fPjbgMegDYOybHXtIAagVX3FGJ/DqZJU/y/d1uMuZ
 pEFjPyRkShqprRGdUxYHtcQ6MaE5+xeY4NZyPx8JvBUuoaqaj1qXBPoIyjt4NhiBPevLZXPzSs+
 FWjzKiGLK/w1nXRvBKPspWE04JmutIlySr7O7mtiG19sdmdk3Zr/Caw3UypC8+v5FA2S5TbKFVq
 OvnIEqoWn8uSeM0k2W+AKLi4MCB/JwEBpbeJgcvaI5oCXEamfCv3ic1AfBrYmVeDHF0s8BTYB4b
 dcEMAufA==
X-Received: by 2002:a05:7301:6003:b0:2c5:60d0:701e with SMTP id
 5a478bee46e88-30448ffd0e8mr2681790eec.3.1779476000511; 
 Fri, 22 May 2026 11:53:20 -0700 (PDT)
X-Received: by 2002:a05:7301:6003:b0:2c5:60d0:701e with SMTP id
 5a478bee46e88-30448ffd0e8mr2681763eec.3.1779475999909; 
 Fri, 22 May 2026 11:53:19 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045225b7b6sm2470502eec.25.2026.05.22.11.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:53:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] Docs update for 2026-05-22
Date: Fri, 22 May 2026 11:53:03 -0700
Message-ID: <20260522185306.4105344-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4OCBTYWx0ZWRfX0rnnsUMSFGf6
 eigYBHmnFgYtM3rmo2IFQ+a/lEtJD7NjxtLcQJsw9RgMexT7T6rrRpaxbcPnvRTO9F1EfU9vGR7
 ROlV8cwiMO+xSm+Co3oC5uDGYfUTjwZ9ERWYz47kdeceAhCAm6q1NMdjHu79rBM7tp0cAywqJpU
 cxYk2xLlfeMEek+1H8jDQQ5l5NbBXrq3J/k8PZ1vmX+xIc3m9U2+2sbURWIbj7bqTgSmh647w32
 BMvT4/wADEJTwRrsGKOjmPfSUT312hKmvuUvNyWN81Tx/L0LG/VsAqsIL/F2jPmjCZ68z0rwzHg
 UzaJfUvnCF/uEpkPy1lv1dMt5lnux3OttvFVUp0AcSqAT9wFT8rDpNbDFWWAyRON/0XqOMBlBj8
 jqUzuOyf6XraonRzRza5roy/26meX95vvnY8tit53o3zzAvPjmYrTPgsQwN8+Mp/x/9jPnde6ab
 qLaPDSYJEM3yqFLkT4Q==
X-Proofpoint-GUID: s27G0YGvxsMopbxa_DVhae7hTKKIbpJy
X-Proofpoint-ORIG-GUID: s27G0YGvxsMopbxa_DVhae7hTKKIbpJy
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10a621 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=-AnQz9JOAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=PzGKxP3WAAAA:8
 a=7hskF5ZkpNGFD0IAr0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=3bnadFWGKyIZm4bBUiDd:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220188
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

The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee544:

  Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into staging (2026-05-21 09:00:22 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260522

for you to fetch changes up to 6a570c504f1bf1b42a3a0eadc8139b7cb1d7b8b8:

  docs/devel: Fix typo (s/exist paths/exit paths/) (2026-05-22 11:52:32 -0700)

----------------------------------------------------------------
Changes:
- [PATCH] docs/code-provenance: Fix formatting of *-by tags (=?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>)
  Link: https://lore.kernel.org/qemu-devel/20260520-prov-v1-1-7a58af334b9c@9elements.com
- [PATCH] docs/devel/qom: Fix some editing errors (=?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>)
  Link: https://lore.kernel.org/qemu-devel/20260520-qom-v1-1-baad87fefe4f@9elements.com
- [PATCH] docs/devel: Fix typo (s/exist paths/exit paths/) (=?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>)
  Link: https://lore.kernel.org/qemu-devel/20260520-exist-v1-1-535f929a87ae@9elements.com

----------------------------------------------------------------
J. Neuschäfer (3):
      docs/code-provenance: Fix formatting of *-by tags
      docs/devel/qom: Fix some editing errors
      docs/devel: Fix typo (s/exist paths/exit paths/)

 docs/devel/code-provenance.rst | 10 +++++-----
 docs/devel/qom.rst             |  4 ++--
 docs/devel/style.rst           |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

